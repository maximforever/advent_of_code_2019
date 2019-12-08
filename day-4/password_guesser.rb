class PasswordGuesser
  def initialize(min, max)
    @min = min
    @max = max
  end

  def possible_numbers
    possible_numbers = [].tap do |eligible_numbers|
      for num in @min..@max do 
        number = Number.new(num)
        eligible_numbers << num if number.eligible?
      end
    end

    return possible_numbers.length
  end
end

class Number
  def initialize(number)
    @number = number
  end

  def has_increasing_digits?
    previous_digit = 0

    digit_array.each do |digit|
      return false if digit < previous_digit
      previous_digit = digit
    end

    true
  end

  def digit_array
    @number.to_s.chars.map(&:to_i)
  end

  def has_two_adjacent_digits?
    previous_digit = 0

    digit_array.each do |digit|
      return true if digit == previous_digit
      previous_digit = digit
    end

    false
  end

  def has_exactly_two_adjacent_digits?
    previous_digit = 0

    digit_array.each do |digit|
      return true if digit == previous_digit && exactly_two_matching_digits(digit)
      previous_digit = digit
    end

    false
  end

  def has_6_digits?
    return digit_array.length == 6
  end

  def exactly_two_matching_digits(digit)
    digit_array.count(digit) == 2 ? true : false
  end

  def eligible?
    has_6_digits? && has_increasing_digits? && has_exactly_two_adjacent_digits?
  end
end

p = PasswordGuesser.new(402328, 864247).possible_numbers