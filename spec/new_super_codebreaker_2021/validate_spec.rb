RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }

  context '#validate_name' do
    it 'should return name if it is valid' do
      expect(game.validate_name('Nazar')).to eq('Nazar')
      expect(game.validate_name('Abraham Lincoln')).to eq('Abraham Lincoln')
    end

    it 'should return false if name is too short' do
      expect(game.validate_name('Ян')).to be_nil
    end

    it 'should return false if name is too long' do
      expect(game.validate_name('Mega Ultra Giga Super Long Name')).to be_nil
    end
  end

  context '#validate_user_code' do
    it "should return code in array if it's correct" do
      expect(game.validate_user_code('1235')).to eq([1, 2, 3, 5])
      expect(game.validate_user_code('5555')).to eq([5, 5, 5, 5])
    end

    it 'should return false if code with letters' do
      expect(game.validate_user_code('abcd')).to be_nil
      expect(game.validate_user_code('123o')).to be_nil
    end

    it "should return false if length isn't 4" do
      expect(game.validate_user_code('123456789')).to be_nil
      expect(game.validate_user_code('123')).to be_nil
    end

    it "should return false if numbers aren't between 1 and 6" do
      expect(game.validate_user_code('8987')).to be_nil
      expect(game.validate_user_code('1237')).to be_nil
    end
  end
end
