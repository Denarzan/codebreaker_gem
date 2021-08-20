require "spec_helper"
require_relative "../lib/new_super_codebreaker_2021"
require_relative "../lib/user"

RSpec.describe NewSuperCodebreaker2021::Game do
  let(:game) { described_class.new }
  context "#show_rules" do
    it "should return rules of the game" do
      rules = "Never give up"
      expect(game.show_rules(rules)).to eq("Never give up")
    end
  end

  context "#show_goodbye" do
    it "should return goodbye message" do
      goodbye = "Goodbye"
      expect(game.show_goodbye(goodbye)).to eq("Goodbye")
    end
  end

  context "#show_error" do
    it "should return given error" do
      error = "Error"
      expect(game.show_error(error)).to eq("Error")
    end
  end

  context "#show_stats" do
    let(:file) { "test.yml" }
    it "should return sorted statistic by difficult, used attempts and used hints" do
      user1 = User.new("User1", 0)
      user2 = User.new("User2", 0)
      user2.attempts_used += 5
      user3 = User.new("User3", 2)
      game.save(user1, file)
      game.save(user2, file)
      game.save(user3, file)
      expect(game.show_stats(file).to_yaml).to eq([user3, user1, user2].to_yaml)
      File.delete(file)
    end

    it "should return empty array if no any statistic" do
      expect(game.show_stats(file)).to be_empty
    end
  end
end
