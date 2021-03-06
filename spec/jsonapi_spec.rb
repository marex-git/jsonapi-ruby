require 'spec_helper'

describe JSONAPI do
  describe JSONAPI do

    let(:this) { JSONAPI::JSONAPI }

    describe :new do
      let(:args) do
        { :username => 'user', :host => 'urmom.com', :port => '20058' }
      end

      it 'should instantiate' do
        proc { this.new }.should_not raise_error
      end

      it 'should take a username, password, etc.' do
        api = this.new(args)
        args.each { |arg, val| api.send(arg).should == val }
      end

      it 'should also use a block' do
        api = this.new do |a|
          a.username = args[:username]
          a.password = args[:password]
          a.host = args[:host]
          a.port = args[:port]
        end

        args.each { |arg, val| api.send(arg).should == val }
      end
    end

    describe :call_api do
      before(:each) do
        my_args = {
          :username => 'bkreeger',
          :password => 'buttmonkey',
          :salt => 'thisISaSALT',
        }
        @api = this.new(my_args)
      end

      it "should call the API successfully" do
        method = 'getBukkitVersion'
        result = @api.call_api method
        result.should begin_with('1.2.5')

        method = 'getOfflinePlayerNames'
        result = @api.call_api method
        result.should be_a(Array)
        result.length.should > 0
      end
    end

    describe :generate_methods do
      before(:each) do
        my_args = {
          :username => 'bkreeger',
          :password => 'buttmonkey',
          :salt => 'thisISaSALT',
        }
        @api = this.new(my_args)
      end

      it 'should assign methods to the caller' do
        result = @api.send(:generate_methods)
        players = @api.get_offline_player('benkreeger')
        players.should be_a(Array)
        puts players
      end
    end

  end
end
