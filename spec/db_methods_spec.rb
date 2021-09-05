require 'spec_helper'
require_relative '../lib/new_super_codebreaker_2021'
require_relative '../lib/user'

RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }
  let(:user) { User.new('Name', 0) }
  let(:file) { 'rating.yml' }

  context '#save' do
    after do
      File.delete(file)
    end

    it "should create file if it doesn't exist" do
      game.save(user, file)
      expect(File.file?(file)).to eq(true)
    end

    it 'should write user to file' do
      game.save(user, file)
      data = YAML.load_file(file)
      expect(data[0].to_yaml).to eq(user.to_yaml)
    end

    it 'should save the previous users' do
      File.open(file, 'w') do |filename|
        YAML.dump([user], filename)
      end
      game.save(user, file)
      data = YAML.load_file(file)
      expect(data.length).to eq(2)
    end
  end

  context '#load_file' do
    it "should return empty array if file doesn't exist" do
      expect(game.load_file(file)).to be_empty
    end

    it 'should return all users in the file' do
      5.times { game.save(user, file) }
      expect(game.load_file(file).length).to eq(5)
    end
  end
end
