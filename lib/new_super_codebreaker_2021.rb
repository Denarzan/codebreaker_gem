# frozen_string_literal: true

require "yaml"
require_relative "new_super_codebreaker_2021/version"
require_relative "validate"
require_relative "show_content"
require_relative "db_methods"
require_relative "user"

module NewSuperCodebreaker2021
  class Error < StandardError; end

  class Game
    include Validate
    include ShowContent
    include DBMethods
    def chose_com(command)
      case command
      when "start" then :start
      when "rules" then :rules
      when "stats" then :stats
      when "exit" then :exit
      else false
      end
    end

    def take_name(input_name)
      if input_name == "exit"
        :exit
      else
        validate_name(input_name)
      end
    end

    def chose_difficulty(difficulty)
      case difficulty
      when "easy" then :easy
      when "medium" then :medium
      when "hell" then :hell
      when "exit" then :exit
      else
        false
      end
    end

    def generate_code
      Array.new(4) { rand(1..6) }
    end

    def user_guess(code)
      case code
      when "exit" then :exit
      when "hint" then :hint
      when "rules" then :rules
      else validate_user_code(code)
      end
    end

    def take_hint(user, code, used_hints)
      if user.hints_total > user.hints_used
        user.hints_used += 1
        used_hints.each { |hint| code.delete(hint) }
        code.sample
      else
        false
      end
    end

    def after_game_commands(command)
      case command
      when "start" then :start
      when "save" then :save
      when "exit" then :exit
      else false
      end
    end

    def attempt_to_start(command)
      case command
      when "yes" then :yes
      when "no" then :no
      else false
      end
    end

    def compare_codes(secret_code, user_code)
      matches, u_char = number_on_right_place(secret_code, user_code)
      number_in_secret_code(secret_code, user_code, matches, u_char)
    end

    private

    def number_on_right_place(secret_code, user_code)
      matches = []
      u_char = []
      user_code.each_index do |i|
        if secret_code[i] == user_code[i]
          matches.unshift("+")
          u_char << user_code[i]
        end
      end
      [matches, u_char]
    end

    def number_in_secret_code(secret_code, user_code, matches, u_char)
      user_code.each do |element|
        matches.push("-") if secret_code.include?(element) && !u_char.include?(element)
      end
      matches
    end
  end
end
