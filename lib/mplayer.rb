class MPlayer
  attr_accessor :player_pid

  def initialize options={fifo: "/tmp/mplayer_rb_#{$$}"}
    @options = options
    create_fifo
    start_mplayer
  end

  private
  def create_fifo
    system "mkfifo #{@options[:fifo]}"
  end

  def start_mplayer
    self.player_pid = spawn("mplayer -slave -idle -quiet -input file=#{@options[:fifo]}")
  end
end
