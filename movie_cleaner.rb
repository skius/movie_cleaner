# frozen_string_literal: true

require 'optparse'
require 'ostruct'

# MovieCleaner prints commands to remove all unwanted movie files in a directory
class MovieCleaner
  def initialize(base_path, verbose = false, possible_resolutions = nil)
    @base_path = base_path
    @verbose = verbose
    @possible_resolutions = possible_resolutions || %w[1080p 720p]
  end

  def print_sub_par_files
    movie_files.each do |movie, files|
      @possible_resolutions.each do |resolution|
        next unless files.any? { |f| f.include?(resolution) }

        sub_par_files = files.reject { |f| f.include?(resolution) }
        vputs "Found #{resolution} for movie #{movie}"
        print_rm_commands_for_files(movie, sub_par_files)
        vputs ''
        break
      end
    end
  end

  private

  def print_rm_commands_for_files(movie, files)
    files.each do |f|
      puts "rm '#{full_path(movie, f)}'"
    end
  end

  def movie_files
    Dir["#{@base_path}/*"].map do |dir|
      [
        File.basename(dir),
        Dir["#{dir}/*.{mkv,mov,mp4}"].map { |f| File.basename(f) }
      ]
    end
  end

  def full_path(movie, file)
    "#{@base_path}/#{movie}/#{file}"
  end

  def vputs(*args)
    puts args if @verbose
  end
end

options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-v') { |o| options.verbose = o }
  opt.on('-d', '--directory DIRECTORY',
         'The base path for all movie files') { |o| options.base_path = o }
  opt.on('-r', '--resolutions 1080p,720p', Array,
         'The wanted resolutions in order (Default: 1080p,720p') { |o| options.resolutions = o }
end.parse!

m = MovieCleaner.new(options.base_path, options.verbose, options.resolutions)
m.print_sub_par_files
