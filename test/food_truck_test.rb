require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'


class FoodTruckTest < Minitest::Test
  def setup
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of FoodTruck, @food_truck
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Pies", @food_truck.name
    assert_equal ({}), @food_truck.inventory
  end

  def test_it_can_check_stock
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_it_can_stock_items
    @food_truck.stock(@item1, 25)
    assert_equal 25, @food_truck.check_stock(@item1)
    inventory1 = {@item1 => 25}
    assert_equal inventory1, @food_truck.inventory

    @food_truck.stock(@item1, 30)
    assert_equal 55, @food_truck.check_stock(@item1)

    @food_truck.stock(@item2, 12)
    inventory2 = {@item1 => 55, @item2 => 12}
    assert_equal inventory2, @food_truck.inventory
  end

  def test_it_can_return_potential_revenue
    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item2, 12)
    assert_equal 236.25, @food_truck.potential_revenue
  end
end
