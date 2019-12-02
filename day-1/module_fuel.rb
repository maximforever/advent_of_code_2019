class FuelCalculator
	def initialize(data)
		return unless data.any?

		puts get_total_mass(data)
	end

	def get_total_mass(data)
		sum = 0;

		data.each do |mass|
			sum += fuel_requirement(mass.to_i) 
		end 

		sum
	end

	def fuel_requirement(mass)
		return 0 if mass < 6		# or we'll end up with negative mass

		(mass/3).floor - 2
	end
end


data = File.read("data.txt").split
f = FuelCalculator.new(data)