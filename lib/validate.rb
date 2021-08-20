module Validate
  def validate_name(name)
    if name.length >= 3 && name.length <= 20
      name
    else
      false
    end
  end

  def validate_user_code(us_code)
    arr_code = check_splitting(us_code)
    if arr_code && check_length?(arr_code) && check_numbers?(arr_code)
      arr_code
    else
      false
    end
  end

  private

  def check_splitting(code)
    code.chars.map!(&:to_i) if integer?(code)
  end

  def integer?(code)
    code.to_i.to_s == code
  end

  def check_length?(code)
    code.length == 4
  end

  def check_numbers?(code)
    code.each do |number|
      return false if number < 1 || number > 6
    end
    true
  end
end
