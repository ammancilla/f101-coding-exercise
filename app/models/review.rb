class Review < ActiveRecord::Base

  # Associations
  belongs_to :show # Perform the counter cache manually on the :after_create callback to avoid and extra query to the db.

  # Validations
  validates :show_id, :critic_name, :score, presence: true
  validates :show_id, uniqueness: { scope: :critic_name }
  validates :score, numericality: { greater_than_or_equal_to: 0 }

  # Callbacks
  after_create :update_show_average_rating

  # Methods
  private
    def update_show_average_rating
      self.show.update_reviews_average(self.score)
    end
end
