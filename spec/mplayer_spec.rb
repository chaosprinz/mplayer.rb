require 'spec_helper'

describe MPlayer do
  before :each do
    @mplayer = MPlayer.new
  end

  describe "#new" do
    it 'returns a new MPlayer-object' do
      @mplayer.should be_an_instance_of MPlayer
    end

    it 'creates a file, whichs path is described in the fifo-option' do
      fifo_file= @mplayer.instance_variable_get(:@options)[:fifo]
      File.exists?(fifo_file).should be_true
    end

    it 'creates a file, whichs path is described in the logfile-option' do
      logfile = @mplayer.instance_variable_get(:@options)[:logfile]
      File.exists?(logfile).should be_true
    end
  end

  describe "#player_pid" do
    it 'returns a fixnum' do
      @mplayer.player_pid.should be_an_instance_of Fixnum
    end

    it 'returns a pid of a mplayer-process' do
      `pidof mplayer`.should include @mplayer.player_pid.to_s
    end
  end

  describe "#run" do
    it 'sends the given command to the fifo' do
      fifo_file = @mplayer.instance_variable_get(:@options)[:fifo]
      cmd = "stop"
      @mplayer.run cmd
      fifo_stream = File.open(fifo_file)
      data = fifo_stream.read_nonblock(6)
      data.should eql cmd+"\n"
    end
  end

  context "using mplayer-commands as method-calls" do
    it "responds to method-calls which represent a mplayer method" do
      [
        :get_audio_bitrate, 
        :get_audio_codec, 
        :pause, 
        :frame_step, 
        :radio_set_channel,
        :seek_chapter,
        :stop
      ].each do |command|
        @mplayer.should respond_to command
      end
    end

    it "doesnt respond to method-calls which are nonsene" do
      [
        :nonsense,
        :stupid,
        :quirks
      ].each do |nonsense|
        @mplayer.should_not respond_to nonsense.to_sym
      end
    end

    it "sends the command to the related fifo" do
      fifo_file = @mplayer.instance_variable_get(:@options)[:fifo]
      @mplayer.pause
      fifo_stream = File.open(fifo_file)
      data = fifo_stream.read_nonblock(6)
      data.should eql "pause\n"
      @mplayer.stop
      data = fifo_stream.read_nonblock(5)
      data.should eql "stop\n"
    end
  end
end
