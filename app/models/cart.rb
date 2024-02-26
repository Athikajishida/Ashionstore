class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  belongs_to :coupon, optional: true
  def apply_coupon(coupon)
    if coupon_valid?(coupon)
      self.coupon = coupon
      save
    end
  end

  def coupon_valid?(coupon)
    return false if coupon.nil?
      if coupon.min_purchase_amount.present?
      return false if calculate_cart_total < coupon.min_purchase_amount
    end
      if coupon.expiry_date.present?
      return false if Time.now > coupon.expiry_date
    end
    if coupon.applicable_categories.present?
      return false unless cart_items.any? { |item| coupon.applicable_categories.include?(item.product.category) }
    end
      if coupon.applicable_users.present?
      return false unless coupon.applicable_users.include?(user)
    end
    true
  end
  

  def calculate_discounted_total
    total = cart_items.sum { |item| item.product.price * item.quantity }
    return total * (1 - coupon.discount_percentage / 100.0) if coupon && coupon_valid?(coupon)
    total
  end
end

