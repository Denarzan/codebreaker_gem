require 'spec_helper'

RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }
  let(:file) { 'test.yml' }
  let(:user1) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 1) }
  let(:user2) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 0) }
  let(:user3) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 2) }

  after do
    File.delete(file) if File.file?(file)
  end

  context '#show_stats' do
    it 'should return sorted statistic by difficult, used attempts and used hints' do
      user2.attempts_used += 5
      game.save(user1, file)
      game.save(user2, file)
      game.save(user3, file)
      expect(game.show_stats(file).map(&:name)).to eq([user3.name, user1.name, user2.name])
    end

    context 'should return empty array if no any statistic' do
      it { expect(game.show_stats(file)).to be_empty }
    end
  end
end
