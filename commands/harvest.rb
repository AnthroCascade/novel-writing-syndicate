#!/usr/bin/env ruby
# harvest — deterministic implementation of commands/harvest.md (Track E, E2 first wave).
# Surveys unfinished scenes (not yet Second Draft) grouped by what kind of author
# work each requires. Synopses are the extent of content reading. Nothing written,
# nothing ranked — the author reads and feels which ones are ripe.
#
# The one NL residue stays NL: the bespoke "what this scene asks of the author"
# line is language judgment — the script gives the group, the evidence, and the
# synopsis that judgment reads from.
#
#   ruby commands/harvest.rb [part-title] [--project <dir-or-.scriv>] [--json]
#
# Settlement (exit 0): every unfinished scene surveyed with its evidence.

require 'optparse'
require 'json'
require_relative '../src/scrivener_project'

class Harvest
  # StatusID → what kind of author work the scene requires (harvest.md step 5).
  GROUPS = [
    { key: :needs_decision, label: 'Need a decision (Blocked, Out of Place)',
      member: ->(s, _) { [26, 32].include?(s.status_id) } },
    { key: :draftable, label: 'Have a synopsis and could be drafted (To Do with synopsis)',
      member: ->(s, h) { s.status_id == 1 && h.synopsis?(s) } },
    { key: :evaluable, label: 'Have rough prose and could be evaluated (First Draft)',
      member: ->(s, _) { s.status_id == 2 } },
    { key: :needs_attention, label: 'No synopsis (empty To Do — need author attention first)',
      member: ->(s, h) { s.status_id == 1 && !h.synopsis?(s) } },
    { key: :set_aside, label: 'Set aside (Deferred / Incorporated / Backstory)',
      member: ->(s, _) { [29, 30, 31].include?(s.status_id) } },
    { key: :no_status, label: 'No status recorded in the binder',
      member: ->(s, _) { s.status_id.nil? } }
  ].freeze

  def initialize(project, scope_title = nil)
    @project = project
    @scope = scope_title ? project.resolve('part', scope_title) : project.draft_folder
  end

  def survey
    GROUPS.map do |group|
      scenes = unfinished.select { |s| group[:member].call(s, self) }
      { key: group[:key], label: group[:label], scenes: scenes.map { |s| evidence(s) } }
    end
  end

  def synopsis?(scene) = !@project.synopsis(scene).to_s.empty?

  private

  def unfinished
    @unfinished ||= @scope.scenes.reject { |s| s.status_id == ScrivenerProject::SECOND_DRAFT }
  end

  def evidence(scene)
    { title: scene.title, location: scene.location, status: scene.status,
      exists: exists(scene), synopsis: @project.synopsis(scene) }
  end

  def exists(scene)
    evidence = []
    evidence << 'synopsis' if synopsis?(scene)
    evidence << 'notes' if @project.notes(scene).to_s.length.positive?
    bytes = @project.content_bytes(scene)
    evidence << "content.rtf (#{bytes / 1024}KB)" if bytes.positive?
    evidence.empty? ? 'nothing yet' : evidence.join(', ')
  end
end

def print_harvest(groups)
  total = groups.sum { |g| g[:scenes].size }
  puts "Harvest — #{total} unfinished scenes"
  groups.each do |group|
    next if group[:scenes].empty?
    puts
    puts "## #{group[:label]} — #{group[:scenes].size}"
    group[:scenes].each do |scene|
      puts
      puts "- **#{scene[:title]}** (#{scene[:location]}) · #{scene[:status]} · has: #{scene[:exists]}"
      puts "  > #{scene[:synopsis].lines.map(&:strip).join(' ')}" if scene[:synopsis] && !scene[:synopsis].empty?
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  options = { project: Dir.pwd, json: false }
  OptionParser.new do |o|
    o.on('--project PATH', 'project directory or .scriv bundle') { |v| options[:project] = v }
    o.on('--json', 'machine-readable harvest') { options[:json] = true }
  end.parse!

  bundle = options[:project].end_with?('.scriv') ? options[:project] : ScrivenerProject.locate(options[:project])
  groups = Harvest.new(ScrivenerProject.new(bundle), ARGV.first).survey
  options[:json] ? puts(JSON.pretty_generate(groups)) : print_harvest(groups)
end
