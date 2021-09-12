require 'spec_helper'
require_relative '../lib/user'

RSpec.describe User do
  context '#initialize' do
    it 'sets attempts and hints automatically' do
      user = User.new(FFaker::Name.name, 1)
      expect(defined? user.attempts_total).to eq('method')
      expect(defined? user.hints_total).to eq('method')
    end

    it 'sets attempts to 15 and hints to 2 at 0 level' do
      user = User.new('User', 0)
      expect(user.attempts_total).to eq(15)
      expect(user.hints_total).to eq(2)
    end

    it 'sets attempts to 10 and hints to 1 at 1 level' do
      user = User.new('User', 1)
      expect(user.attempts_total).to eq(10)
      expect(user.hints_total).to eq(1)
    end

    it 'sets attempts to 5 and hints to 1 at 2 level' do
      user = User.new('User', 2)
      expect(user.attempts_total).to eq(5)
      expect(user.hints_total).to eq(1)
    end

    it 'sets used attempts and hints to 0 at the beginning' do
      user = User.new('User', 2)
      expect(user.attempts_used).to eq(0)
      expect(user.hints_used).to eq(0)
    end

    it 'can change used attempts and hints' do
      user = User.new('User', 0)
      attempts_before = user.attempts_used
      hints_before = user.hints_used
      attempts_after = user.attempts_used += 3
      hints_after = user.hints_used += 1
      expect(attempts_before).to be < attempts_after
      expect(hints_before).to be < hints_after
    end

    it "can't change other fields" do
      user = User.new('User', 0)

      expect { user.attempts_total += 1 }.to raise_error(NoMethodError)
      expect { user.name = 'John' }.to raise_error(NoMethodError)
    end
  end
end
