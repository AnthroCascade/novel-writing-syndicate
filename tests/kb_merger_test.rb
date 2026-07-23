# ruby tests/kb_merger_test.rb
require 'minitest/autorun'
require 'tmpdir'
require_relative '../src/kb_merger'

class KbMergerTest < Minitest::Test
  def setup
    @root = Dir.mktmpdir('kb')
    @merger = KbMerger.new(@root)
  end

  def teardown = FileUtils.rm_rf(@root)

  def read(file) = File.read(File.join(@root, file))

  # -- atomic files & index --------------------------------------------------

  def test_ensure_atomic_creates_slug_file_and_index_entry
    slug = @merger.ensure_atomic('characters', 'Betty Lee')

    assert_equal 'betty-lee', slug
    assert_match(/# Betty Lee/, read('characters/betty-lee.md'))
    assert_match(/- \[\[betty-lee\]\] — Betty Lee/, read('characters/_index.md'))
  end

  def test_ensure_atomic_never_makes_a_second_file_or_index_entry
    2.times { @merger.ensure_atomic('characters', 'Betty Lee') }

    assert_equal 1, read('characters/_index.md').scan('betty-lee').size
  end

  def test_index_entries_insert_alphabetically
    @merger.ensure_atomic('characters', 'Sarah')
    @merger.ensure_atomic('characters', 'Abe')
    @merger.ensure_atomic('characters', 'Chanta')

    listed = read('characters/_index.md').lines.grep(/^- \[\[/).map(&:strip)
    assert_equal ['- [[abe]] — Abe', '- [[chanta]] — Chanta', '- [[sarah]] — Sarah'], listed
  end

  # -- fact dedup ------------------------------------------------------------

  def facts_file
    File.write(File.join(@root, 'facts.md'), <<~MD)
      # Established Facts

      Last updated: 2026-07-20 | Scope: Parts 1–4

      - [[sarah|Sarah]] works in Cyber Security. (scene: "Sarah meets Tony")
    MD
    'facts.md'
  end

  def test_merge_fact_appends_a_new_fact_with_citation
    assert @merger.merge_fact(facts_file, 'Tony attended St Reinhart\'s.', scene: 'Anthony Chantara')
    assert_match(/- Tony attended St Reinhart's\. \(scene: "Anthony Chantara"\)/, read('facts.md'))
  end

  def test_merge_fact_discards_a_duplicate_even_across_wikilink_forms
    refute @merger.merge_fact(facts_file, 'Sarah works in Cyber Security.', scene: 'Later scene')
    assert_equal 1, read('facts.md').scan('Cyber Security').size
  end

  # -- state-progression overwrites ------------------------------------------

  def locations_file
    File.write(File.join(@root, 'object-locations.md'), <<~MD)
      # Object Locations

      Last updated: 2026-07-20 | Scope: Parts 1–4

      | Object | Last known location | Scene | Notes |
      |--------|---------------------|-------|-------|
      | [[gyges-disc|Gyges Disc]] (first) | Tony's van footwell | Emil in the morgue | Immune to gamma radiation. |
    MD
    'object-locations.md'
  end

  def test_upsert_overwrites_state_and_moves_the_old_state_to_history
    result = @merger.upsert_state_row(locations_file, 'Gyges Disc (first)', "Sarah's purse", 'Sarah flees')

    assert_equal :updated, result
    row = read('object-locations.md').lines.find { |l| l.include?('Gyges Disc') }
    assert_match(/\| Sarah's purse \| Sarah flees \|/, row)
    assert_match(/Previously: Tony's van footwell \(Emil in the morgue\)\. Immune to gamma radiation\./, row)
  end

  def test_upsert_inserts_a_row_for_an_unknown_key
    result = @merger.upsert_state_row(locations_file, "Halo's thumb drive", "Chanta's possession", 'Halo Assaults Sarah')

    assert_equal :inserted, result
    assert_match(/\| Halo's thumb drive \| Chanta's possession \| Halo Assaults Sarah \|/, read('object-locations.md'))
  end

  # -- stamps & report -------------------------------------------------------

  def test_stamp_moves_only_the_date_and_keeps_the_scope_tail
    @merger.stamp(facts_file)

    assert_match(/Last updated: #{Date.today.iso8601} \| Scope: Parts 1–4/, read('facts.md'))
  end

  def test_report_counts_new_and_updated_across_files
    @merger.ensure_atomic('characters', 'Betty Lee')
    @merger.merge_fact(facts_file, 'A new fact.', scene: 'Somewhere')
    @merger.upsert_state_row(locations_file, 'Gyges Disc (first)', "Sarah's purse", 'Sarah flees')

    assert_match(/KB updated: 2 new, 2 updated across/, @merger.report)
  end

  def test_paths_never_escape_the_artefacts_root
    assert_raises(ArgumentError) { @merger.merge_fact('../outside.md', 'fact', scene: 's') }
  end
end
