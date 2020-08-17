module Posts::PostsHelper
  def load_dropdown model
    model.pluck :name, :id
  end

  def number_to_price price
    if price < Settings.second_price_limit
      price.to_s + Settings.second_price
    elsif price.to_s.last(second_price_count).sub(Settings.sub_zero).blank?
      (price / Settings.second_price_limit).to_s + Settings.first_price
    else
      (price / Settings.second_price_limit).to_s + Settings.first_price +
        price.to_s.last(3).sub(/^0+/, "") + Settings.second_price
    end
  end
end
