if Rails.env.development?
  20.times do
    show = Show.create!(
      title:  Faker::Lorem.words(3).join(' ').titleize,
      description: Faker::Lorem.paragraph
    )

    # Create some number of reviews between 5 and 20
    (1..rand(5..25)).each do
      show.reviews.create!(
        critic_name: Faker::App.author,
        publication_name: "#{Faker::Lorem.words} " + ['Times', 'Journal', 'Inquirer', 'Daily'].sample,
        score: rand(0..100),
        body: Faker::Lorem.paragraph
      )
    end
  end
end