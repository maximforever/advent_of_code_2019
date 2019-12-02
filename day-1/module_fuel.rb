class FuelCalculator
  def initialize(data)
    return unless data.any?
    
    puts "Total fuel needed: #{total_fuel_needed(data)}"
  end

  def total_fuel_needed(data)
    data.reduce(0) { |sum, mass| sum + fuel_for_module(mass.to_i, 0) }
  end

  def fuel_for_module(mass, total_fuel)
    fuel_for_this_segment = fuel_for_segment(mass)
    total_fuel += fuel_for_this_segment

    if fuel_for_this_segment > 6
      fuel_for_module(fuel_for_this_segment, total_fuel)
    else
      total_fuel
    end
  end

  def fuel_for_segment(mass)
    (mass/3).floor - 2
  end
end

data = File.read("data.txt").split
f = FuelCalculator.new(data)