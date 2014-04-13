# mplayer.rb

With this library its possible to controll the great mplayer with ruby. This is done by using its slave-protocol.

##Usage

Every command, mplayer responds to is avaiable as an instance-method. This is possible through rubys method_missing-magic.

A list of commands can be found at http://www.mplayerhq.hu/DOCS/tech/slave.txt

```ruby
require 'mplayer'

#instanciate an object
player # MPlayer.new

#sending commands to mplayer are simple method-calls
#start a song
player.loadfile '/path/to/song.mp3'
#break playback
player.pause
```

How i told, we just use mplayer slave-protocol. The communication goes through a named pipe (fifo-file). The creation of this fifo and the startup of mplayer is handled when a MPlayer-Instance is created. 

There is also some kind of logfile, which is nothing more than a file where all the stdout and stderr of the mplayer is piped in.

You can controll the path to the this files (the fifo and the logfile) by passing options when you instanciate the MPlayer-Object:

```ruby
require 'mplayer'

#create an object using options
player # MPlayer.new fifo: "/tmp/mysuperfifo",logfile: "/home/me/mysuperlogfile"
```

##TODO

* command-methods should return the correspondending mplayer-response
* methods for commands that need args should always take args
* modulize it
* create some examples

##Contribute

* Fork the project
* Create a feature-branch
* Make your additions and fixes
* Add tests for it
* Send a pull request
* Dont be angry for waiting-time, i'll take a look and work on it, as soon as my time allows

##Copyright

This software is licensed with an MIT-License
Copyright (c) 2014 Siegfried Dünkel. See LICENSE for more details.
