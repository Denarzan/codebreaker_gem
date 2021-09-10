require 'spec_helper'
require_relative '../lib/new_super_codebreaker_2021'
require_relative '../lib/user'

RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }
  let(:file) { 'test.yml' }

  after do
    File.delete(file) if File.file?(file)
  end

  context '#show_stats' do
    it 'should return sorted statistic by difficult, used attempts and used hints' do
      user1 = User.new('User1', 0)
      user2 = User.new('User2', 0)
      user2.attempts_used += 5
      user3 = User.new('User3', 2)
      game.save(user1, file)
      game.save(user2, file)
      game.save(user3, file)
      expect(game.show_stats(file).map(&:name)).to eq([user3.name, user1.name, user2.name])
    end

    it 'should return empty array if no any statistic' do
      expect(game.show_stats(file)).to be_empty
    end
  end
end
