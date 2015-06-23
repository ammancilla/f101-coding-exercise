class Show < ActiveRecord::Base

  # Scopes
  scope :top_ten, -> { order(reviews_average: :desc).limit(10) }

  # Associations
  has_many :reviews, dependent: :delete_all

  # Validations
  validates :title, presence: true

  # Methods
  # Update the reviews average and the reviews count given a new score
  def update_reviews_average(score)
    self.reviews_average = calculate_reviews_average(score)
    self.reviews_count += 1
    self.save
  end

  private
    # Calculate the new reviews average based on the current average and the new score
    def calculate_reviews_average(score)
      (self.reviews_average * self.reviews_count + score) / (self.reviews_count + 1)
    end
end
