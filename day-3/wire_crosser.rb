class WireCrosser
  def initialize(wire_one_instructions, wire_two_instructions)
    @wire_one = calculate_wire_coordinates(wire_one_instructions)
    @wire_two = calculate_wire_coordinates(wire_two_instructions)
  end

  def get_closest_intersection
    intersection = closest_intersection(all_wire_intersections)
    manhattan_distance(intersection)
  end

  def calculate_wire_coordinates(instructions)
    wire = [{x: 0, y: 0}]

    instructions.each do |instruction|
      direction = instruction[0]
      length = instruction[1..-1].to_i

      if direction == "R" || direction == "L"
        direction = direction == "R" ? 1 : -1
        for step in 1..length
          next_x = wire.last[:x] + direction
          wire << {x: next_x, y: wire.last[:y]}
        end
      elsif direction == "U" || direction == "D"
        direction = direction == "U" ? 1 : -1
        for step in 1..length
          next_y = wire.last[:y] + direction
          wire << {x: wire.last[:x], y: next_y}
        end
      end
    end

    wire

  end

  def all_wire_intersections
    @wire_one & @wire_two
  end

  def closest_intersection(intersections)
    intersection = nil
    min_distance = 99999999999

    intersections.each do |coordinate|
      distance = manhattan_distance(coordinate)

      if distance < min_distance && distance > 0
        min_distance = distance
        intersection = coordinate
      end
    end

    intersection
  end


  def origin_coordinates(x, y)
    x == 0 && y == 0
  end

  def manhattan_distance(coordinate)
    return coordinate[:x].abs() + coordinate[:y].abs()
  end
end


wire_one = File.read("wire1.txt").split(",")
wire_two = File.read("wire2.txt").split(",")

w = WireCrosser.new(wire_one, wire_two).get_closest_intersection
