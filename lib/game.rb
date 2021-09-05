require 'yaml'
require_relative 'validate'
require_relative 'show_content'
require_relative 'db_methods'
require_relative 'user'
module NewSuperCodebreaker2021
  class Game
    include Validate
    include ShowContent
    include DBMethods

    START_COMMANDS = %i[start rules stats exit].freeze
    DIFFICULTY_COMMANDS = %i[easy medium hell exit].freeze
    GUESS_COMMANDS = %i[hint rules exit].freeze
    AFTER_GAME_COMMANDS = %i[start save exit].freeze
    YES_NO_COMMANDS = %i[yes no].freeze

    def chose_command(command)
      START_COMMANDS.include?(command.to_sym) ? command.to_sym : false
    end

    def take_name(input_name)
      if input_name == 'exit'
        :exit
      else
        validate_name(input_name)
      end
    end

    def chose_difficulty(difficulty)
      DIFFICULTY_COMMANDS.include?(difficulty.to_sym) ? difficulty.to_sym : false
    end

    def generate_code
      Array.new(4) { rand(1..6) }
    end

    def user_guess(code)
      if code.to_i != 0
        validate_user_code(code)
      elsif GUESS_COMMANDS.include?(code.to_sym)
        code.to_sym
      else false
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
      if command.to_i.zero? && AFTER_GAME_COMMANDS.include?(command.to_sym)
        command.to_sym
      else false
      end
    end

    def attempt_to_start(command)
      if command.to_i.zero? && YES_NO_COMMANDS.include?(command.to_sym)
        command.to_sym
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
          matches.unshift('+')
          u_char << user_code[i]
        end
      end
      [matches, u_char]
    end

    def number_in_secret_code(secret_code, user_code, matches, u_char)
      user_code.each do |element|
        matches.push('-') if secret_code.include?(element) && !u_char.include?(element)
      end
      matches
    end
  end
end
