require 'spec_helper'
require_relative '../lib/new_super_codebreaker_2021'
require_relative '../lib/user'

RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }

  context '#chose_com' do
    it 'returns start symbol' do
      expect(game.chose_command('start')).to eq(:start)
    end

    it 'returns rules symbol' do
      expect(game.chose_command('rules')).to eq(:rules)
    end

    it 'returns stats symbol' do
      expect(game.chose_command('stats')).to eq(:stats)
    end

    it 'returns exit symbol' do
      expect(game.chose_command('exit')).to eq(:exit)
    end

    it "returns false if bad user's input" do
      expect(game.chose_command('unknown_command')).to eq(false)
    end
  end

  describe '#take_name' do
    it 'returns exit symbol' do
      expect(game.take_name('exit')).to eq(:exit)
    end

    it "return user's name if it's ok" do
      expect(game.take_name('Name')).to eq('Name')
    end

    it "return false is user's name is too short" do
      expect(game.take_name('Ne')).to eq(false)
    end

    it "returns false is user's name is too long" do
      expect(game.take_name('Naaaaaaaaaameeeeeeeeeeeee very long name')).to eq(false)
    end
  end

  context '#chose_difficulty' do
    it 'returns easy symbol' do
      expect(game.chose_difficulty('easy')).to eq(:easy)
    end

    it 'returns medium symbol' do
      expect(game.chose_difficulty('medium')).to eq(:medium)
    end

    it 'returns hell symbol' do
      expect(game.chose_difficulty('hell')).to eq(:hell)
    end

    it 'returns exit symbol' do
      expect(game.chose_difficulty('exit')).to eq(:exit)
    end

    it "returns false if bad user's input" do
      expect(game.chose_difficulty('unknown_command')).to eq(false)
    end
  end

  context '#initialize' do
    it 'should generate array with code' do
      expect(game.instance_variable_get(:@code).is_a?(Array)).to eq(true)
    end
    it 'should have integers in array' do
      expect(game.instance_variable_get(:@code).map { |element| element.is_a? Integer }).to eq([true, true, true, true])
    end

    it 'should create array with length 4' do
      expect(game.instance_variable_get(:@code).length).to eq(4)
    end

    let(:arr) { game.instance_variable_get(:@code) }

    it 'should have numbers between 1 and 6' do
      expect(arr[0]).to be_between(1, 6)
      expect(arr[1]).to be_between(1, 6)
      expect(arr[2]).to be_between(1, 6)
      expect(arr[3]).to be_between(1, 6)
    end
  end

  context '#user_guess' do
    it 'returns hint symbol' do
      expect(game.user_guess('hint')).to eq(:hint)
    end

    it 'returns rules symbol' do
      expect(game.user_guess('rules')).to eq(:rules)
    end

    it 'returns exit symbol' do
      expect(game.user_guess('exit')).to eq(:exit)
    end

    it 'returns false if code is a string' do
      expect(game.user_guess('sdfs')).to eq(false)
    end

    it 'returns false if code is too short' do
      expect(game.user_guess(12)).to eq(false)
    end

    it 'returns false if code is too long' do
      expect(game.user_guess(1_234_567)).to eq(false)
    end
  end

  context '#take_hint' do
    let(:user) { User.new('User1', 1) }
    let(:code) { game.instance_variable_get(:@code) }
    let(:used_hints) { [] }

    it 'returns integer' do
      expect(game.take_hint(user, used_hints).class).to eq(Integer)
    end

    it 'should not change the code' do
      old_code = code
      game.take_hint(user, used_hints)
      expect(code).to eq(old_code)
    end

    it 'returns one number from code' do
      expect(code.include?(game.take_hint(user, used_hints))).to eq(true)
    end

    it 'returns different numbers after 2 hints' do
      hint = game.take_hint(user, used_hints)
      used_hints.push(hint)
      expect(game.take_hint(user, used_hints)).not_to eq(hint)
    end

    it 'increases used hints at user' do
      hints_before_test = user.hints_used
      game.take_hint(user, used_hints)
      expect(user.hints_used).to be > hints_before_test
    end

    it 'returns false if user have used all hints' do
      game.take_hint(user, used_hints)
      game.take_hint(user, used_hints)
      expect(game.take_hint(user, used_hints)).to eq(false)
    end
  end

  context '#compare_codes' do
    before { game.instance_variable_set(:@code, [1, 3, 5, 6]) }
    it 'returns array' do
      user_code = [1, 2, 3, 4]
      expect(game.compare_codes(user_code).class).to eq(Array)
    end

    it 'returns empty array if there is no match' do
      user_code = [2, 4, 4, 2]
      expect(game.compare_codes(user_code)).to be_empty
    end

    it 'returns pluses for each number on the right place' do
      user_code = [2, 3, 6, 5]
      expect(game.compare_codes(user_code).include?('+')).to eq(true)
    end

    it 'returns minuses for each number in secret code but on wrong position' do
      user_code = [3, 1, 5, 6]
      expect(game.compare_codes(user_code).include?('-')).to eq(true)
    end

    it 'returns 4 pluses if user guess the secret code' do
      user_code = [1, 3, 5, 6]
      expect(game.compare_codes(user_code)).to eq(%w[+ + + +])
    end
  end

  context '#after_game_commands' do
    it 'returns save symbol' do
      expect(game.after_game_commands('save')).to eq(:save)
    end

    it 'returns start symbol' do
      expect(game.after_game_commands('start')).to eq(:start)
    end

    it 'returns exit symbol' do
      expect(game.after_game_commands('exit')).to eq(:exit)
    end

    it "returns false if bad user's input" do
      expect(game.after_game_commands('unknown_command')).to eq(false)
    end
  end

  context '#attempt_to_start' do
    it 'returns yes if user wants to start' do
      expect(game.attempt_to_start('yes')).to eq(:yes)
    end

    it 'returns no if user wants to end the game' do
      expect(game.attempt_to_start('no')).to eq(:no)
    end

    it "returns false if bad user's input" do
      expect(game.attempt_to_start('unknown_command')).to eq(false)
    end
  end
end
