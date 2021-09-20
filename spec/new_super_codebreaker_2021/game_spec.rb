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
      expect(game.code).to be_a Array
    end
    it 'should have integers in array' do
      expect(game.code).to all be_a Integer
    end

    it 'should create array with length 4' do
      expect(game.code.length).to eq(4)
    end

    let(:arr) { game.code }

    it 'should have numbers between 1 and 6' do
      expect(arr).to all be_between(1, 6).inclusive
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
    let(:code) { game.code }
    let(:used_hints) { [] }
    let(:hint) { game.take_hint(user, used_hints) }
    let(:hints_before_test) { user.hints_used }

    it 'returns integer' do
      expect(hint).to be_a Integer
    end

    it 'should not change the code' do
      old_code = code
      game.take_hint(user, used_hints)
      expect(code).to eq(old_code)
    end

    it 'returns one number from code' do
      expect(code).to include(hint)
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
    let(:game_double) { instance_double(NewSuperCodebreaker2021::Game) }

    context 'test compares with array examples' do
      Helper::ARRAY_EXAMPLES.each do |item|
        it "when result is #{item[2]} if code is - #{item[0]}, guess is #{item[1]}" do
          allow_any_instance_of(NewSuperCodebreaker2021::Game).to receive(:generate_code).and_return(item[0])
          guess = item[1]
          expect(game.compare_codes(guess)).to eq item[2]
        end
      end
    end

    context 'test compares with hash examples' do
      Helper::HASH_EXAMPLES.each do |secret_code, user_input|
        it "when result is #{user_input.values[0]} if code is - #{secret_code}, guess is #{user_input.keys[0]}" do
          allow_any_instance_of(NewSuperCodebreaker2021::Game).to receive(:generate_code).and_return(secret_code)
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
