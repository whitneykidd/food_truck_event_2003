require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'


class ItemTest < Minitest::Test
  def setup
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of Item, @item2
  end

  def test_it_has_attributes
    assert_equal "Apple Pie (Slice)", @item2.name
    assert_equal 2.50, @item2.price
  end
end
