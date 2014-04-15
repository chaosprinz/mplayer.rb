Gem::Specification.new do |s|
  s.name = "mplayer.rb"
  s.version = "0.0.1"
  s.date = "2014-04-15"
  s.summary = "Ruby-library for the great mplayer using its slave-protocol"
  s.description = "Just create a new MPlayer-object with something like mp=MPlayer.new. An mplayer-instance and a fifo-file, which controlls it will be created.\nNow you can run mplayer-commands simply by running their names as methods of this object or you can call the run-method.\nFor forther description see http://github.com/chaosprinz/mplayer.rb"
  s.authors = ["Siegfried Dünkel"]
  s.email = "chaosprinz76@googlemail.com"
  s.files = ["lib/mplayer.rb","lib/mplayer_commands.rb"]
  s.homepage = "http://github.com/chaosprinz/mplayer.rb"
  s.license = "MIT"
end
