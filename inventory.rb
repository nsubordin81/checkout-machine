require './item'

class Inventory
  attr_reader :items

  def initialize(item_list)
    @items = item_list.collect {|item|
      Item.new(item[0], item[1], item[2])
    }
  end

  def get_item_by_sku(sku)
    items.select {|item| item.sku == sku}[0]
  end

  def get_item_by_name(name)
    items.select {|item| item.name == name}[0]
  end
end
