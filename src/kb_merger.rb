#!/usr/bin/env ruby
# KbMerger — the deterministic file surgery of kb-extraction's merge protocol
# (Track E, E2 second wave; talents/kb-extraction/talent.md is the authority).
# The merge mechanics the spec wrote as prose to defend against exactly the
# failure modes scripts don't have: dedup by fact key, state-progression
# overwrites with history preserved, atomic slug files, _index.md wikilink
# maintenance, Last updated stamps, and the merge report.
#
# What stays NL stays out: folding new prose into an existing entry's
# subsections, and timeline chronological placement, are language work — the
# orchestrator does those, then records the result through these operations.
#
#   ruby src/kb_merger.rb --root <artefacts> ensure-atomic <folder> <name>
#   ruby src/kb_merger.rb --root <artefacts> merge-fact <file> <fact> --scene <scene>
#   ruby src/kb_merger.rb --root <artefacts> upsert-state <file> <key> --state <s> --scene <sc> [--note <n>]
#   ruby src/kb_merger.rb --root <artefacts> stamp <file>

require 'date'
require 'fileutils'

class KbMerger
  WIKILINK = /\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/

  def initialize(root)
    @root = File.expand_path(root)
    @new_entries = Hash.new(0)
    @updated_entries = Hash.new(0)
  end

  # -- atomic files & index --------------------------------------------------

  # A character never gets a second file: create the slug file if missing and
  # keep the folder's _index.md wikilink list complete, alphabetically.
  def ensure_atomic(folder, display_name)
    slug = slugify(display_name)
    file = File.join(folder, "#{slug}.md")
    unless exist?(file)
      write(file, "# #{display_name}\n\nLast updated: #{today}\n")
      @new_entries[file] += 1
    end
    index_link(folder, slug, display_name)
    slug
  end

  # -- facts (bullet-list files, established-facts style) --------------------

  # The merge is compactive and the merger is the deduplication authority:
  # a fact whose normalised key already appears is discarded, never appended.
  def merge_fact(file, fact, scene:)
    lines = read(file).lines
    return false if lines.any? { |l| l.start_with?('-') && key(l).include?(key(fact)) }

    write(file, (lines + ["- #{fact.strip} (scene: \"#{scene}\")\n"]).join)
    @new_entries[file] += 1
    true
  end

  # -- state tables (object-locations style) ---------------------------------

  # State progression overwrites: one row per key, current state and latest
  # citation in place, the previous state moved into Notes as history.
  def upsert_state_row(file, row_key, state, scene, note: nil)
    lines = read(file).lines
    index = lines.index { |l| table_row?(l) && key(cells(l).first.to_s) == key(row_key) }
    index ? update_row(file, lines, index, state, scene, note) : insert_row(file, lines, row_key, state, scene, note)
  end

  # -- stamps & report -------------------------------------------------------

  # Only the date moves; the line's scope tail is the author's.
  def stamp(file)
    content = read(file).sub(/^(Last updated:\s*)\S+/) { "#{Regexp.last_match(1)}#{today}" }
    write(file, content)
  end

  def report
    files = (@new_entries.keys + @updated_entries.keys).uniq.sort
    "KB updated: #{@new_entries.values.sum} new, #{@updated_entries.values.sum} updated across #{files.join(', ')}"
  end

  private

  # -- index maintenance -----------------------------------------------------

  def index_link(folder, slug, display_name)
    index = File.join(folder, '_index.md')
    ensure_index(index, folder)
    lines = read(index).lines
    return if lines.any? { |l| l.include?("[[#{slug}]]") }

    write(index, insert_alphabetically(lines, "- [[#{slug}]] — #{display_name}\n").join)
    @updated_entries[index] += 1
  end

  def ensure_index(index, folder)
    return if exist?(index)

    title = folder.split('/').last.split('-').map(&:capitalize).join(' ')
    write(index, "# #{title} Index\nLast updated: #{today}\n\n## #{title}\n")
  end

  def insert_alphabetically(lines, entry)
    entries = lines.each_index.select { |i| lines[i].start_with?('- [[') }
    at = entries.find { |i| lines[i] > entry }
    lines.insert(at || (entries.last ? entries.last + 1 : lines.size), entry)
  end

  # -- table surgery ---------------------------------------------------------

  def update_row(file, lines, index, state, scene, note)
    row = cells(lines[index])
    history = "Previously: #{row[1]} (#{row[2]})."
    notes = [note, history, row[3]].reject { |n| n.to_s.strip.empty? }.join(' ')
    lines[index] = "| #{row[0]} | #{state} | #{scene} | #{notes} |\n"
    write(file, lines.join)
    @updated_entries[file] += 1
    :updated
  end

  def insert_row(file, lines, row_key, state, scene, note)
    last = lines.rindex { |l| table_row?(l) } ||
           raise(ArgumentError, "#{file}: no table to insert into")
    lines.insert(last + 1, "| #{row_key} | #{state} | #{scene} | #{note} |\n")
    write(file, lines.join)
    @new_entries[file] += 1
    :inserted
  end

  def table_row?(line) = line.start_with?('|') && !line.match?(/^\|[\s|:-]+$/) && !header_row?(line)

  def header_row?(line) = cells(line).first.to_s.match?(/\A(Object|Scene|Character)\z/i)

  # Wikilink pipes ([[slug|Display]]) are content, not cell boundaries.
  def cells(line) =
    line.gsub(WIKILINK) { |link| link.tr('|', "") }
        .strip.sub(/\A\|/, '').sub(/\|\z/, '')
        .split('|').map { |cell| cell.tr("", '|').strip }

  # -- normalisation ---------------------------------------------------------

  # Fact keys compare with wikilinks resolved to their display text, case
  # and whitespace folded.
  def key(text) =
    text.sub(/\A-\s*/, '').sub(/\s*\(scenes?:.*\z/m, '')
        .gsub(WIKILINK) { Regexp.last_match(2) || Regexp.last_match(1) }
        .downcase.gsub(/[^a-z0-9]+/, ' ').strip

  def slugify(name) = name.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/\A-|-\z/, '')

  def today = Date.today.iso8601

  # -- io, workspace-bounded -------------------------------------------------

  def path(file)
    full = File.expand_path(File.join(@root, file))
    raise ArgumentError, "#{file} escapes the artefacts root" unless full.start_with?(@root)
    full
  end

  def exist?(file) = File.file?(path(file))

  def read(file) = File.read(path(file))

  def write(file, content)
    FileUtils.mkdir_p(File.dirname(path(file)))
    File.write(path(file), content)
  end
end

if __FILE__ == $PROGRAM_NAME
  require 'optparse'
  options = { root: Dir.pwd }
  parser = OptionParser.new do |o|
    o.on('--root DIR', 'artefacts root') { |v| options[:root] = v }
    o.on('--scene SCENE') { |v| options[:scene] = v }
    o.on('--state STATE') { |v| options[:state] = v }
    o.on('--note NOTE') { |v| options[:note] = v }
  end
  parser.order!
  command, *args = ARGV
  parser.parse!(args)

  merger = KbMerger.new(options[:root])
  case command
  when 'ensure-atomic' then merger.ensure_atomic(args[0], args[1])
  when 'merge-fact' then merger.merge_fact(args[0], args[1], scene: options.fetch(:scene))
  when 'upsert-state' then merger.upsert_state_row(args[0], args[1], options.fetch(:state), options.fetch(:scene), note: options[:note])
  when 'stamp' then merger.stamp(args[0])
  else abort 'kb_merger: ensure-atomic | merge-fact | upsert-state | stamp'
  end
  puts merger.report
end
