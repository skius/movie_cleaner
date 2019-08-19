# movie-cleaner
Removes media files where there already is a higher resolution

## Prerequisites

* ruby
* A movie library with sub-folders per movie containing different quality files of the movie
* Movie files must have the resolution in the filename (e.g. `It (2017) - 1080p.mkv`)

## Usage

`./cmd.rb [options]` 

| option | description | example |
|-|-| - |
|`-v`| verbose - omitting this results in a completely `\| bash`-able output of `rm` commands. | |
|`-d,--directory DIRECTORY`| Directory which contains all other movie folders | `-d /home/user/media/movies` |
|`-r,--resolutions res1,res2`| Comma-separated list of resolutions in order of priority | `-r 1080p,720p` |
