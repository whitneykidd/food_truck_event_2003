require 'date'
class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def date
    date = Date.today
    date.strftime("%d/%m/%Y")
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

  def overstocked_items
    overstocked_items = total_inventory.find_all do |items|
      items.last[:quantity] > 50 && items.last[:food_trucks].length > 1
    end
    overstocked_items.map { | items | items.first }
  end

  def sorted_item_list
    total_inventory.map do |items|
      items.first.name
    end.sort
  end

  def sell(item, quantity)
    if total_inventory[item][:quantity] >= quantity
      return true
      total_inventory[item][:quantity] -= quantity
      total_inventory
    else
      false
    end
  end
end
