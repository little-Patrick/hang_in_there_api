class Poster < ApplicationRecord
  def self.poster_sorting(sort_by)
    if sort_by == "desc"
        order(created_at: :desc)
    else   
        order(created_at: :asc)
    end
  end

  def self.sort_names(name_params)
    posters = Poster.where("name ILIKE '%#{name_params}%'")
    posters.order(name: :asc)
  end

  def self.max_price(max_price)
    where("price < #{max_price}")
  end

  def self.min_price(min_price)
    where("price > #{min_price}")
  end
end
