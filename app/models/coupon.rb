class Coupon < ActiveRecord::Base
  # Check code with coupon code from db
  def self.check_coupon(code)
    self.all.find_each do |coupon|
      if code == coupon.code
        return true
      end
    end
  end
end
