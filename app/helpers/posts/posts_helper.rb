module Posts::PostsHelper
  def load_dropdown model
    model.pluck :name, :id
  end
end
