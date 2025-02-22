class Poster < ApplicationRecord
  def self.poster_sorting(sort_by)
    if sort_by == "desc"
        order(created_at: :desc)
    else   
        order(created_at: :asc)
    end
  end

  def self.sort_names(name)
    all.select do |poster|
      poster.name.downcase.include?(name.downcase)
    end
  end

  def self.max_price(price)
    all.select do |poster|
      poster.price <= price

  end

  def self.min_price(price)
    all.select do |poster|
      poster.price > price
    end
  end
end
