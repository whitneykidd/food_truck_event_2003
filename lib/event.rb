class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |food_truck| food_truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all { |food_truck| food_truck.inventory.include?(item) }
  end

  def total_inventory
    @food_trucks.reduce({}) do |inventory, food_truck|
      food_truck.inventory.each do |items|
        if inventory.key? items.first
          inventory[items.first][:quantity] += items.last
          inventory[items.first][:food_trucks] << food_truck
        else
          inventory[items.first] = {
            quantity: items.last,
            food_trucks: [food_truck]
          }
        end
      end
      inventory
    end
  end
end
