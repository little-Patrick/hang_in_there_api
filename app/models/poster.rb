class Poster < ApplicationRecord
  def self.poster_sorting(sort_by)
        if sort_by == "desc"
            order(created_at: :desc)
        else   
            order(created_at: :asc)
        end
  end

  def self.sort_names(name)
    self.all.select do |poster|
      poster.name.downcase.include?(name.downcase)
    end
  end

  def self.max_price
    self.all.select do |poster|
      poster.price <= 99.99
    end
  end

  def self.min_price(price)
    self.all.select do |poster|
      poster.price > 99.99
    end
  end
end
