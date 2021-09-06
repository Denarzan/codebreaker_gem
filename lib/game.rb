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

    def initialize
      @code = generate_code
    end

    GUESS_COMMANDS = %i[hint rules exit].freeze
    START_COMMANDS = %i[start rules stats exit].freeze
    DIFFICULTY_COMMANDS = %i[easy medium hell exit].freeze
    AFTER_GAME_COMMANDS = %i[start save exit].freeze
    YES_NO_COMMANDS = %i[yes no].freeze

    def chose_command(command)
      check_input(command, START_COMMANDS)
    end

    def take_name(input_name)
      if input_name == 'exit'
        :exit
      else
        validate_name(input_name)
      end
    end

    def chose_difficulty(difficulty)
      check_input(difficulty, DIFFICULTY_COMMANDS)
    end

    def user_guess(code)
      if code.to_i != 0
        validate_user_code(code)
      elsif GUESS_COMMANDS.include?(code.to_sym)
        code.to_sym
      else false
      end
    end

    def take_hint(user, used_hints)
      code_copy = @code.dup
      if user.hints_total > user.hints_used
        user.hints_used += 1
        used_hints.each { |hint| code_copy.delete(hint) }
        code_copy.sample
      else
        false
      end
    end

    def after_game_commands(command)
      check_input(command, AFTER_GAME_COMMANDS)
    end

    def attempt_to_start(command)
      check_input(command, YES_NO_COMMANDS)
    end

    def compare_codes(user_code)
      matches, u_char = number_on_right_place(user_code)
      number_in_secret_code(user_code, matches, u_char)
    end

    private

    def number_on_right_place(user_code)
      matches = []
      u_char = []
      user_code.each_index do |i|
        if @code[i] == user_code[i]
          matches.unshift('+')
          u_char << user_code[i]
        end
      end
      [matches, u_char]
    end

    def number_in_secret_code(user_code, matches, u_char)
      user_code.each do |element|
        matches.push('-') if @code.include?(element) && !u_char.include?(element)
      end
      matches
    end

    def generate_code
      Array.new(4) { rand(1..6) }
    end
  end
end
