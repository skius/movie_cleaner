# frozen_string_literal: true

# MovieCleaner prints commands to remove all unwanted movie files in a directory
class MovieCleaner
  def initialize(base_path, verbose = false, possible_resolutions = nil)
    @base_path = base_path
    @verbose = verbose
    @possible_resolutions = possible_resolutions || %w[1080p 720p]
  end

  def sub_par_files
    sub_par_files_per_movie.flat_map do |movie, files|
      next if files.empty?

      files.map { |file| full_path(movie, file) }
    end.compact
  end

  def print_rm_commands
    sub_par_files_per_movie.each do |movie, files|
      vputs "Found sub-par files for movie '#{movie}':"
      print_rm_commands_for_files(movie, files)
      vputs ''
    end
  end

  private

  def print_rm_commands_for_files(movie, files)
    files.each do |f|
      puts "rm '#{full_path(movie, f)}'"
    end
  end

  def sub_par_files_per_movie
    movie_files.map do |movie, files|
      current_sub_par_files = []
      @possible_resolutions.each do |resolution|
        next if files.none? { |f| f.include?(resolution) }

        current_sub_par_files = files.reject { |f| f.include?(resolution) }
        break
      end
      next if current_sub_par_files.empty?

      [movie, current_sub_par_files]
    end.compact.to_h
  end

  def movie_files
    @movie_files ||= Dir["#{@base_path}/*"].map do |dir|
      [
        File.basename(dir),
        Dir["#{dir}/*.{mkv,mov,mp4}"].map { |f| File.basename(f) }
      ]
    end.to_h
  end

  def full_path(movie, file)
    "#{@base_path}/#{movie}/#{file}"
  end

  def vputs(*args)
    puts args if @verbose
  end
end
