#!/usr/bin/env ruby
# map — deterministic implementation of commands/map.md (Track E, E2 first wave).
# Binder metadata only: no content read, no evaluation, nothing written.
#
#   ruby commands/map.rb [--project <dir-or-.scriv>] [--json]
#
# Settlement (exit 0): maturity report delivered for the full manuscript.

require 'optparse'
require 'json'
require_relative '../src/scrivener_project'

class Map
  STATUS_ORDER = [1, 2, 28, 26, 32, 29, 30, 31].freeze

  def initialize(project)
    @project = project
  end

  def report
    scenes = @project.draft_folder.scenes
    { total_scenes: scenes.size,
      by_status: by_status(scenes),
      structure: structure,
      anomalies: anomalies }
  end

  private

  def by_status(scenes)
    groups = scenes.group_by(&:status_id)
    STATUS_ORDER.filter_map do |id|
      items = groups[id] or next
      { status: ScrivenerProject::STATUSES[id], status_id: id, count: items.size,
        scenes: items.map { |s| { title: s.title, location: s.location } } }
    end + unknown_statuses(groups)
  end

  def unknown_statuses(groups)
    (groups.keys - STATUS_ORDER).map do |id|
      { status: id ? "StatusID #{id}" : 'No status recorded', status_id: id, count: groups[id].size,
        scenes: groups[id].map { |s| { title: s.title, location: s.location } } }
    end
  end

  def parts = @project.draft_folder.children.select(&:folder?)

  def structure
    parts.map do |part|
      chapters = part.children.select(&:folder?)
      { part: part.title, chapters: chapters.size, scenes: part.scenes.size,
        per_chapter: chapters.map { |ch| { chapter: ch.title, scenes: ch.scenes.size } } }
    end
  end

  def anomalies
    chapters = parts.flat_map { |p| p.children.select(&:folder?) }
    {
      empty_chapters: chapters.select { |ch| ch.scenes.empty? }.map(&:location),
      single_scene_chapters: chapters.select { |ch| ch.scenes.size == 1 }.map(&:location),
      parts_without_second_draft: parts.reject { |p| p.scenes.any? { |s| s.status_id == ScrivenerProject::SECOND_DRAFT } }
                                       .map(&:title)
    }
  end
end

def print_dashboard(report)
  puts "Manuscript maturity — #{report[:total_scenes]} scenes"
  puts
  puts '| Status | Scenes |'
  puts '|---|---|'
  report[:by_status].each { |g| puts "| #{g[:status]} (#{g[:status_id]}) | #{g[:count]} |" }
  puts
  report[:structure].each do |part|
    puts "#### #{part[:part]} — #{part[:chapters]} chapters · #{part[:scenes]} scenes"
    part[:per_chapter].each { |ch| puts "  - #{ch[:chapter]}: #{ch[:scenes]} scenes" }
  end
  puts
  print_anomalies(report[:anomalies])
end

def print_anomalies(anomalies)
  { empty_chapters: 'Empty chapters',
    single_scene_chapters: 'Chapters with a single scene',
    parts_without_second_draft: 'Parts with no Second Draft scenes' }.each do |key, label|
    items = anomalies[key]
    next if items.empty?
    puts "#{label}:"
    items.each { |i| puts "  - #{i}" }
  end
end

if __FILE__ == $PROGRAM_NAME
  options = { project: Dir.pwd, json: false }
  OptionParser.new do |o|
    o.on('--project PATH', 'project directory or .scriv bundle') { |v| options[:project] = v }
    o.on('--json', 'machine-readable dashboard') { options[:json] = true }
  end.parse!

  bundle = options[:project].end_with?('.scriv') ? options[:project] : ScrivenerProject.locate(options[:project])
  report = Map.new(ScrivenerProject.new(bundle)).report
  options[:json] ? puts(JSON.pretty_generate(report)) : print_dashboard(report)
end
