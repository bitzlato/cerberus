require 'rails_helper'


describe SumSub::GenerateUrl do
  describe 'generate link' do
    before do
      described_class.clear_cache
      @user_id = rand(99999)
      stub_websdk_link(user_id: @user_id)
    end

    it 'ok' do
      klass = described_class.new(user_id: @user_id)
      url = klass.call
      expect(url.include? 'https://api.sumsub.com/idensic/').to be true
    end
  end

  describe 'cache url' do
    before do
      @user_id = rand(99999)
      stub_websdk_link(user_id: @user_id)
    end
    it 'ok' do
      described_class.clear_cache
      generate_url =  described_class.new(user_id: @user_id)
      url1 = generate_url.call

      stub_websdk_link(user_id: @user_id)
      generate_url =  described_class.new(user_id: @user_id)
      url2 = generate_url.call
      expect(url1).to eq(url2)

      described_class.clear_cache
      stub_websdk_link(user_id: @user_id)
      generate_url =  described_class.new(user_id: @user_id)
      url3 = generate_url.call
      expect(url2).not_to eq(url3)

      Timecop.travel(Time.now+described_class::CACHE_TIME)
      stub_websdk_link(user_id: @user_id)
      generate_url =  described_class.new(user_id: @user_id)
      url4 = generate_url.call
      expect(url3).not_to eq(url4)
    end

  end
end
