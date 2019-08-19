[![Build Status](https://semaphoreci.com/api/v1/skius/movie-cleaner/branches/develop/badge.svg)](https://semaphoreci.com/skius/movie-cleaner)  
# MovieCleaner
Removes media files where there already is a higher resolution

## Prerequisites

* ruby
* A movie library with sub-folders per movie containing different quality files of the movie
* Movie files must have the resolution in the filename (e.g. `It (2017) - 1080p.mkv`)

## Installation

    $ gem install movie_cleaner

## Usage

```
$ movie_cleaner [options]
```

| option | description | example |
|-|-| - |
|`-v`| verbose - omitting this results in a completely `\| bash`-able output of `rm` commands. | |
|`-d,--directory DIRECTORY`| Directory which contains all other movie folders | `-d /home/user/media/movies` |
|`-r,--resolutions res1,res2`| Comma-separated list of resolutions in order of priority | `-r 1080p,720p` |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skius/movie_cleaner.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
