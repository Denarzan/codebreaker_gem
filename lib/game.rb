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
      @code_copy = @code.dup
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
      return validate_user_code(code) unless code.to_i.zero?

      symbol_code = code.to_sym
      GUESS_COMMANDS.include?(symbol_code) ? symbol_code : false
    end

    def take_hint(user, used_hints)
      if user.hints_total > user.hints_used
        user.hints_used += 1
        used_hints.each { |hint| @code_copy.delete(hint) }
        @code_copy.sample
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
      matches, unnecessary_numbers = number_on_right_place(user_code)
      number_in_secret_code(user_code, matches, unnecessary_numbers)
    end

    private

    def number_on_right_place(user_code)
      matches = []
      unnecessary_numbers = []
      user_code.each_index do |i|
        if @code[i] == user_code[i]
          matches.unshift('+')
          unnecessary_numbers << user_code[i]
        end
      end
      [matches, unnecessary_numbers]
    end

    def number_in_secret_code(user_code, matches, unnecessary_numbers)
      user_code.each do |element|
        matches.push('-') if @code.include?(element) && !unnecessary_numbers.include?(element)
      end
      matches
    end

    def generate_code
      Array.new(4) { rand(1..6) }
    end
  end
end
