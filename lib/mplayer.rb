class MPlayer
  attr_accessor :player_pid,:logfile

  def initialize options={fifo: "/tmp/mplayer_rb_#{$$}_fifo",logfile: "/tmp/mplayer_rb_log"}
    @options = options
    self.logfile = File.new(@options[:logfile],"w")
    create_fifo
    start_mplayer
  end

  private
  def create_fifo
    spawn "mkfifo #{@options[:fifo]}", out: self.logfile, err: self.logfile
  end

  def kill_mplayer
    system "kill -9 #{self.player_pid.to_s}"
    self.logfile.close
    [@options[:logfile],@options[:fifo]].each do |file|
      File.delete(file) if File.exists? file
    end
  end

  def start_mplayer
    self.player_pid = spawn("mplayer -slave -idle -quiet -input file=#{@options[:fifo]}", out: self.logfile, err: self.logfile)
    at_exit do
      kill_mplayer
    end
  end
end
