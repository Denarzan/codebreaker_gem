RSpec.describe NewSuperCodebreaker2021::User do
  let(:user0) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 0) }
  let(:user1) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 1) }
  let(:user2) { NewSuperCodebreaker2021::User.new(FFaker::Name.name, 2) }
  context '#initialize' do
    it 'sets attempts and hints automatically' do
      expect(defined? user0.attempts_total).to eq('method')
      expect(defined? user0.hints_total).to eq('method')
    end

    it 'sets attempts to 15 and hints to 2 at 0 level' do
      expect(user0.attempts_total).to eq(15)
      expect(user0.hints_total).to eq(2)
    end

    it 'sets attempts to 10 and hints to 1 at 1 level' do
      expect(user1.attempts_total).to eq(10)
      expect(user1.hints_total).to eq(1)
    end

    it 'sets attempts to 5 and hints to 1 at 2 level' do
      expect(user2.attempts_total).to eq(5)
      expect(user2.hints_total).to eq(1)
    end

    it 'sets used attempts and hints to 0 at the beginning' do
      expect(user0.attempts_used).to eq(0)
      expect(user0.hints_used).to eq(0)
    end

    it 'can change used attempts and hints' do
      attempts_before = user0.attempts_used
      hints_before = user0.hints_used
      attempts_after = user0.attempts_used += 3
      hints_after = user0.hints_used += 1
      expect(attempts_before).to be < attempts_after
      expect(hints_before).to be < hints_after
    end

    it "can't change other fields" do
      expect { user0.attempts_total += 1 }.to raise_error(NoMethodError)
      expect { user0.name = 'John' }.to raise_error(NoMethodError)
    end
  end
end
