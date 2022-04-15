class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sale_price_cents
    if Sale.active
      price_cents * (1 - Sale.active.percent_off / 100.to_f)
    else
      price_cents
    end
  end

  def sale_price
    Money.from_cents(sale_price_cents)
  end
end
