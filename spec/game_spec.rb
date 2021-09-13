require 'spec_helper'

MATCHING = { place: '+', presence: '-' }.freeze

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

    it "returns nil if bad user's input" do
      expect(game.chose_command('unknown_command')).to be_nil
    end
  end

  describe '#take_name' do
    it 'returns exit symbol' do
      expect(game.take_name('exit')).to eq(:exit)
    end

    it "return user's name if it's ok" do
      expect(game.take_name('Name')).to eq('Name')
    end

    it "return nil is user's name is too short" do
      expect(game.take_name('Ne')).to be_nil
    end

    it "returns nil is user's name is too long" do
      expect(game.take_name('Naaaaaaaaaameeeeeeeeeeeee very long name')).to be_nil
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

    it "returns nil if bad user's input" do
      expect(game.chose_difficulty('unknown_command')).to be_nil
    end
  end

  context '#initialize' do
    it 'should generate array with code' do
      expect(game.code.is_a?(Array)).to eq(true)
    end
    it 'should have integers in array' do
      expect(game.code.map { |element| element.is_a? Integer }).to eq([true, true, true, true])
    end

    it 'should create array with length 4' do
      expect(game.code.length).to eq(4)
    end

    let(:arr) { game.code }

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

    it 'returns nil if code is a string' do
      expect(game.user_guess('sdfs')).to be_nil
    end

    it 'returns nil if code is too short' do
      expect(game.user_guess(12)).to be_nil
    end

    it 'returns nil if code is too long' do
      expect(game.user_guess(1_234_567)).to be_nil
    end
  end

  context '#take_hint' do
    let(:user) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 0) }
    let(:code) { game.instance_variable_get(:@code) }
    let(:used_hints) { [] }
    let(:hint) { game.take_hint(user, used_hints) }
    let(:hints_before_test) { user.hints_used }

    it 'returns integer' do
      expect(game.take_hint(user, used_hints)).to be_a Integer
    end

    it 'should not change the code' do
      old_code = code
      game.take_hint(user, used_hints)
      expect(code).to eq(old_code)
    end

    it 'returns one number from code' do
      expect(code.include?(game.take_hint(user, used_hints))).to be true
    end

    it 'returns different numbers after 2 hints' do
      used_hints.push(hint)
      expect(game.take_hint(user, used_hints)).not_to eq(hint)
    end

    it 'increases used hints at user' do
      hints_before_test
      game.take_hint(user, used_hints)
      expect(user.hints_used).to be > hints_before_test
    end

    it 'returns nil if user have used all hints' do
      game.take_hint(user, used_hints)
      game.take_hint(user, used_hints)
      expect(game.take_hint(user, used_hints)).to be_nil
    end
  end

  context '#compare_codes' do
    before do
      game.instance_variable_set(:@code, [1, 3, 5, 6])
    end

    context 'test some compares' do
      [
        [[6, 5, 4, 1], [6, 5, 4, 1], %w[+ + + +]],
        [[1, 2, 2, 1], [2, 1, 1, 2], %w[- - - -]],
        [[6, 2, 3, 5], [2, 3, 6, 5], %w[+ - - -]],
        [[1, 2, 3, 4], [4, 3, 2, 1], %w[- - - -]],
        [[1, 2, 3, 4], [1, 2, 3, 5], %w[+ + +]],
        [[1, 2, 3, 4], [5, 4, 3, 1], %w[+ - -]],
        [[1, 2, 3, 4], [1, 5, 2, 4], %w[+ + -]],
        [[1, 2, 3, 4], [4, 3, 2, 6], %w[- - -]],
        [[1, 2, 3, 4], [3, 5, 2, 5], %w[- -]],
        [[1, 2, 3, 4], [5, 6, 1, 2], %w[- -]],
        [[5, 5, 6, 6], [5, 6, 0, 0], %w[+ -]],
        [[1, 2, 3, 4], [6, 2, 5, 4], %w[+ +]],
        [[1, 2, 3, 1], [1, 1, 1, 1], %w[+ +]],
        [[1, 1, 1, 5], [1, 2, 3, 1], %w[+ -]],
        [[1, 2, 3, 4], [4, 2, 5, 5], %w[+ -]],
        [[1, 2, 3, 4], [5, 6, 3, 5], ['+']],
        [[1, 2, 3, 4], [6, 6, 6, 6], []],
        [[1, 2, 3, 4], [2, 5, 5, 2], ['-']]
      ].each do |item|
        it "when result is #{item[2]} if code is - #{item[0]}, guess is #{item[1]}" do
          game.instance_variable_set(:@code, item[0])
          guess = item[1]
          expect(game.compare_codes(guess)).to eq item[2]
        end
      end

      {
        [6, 5, 4, 3] => {
          [5, 6, 4, 3] => [MATCHING[:place], MATCHING[:place], MATCHING[:presence], MATCHING[:presence]],
          [6, 4, 1, 1] => [MATCHING[:place], MATCHING[:presence]],
          [6, 5, 4, 4] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
          [3, 4, 5, 6] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
          [6, 6, 6, 6] => [MATCHING[:place]],
          [2, 6, 6, 6] => [MATCHING[:presence]],
          [2, 2, 2, 2] => []
        },
        [6, 6, 6, 6] => {
          [1, 6, 6, 1] => [MATCHING[:place], MATCHING[:place]],
          [1, 6, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
          [6, 6, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place], MATCHING[:place]],
          [4, 4, 6, 6] => [MATCHING[:place], MATCHING[:place]],
          [6, 4, 6, 6] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]]
        },
        [1, 2, 3, 4] => {
          [3, 1, 2, 4] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
          [4, 3, 2, 1] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
          [1, 2, 3, 5] => [MATCHING[:place], MATCHING[:place], MATCHING[:place]],
          [5, 4, 3, 1] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence]],
          [1, 5, 2, 4] => [MATCHING[:place], MATCHING[:place], MATCHING[:presence]],
          [4, 3, 2, 6] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]],
          [3, 5, 2, 5] => [MATCHING[:presence], MATCHING[:presence]],
          [5, 6, 1, 2] => [MATCHING[:presence], MATCHING[:presence]],
          [6, 2, 5, 4] => [MATCHING[:place], MATCHING[:place]],
          [6, 6, 6, 6] => [],
          [4, 2, 5, 5] => [MATCHING[:place], MATCHING[:presence]],
          [5, 6, 3, 5] => [MATCHING[:place]],
          [2, 5, 5, 2] => [MATCHING[:presence]]
        },
        [6, 5, 4, 1] => {
          [6, 5, 4, 1] => [MATCHING[:place], MATCHING[:place], MATCHING[:place], MATCHING[:place]]
        },
        [1, 2, 2, 1] => {
          [2, 1, 1, 2] => [MATCHING[:presence], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]]
        },
        [6, 2, 3, 5] => {
          [2, 3, 6, 5] => [MATCHING[:place], MATCHING[:presence], MATCHING[:presence], MATCHING[:presence]]
        },
        [5, 5, 6, 6] => {
          [5, 6, 1, 1] => [MATCHING[:place], MATCHING[:presence]]
        },
        [1, 2, 3, 1] => {
          [1, 1, 1, 1] => [MATCHING[:place], MATCHING[:place]]
        },
        [1, 1, 1, 5] => {
          [1, 2, 3, 1] => [MATCHING[:place], MATCHING[:presence]]
        }
      }.each do |secret_code, user_input|
        it "when result is #{user_input.values[0]} if code is - #{secret_code}, guess is #{user_input.keys[0]}" do
          game.instance_variable_set(:@code, secret_code)
          guess = user_input.keys[0]
          expect(game.compare_codes(guess)).to eq user_input.values[0]
        end
      end
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

    it "returns nil if bad user's input" do
      expect(game.after_game_commands('unknown_command')).to be_nil
    end
  end

  context '#attempt_to_start' do
    it 'returns yes if user wants to start' do
      expect(game.attempt_to_start('yes')).to eq(:yes)
    end

    it 'returns no if user wants to end the game' do
      expect(game.attempt_to_start('no')).to eq(:no)
    end

    it "returns nil if bad user's input" do
      expect(game.attempt_to_start('unknown_command')).to be_nil
    end
  end
end
