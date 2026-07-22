# ScrivenerProject — the binder parser the specs kept re-describing in prose
# (talents/scrivener-nav/talent.md is the authority). Parses the .scrivx XML,
# resolves scope, reads scene content. Consumed by the command scripts
# (map, read, harvest) that sit beside their definitions in commands/.

require 'rexml/document'

class ScrivenerProject
  LABELS = { 7 => 'Part', 2 => 'Chapter', 4 => 'Scene', 8 => 'Sequel',
             1 => 'Idea', 5 => 'Notes', 6 => 'Character', 9 => 'Narrative' }.freeze
  STATUSES = { 1 => 'To Do', 2 => 'First Draft', 26 => 'Blocked', 28 => 'Second Draft',
               29 => 'Deferred for 2nd Draft', 30 => 'Incorporated in 2nd Draft',
               31 => 'Backstory', 32 => 'Out of Place' }.freeze
  SECOND_DRAFT = 28
  SCRIVENER_MARKERS = /<!?\$Scr[^>]*>/ # <$Scr_Ps::0>, <!$Scr_H::…>, <$ScrKeepWithNextSplittable>, …

  class Item
    attr_reader :uuid, :type, :title, :label_id, :status_id, :include_in_compile, :children
    attr_accessor :parent

    def initialize(uuid:, type:, title:, label_id:, status_id:, include_in_compile:, children:)
      @uuid = uuid
      @type = type
      @title = title
      @label_id = label_id
      @status_id = status_id
      @include_in_compile = include_in_compile
      @children = children
      children.each { |c| c.parent = self }
    end

    def label = ScrivenerProject::LABELS[label_id]

    def status = ScrivenerProject::STATUSES[status_id] || (status_id && "StatusID #{status_id}")

    def text? = type == 'Text'

    def folder? = %w[Folder DraftFolder].include?(type)

    def descendants = children.flat_map { |c| [c] + c.descendants }

    def scenes = descendants.select(&:text?)

    # "Part / Chapter / Scene" — titles from the DraftFolder down.
    def location
      path = []
      node = self
      while node && node.type != 'DraftFolder'
        path.unshift(node.title)
        node = node.parent
      end
      path.join(' / ')
    end
  end

  def self.locate(dir)
    bundle = Dir.glob(File.join(File.expand_path(dir), '*.scriv')).first
    bundle || abort("no .scriv bundle found under #{dir}")
  end

  attr_reader :bundle

  def initialize(bundle)
    @bundle = File.expand_path(bundle)
  end

  def scrivx
    Dir.glob(File.join(bundle, '*.scrivx')).first || abort("no .scrivx binder in #{bundle}")
  end

  def binder
    @binder ||= REXML::Document.new(File.read(scrivx))
                               .elements.to_a('ScrivenerProject/Binder/BinderItem')
                               .map { |e| build_item(e) }
  end

  def draft_folder
    @draft_folder ||= binder.find { |i| i.type == 'DraftFolder' } ||
                      abort('no DraftFolder in binder')
  end

  # Scope resolution per scrivener-nav: case-insensitive, partial when unambiguous.
  # scope: 'manuscript' | 'part' | 'chapter' | 'scene'
  def resolve(scope, title = nil)
    return draft_folder if scope == 'manuscript'
    candidates = scoped_items(scope)
    matches = candidates.select { |i| i.title.downcase.include?(title.to_s.downcase) }
    exact = matches.select { |i| i.title.casecmp?(title.to_s) }
    matches = exact if exact.one?
    abort "no #{scope} matches '#{title}'" if matches.empty?
    abort "ambiguous #{scope} '#{title}': #{matches.map(&:title).join(' | ')}" if matches.size > 1
    matches.first
  end

  def data_dir(item) = File.join(bundle, 'Files', 'Data', item.uuid)

  def content(item)
    rtf = File.join(data_dir(item), 'content.rtf')
    return nil unless File.file?(rtf)
    plain = `textutil -convert txt -stdout #{rtf.inspect} 2>/dev/null`
    plain.gsub(SCRIVENER_MARKERS, '').strip
  end

  def synopsis(item)
    path = File.join(data_dir(item), 'synopsis.txt')
    File.file?(path) ? File.read(path).strip : nil
  end

  def notes(item)
    rtf = File.join(data_dir(item), 'notes.rtf')
    return nil unless File.file?(rtf)
    `textutil -convert txt -stdout #{rtf.inspect} 2>/dev/null`.gsub(SCRIVENER_MARKERS, '').strip
  end

  def content_bytes(item)
    rtf = File.join(data_dir(item), 'content.rtf')
    File.file?(rtf) ? File.size(rtf) : 0
  end

  private

  def scoped_items(scope)
    case scope
    when 'scene' then draft_folder.scenes
    when 'chapter', 'part' then draft_folder.descendants.select(&:folder?)
    else abort "unknown scope '#{scope}' — use scene, chapter, part, or manuscript"
    end
  end

  def build_item(element)
    meta = element.elements['MetaData']
    Item.new(
      uuid: element.attributes['UUID'],
      type: element.attributes['Type'],
      title: element.elements['Title']&.text.to_s,
      label_id: meta&.elements&.[]('LabelID')&.text&.to_i,
      status_id: meta&.elements&.[]('StatusID')&.text&.to_i,
      include_in_compile: meta&.elements&.[]('IncludeInCompile')&.text == 'Yes',
      children: element.elements.to_a('Children/BinderItem').map { |c| build_item(c) }
    )
  end
end
