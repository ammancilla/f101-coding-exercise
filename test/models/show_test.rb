require 'test_helper'

class ShowTest < ActiveSupport::TestCase

  def setup
    # title: Odio Voluptatem Aut
    # description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
    # reviews_average: 85.64
    # reviews_count: 100

    @show = shows(:one)
  end

  test '#calculate_reviews_average should calculate the new average given a new score' do
    # Assuming there is a new score of 100
    assert_equal 85.78, @show.send('calculate_reviews_average', 100).to_f.round(2)
  end

  test '#update_reviews_average should update the show :reviews_average and :reviews_count given a new score' do
    @show.update_reviews_average(100)

    assert_equal 85.78, @show.reviews_average.to_f.round(2)
    assert_equal 101, @show.reviews_count
  end
end