# frozen_string_literal: true

require 'optparse'
require 'ostruct'

require_relative 'lib/movie_cleaner'

options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-v') { |o| options.verbose = o }
  opt.on('-d', '--directory DIRECTORY',
         'The base path for all movie files') { |o| options.base_path = o }
  opt.on('-r', '--resolutions 1080p,720p', Array,
         'The wanted resolutions in order (Default: 1080p,720p') { |o| options.resolutions = o }
end.parse!

m = MovieCleaner.new(options.base_path, options.verbose, options.resolutions)
p m.sub_par_files
m.print_rm_commands
