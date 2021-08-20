class User
  attr_reader :name, :difficulty, :hints_total, :attempts_total
  attr_accessor :hints_used, :attempts_used

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @hints_used = 0
    @attempts_used = 0
    check_difficulty(difficulty)
  end

  private

  def check_difficulty(difficulty)
    case difficulty
    when 0
      set_total_fields(2, 15)
    when 1
      set_total_fields(1, 10)
    when 2
      set_total_fields(1, 5)
    else
      false
    end
  end

  def set_total_fields(hints_total, attempts_total)
    @hints_total = hints_total
    @attempts_total = attempts_total
  end
end
