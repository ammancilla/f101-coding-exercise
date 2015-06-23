require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  test '#update_show_average_rating should update the show reviews_average on :after_create' do
    review =  Review.create!(
                show_id: 1, critic_name: 'Alfonso Manuel', 
                score: 100, publication_name: 'Lorem ipsum dolor', 
                body: 'Neque porro quisquam est qui dolorem ipsum quia'
              )

    assert_equal 85.78, review.show.reviews_average.to_f.round(2)
  end
end