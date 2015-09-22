module ApplicationHelper
  def cache_key_for_top_shows
    max_updated_at = Show.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "shows/all-#{max_updated_at}"
  end
end
