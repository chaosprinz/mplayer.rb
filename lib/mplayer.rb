class MPlayer
  attr_accessor :player_pid,:logfile

  # returns an instance of MPlayer. The fifo-file to control the related mplayer-process is created. Also
  # an mplayer-instance gests startet.
  # 
  # Some Options can be used to describe different asspects of the object.
  # They can be set in the options-hash. Following options are avaiable:
  # * fifo: path to the fifo-file which will be created
  # * logfile: path to a file, where all the std-out and std-err gets stored
  #
  # @param options [Hash] Specifies some options for the mplayer-instance.
  # @return [MPlayer] New MPlayer-object
  def initialize options={fifo: "/tmp/mplayer_rb_#{$$}_fifo",logfile: "/tmp/mplayer_rb_log"}
    @options = options
    self.logfile = File.new(@options[:logfile],"w")
    create_fifo
    start_mplayer
  end

  private

  # creates the fifo-file which will be used to controll the mplayer-instance. It used the path which was
  # specified in the options in #new
  #
  # @return [Fixnum] The process-id of the mkfifo-command
  def create_fifo
    spawn "mkfifo #{@options[:fifo]}", out: self.logfile, err: self.logfile
  end

  # kill_mplayer kills the related mplayer-instance and deletes all created files.
  #
  # @return [Boolean] True if the mplayer-instance-kill-command succeeded
  def kill_mplayer
    self.logfile.close
    [@options[:logfile],@options[:fifo]].each do |file|
      File.delete(file) if File.exists? file
    end
    system "kill -9 #{self.player_pid.to_s}"
  end

  # starts the related mplayer-instance and stores the pid of it in the player_pid-attribute
  #
  # @return [Fixnum] The pid of the related mplayer-instance
  def start_mplayer
    at_exit do
      kill_mplayer
    end

    self.player_pid = spawn("mplayer -slave -idle -quiet -input file=#{@options[:fifo]}", out: self.logfile, err: self.logfile)
  end
end
