class IntcodeComputer
  def initialize(array)
    @array = array
    @array.any? ? process_opcode_at(0) : end_program
  end

  def process_opcode_at(position)
    op_code = @array[position]

    case op_code
    when 1
      add_at(determine_positons(position + 1, position + 2, position + 3))
      determine_next_instruction(position)
    when 2
      multiply_at(determine_positons(position + 1, position + 2, position + 3))
      determine_next_instruction(position)
    when 99
     end_program
    else
      puts "Invalid OpCode #{@op_code}."
    end

  end

  def add_at(positions)
    @array[positions[:store_position]] = @array[positions[:position_one]] + @array[positions[:position_two]]
  end

  def multiply_at(positions)
    @array[positions[:store_position]] = @array[positions[:position_one]] * @array[positions[:position_two]]
  end

  def determine_positons(op_value_one, op_value_two, store_value)
    {
      position_one:   @array[op_value_one],
      position_two:   @array[op_value_two],
      store_position: @array[store_value]
    }
  end

  def determine_next_instruction(position)
    next_position = position + 4
    next_position < @array.length ? process_opcode_at(next_position) : end_program
  end

  def end_program
    puts "PROGRAM COMPLETE"
    puts @array
  end
end

data = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,5,19,23,1,6,23,27,1,27,10,31,1,31,5,35,2,10,35,39,1,9,39,43,1,43,5,47,1,47,6,51,2,51,6,55,1,13,55,59,2,6,59,63,1,63,5,67,2,10,67,71,1,9,71,75,1,75,13,79,1,10,79,83,2,83,13,87,1,87,6,91,1,5,91,95,2,95,9,99,1,5,99,103,1,103,6,107,2,107,13,111,1,111,10,115,2,10,115,119,1,9,119,123,1,123,9,127,1,13,127,131,2,10,131,135,1,135,5,139,1,2,139,143,1,143,5,0,99,2,0,14,0]
comp = IntcodeComputer.new(data)
