# frozen_string_literal: true

require 'movie_cleaner'

RSpec.describe MovieCleaner do
  describe '#sub_par_files' do
    let(:movie_cleaner) { described_class.new(base_path, false, checked_resolutions) }
    let(:base_path) { '/test/path' }
    let(:checked_resolutions) { %w[720p 480p] }
    let(:possible_resolutions) { %w[1080p 720p 480p] }
    let(:fake_movies) do
      100.times.map do |i|
        "#{base_path}/Movie #{i}"
      end
    end
    let(:expected_sub_par_files) do
      sub_par_resolutions = possible_resolutions.reject { |res| res == checked_resolutions.first }
      fake_movies.flat_map do |movie|
        fake_files = []
        sub_par_resolutions.each do |resolution|
          fake_files.append "#{movie}/VerA #{resolution}.mkv"
          fake_files.append "#{movie}/VerB #{resolution}.mkv"
        end
        fake_files
      end
    end

    before do
      allow(Dir).to receive(:[]).with("#{base_path}/*").and_return(fake_movies)
      fake_movies.each do |movie|
        fake_files = []
        possible_resolutions.each do |resolution|
          fake_files.append "#{movie}/VerA #{resolution}.mkv"
          fake_files.append "#{movie}/VerB #{resolution}.mkv"
        end
        allow(Dir).to receive(:[]).with("#{movie}/*.{mkv,mov,mp4}").and_return(fake_files)
      end
    end

    it 'returns the correct sub par movie files' do
      expect(movie_cleaner.sub_par_files).to eq expected_sub_par_files
    end
  end
end
