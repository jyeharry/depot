class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_line_item = line_items.find_by(product_id: product.id)
    if current_line_item
      current_line_item.quantity += 1
    else
      current_line_item = line_items.build(product_id: product.id)
    end
    current_line_item
  end
end
