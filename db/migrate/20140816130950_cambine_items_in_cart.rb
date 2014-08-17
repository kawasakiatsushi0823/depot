class CambineItemsInCart < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      #$B%+!<%HFb$N3F>&IJ$N?t$r%+%&%s%H$9$k(B
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    #$B?tNL(B>1$B$NIJL\$rJ#?t$NIJL\$KJ,3d$9$k(B
    LineItem.where("quantity>1").each do |line_item|
      #$B8DJL$NIJL\$rDI2C$9$k(B
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id,
          product_id: line_item.product_id, quantity: 1
      end
      
      #$B85$NIJL\$r:o=|$9$k(B
      line_item.destroy
    end
  end
end
