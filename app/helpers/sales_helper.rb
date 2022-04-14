module SalesHelper
  def active_sale?
    Sale.active.any?
  end

  def active_sales
    Sale.active
  end
end