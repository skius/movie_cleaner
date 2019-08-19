# frozen_string_literal: true

require 'movie_cleaner'

RSpec.describe MovieCleaner do
  it 'has a version number' do
    expect(MovieCleaner::VERSION).not_to be nil
  end
end
