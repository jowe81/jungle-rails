class Sale < ActiveRecord::Base

  # AR Scope - get currently active sales records
  def self.active
    where("sales.starts_on < ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  # Alternate way to define AR Scope
  #scope :active, -> { where("sales.starts_on < ? AND sales.ends_on >= ?", Date.current, Date.current).any? }

  def finished?
    self.ends_on < Date.current
  end

  def upcoming?
    self.starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end



end
