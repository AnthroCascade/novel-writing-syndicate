#!/usr/bin/env ruby
# read — deterministic implementation of commands/read.md (Track E, E2 first wave).
# Read-only navigation: resolve scope, convert content, present. Nothing written.
#
#   ruby commands/read.rb scene "Title"      [--project <dir-or-.scriv>]
#   ruby commands/read.rb chapter "Title"    [--project ...]
#   ruby commands/read.rb part "Title"       [--project ...]
#
# Settlement (exit 0): requested content displayed with metadata.

require 'optparse'
require_relative '../src/scrivener_project'

class Read
  def initialize(project, scope, title)
    @project = project
    @target = project.resolve(scope, title)
    @scope = scope
  end

  def present
    scenes = @target.text? ? [@target] : @target.scenes
    puts "## #{@target.title} (#{@scope})"
    print_distribution(scenes) unless @target.text?
    scenes.each { |scene| present_scene(scene) }
  end

  private

  def print_distribution(scenes)
    distribution = scenes.group_by(&:status).map { |status, group| "#{status}: #{group.size}" }.join(' · ')
    puts "#{scenes.size} scenes — #{distribution}"
    puts
  end

  def present_scene(scene)
    puts "### #{scene.title}"
    puts metadata_line(scene)
    section('Synopsis', @project.synopsis(scene))
    section('Notes', @project.notes(scene))
    section('Content', @project.content(scene))
    puts
  end

  def metadata_line(scene)
    compile = scene.include_in_compile ? 'in compile' : 'not in compile'
    "_#{scene.location} · #{scene.status} · #{scene.label || 'unlabelled'} · #{compile}_"
  end

  def section(heading, text)
    return if text.nil? || text.empty?
    puts
    puts "**#{heading}**"
    puts
    puts text
  end
end

if __FILE__ == $PROGRAM_NAME
  options = { project: Dir.pwd }
  OptionParser.new do |o|
    o.on('--project PATH', 'project directory or .scriv bundle') { |v| options[:project] = v }
  end.parse!

  scope, title = ARGV
  abort 'read: scope required — scene|chapter|part <title>' unless scope
  abort "read: title required for #{scope} scope" if title.to_s.empty? && scope != 'manuscript'

  bundle = options[:project].end_with?('.scriv') ? options[:project] : ScrivenerProject.locate(options[:project])
  Read.new(ScrivenerProject.new(bundle), scope, title).present
end
