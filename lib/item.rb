class Item
  attr_reader :name, :price
  def initialize(attributes)
    @name = attributes[:name]
    @price = attributes[:price][1..-1].to_f.to_f

  end
end
