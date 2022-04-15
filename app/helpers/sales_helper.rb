module SalesHelper
  def active_sale
    Sale.active
  end

end