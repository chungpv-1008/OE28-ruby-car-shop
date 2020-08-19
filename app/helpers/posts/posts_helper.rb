module Posts::PostsHelper
  def load_dropdown model
    model.pluck :name, :id
  end

  def number_to_price price
    if price < Settings.second_price_limit
      price.to_s + Settings.second_price
    elsif price.to_s.last(Settings.second_price_count).sub(/^0+/, "").blank?
      (price / Settings.second_price_limit).to_s + Settings.first_price
    else
      (price / Settings.second_price_limit).to_s + Settings.first_price +
        price.to_s.last(Settings.second_price_limit).sub(/^0+/, "") +
        Settings.second_price
    end
  end

  def status_text status
    status ? t("admins.active") : t("admins.inactive")
  end
end
