## Leaderboard Challenge

This is a bare-bones Rails app that we've put together to see how you think.

We hesitate even to call it a "challenge" or a "test" because this isn't designed to stump you. We just want to see what your instincts are with respect to applying Rails' abstractions to a specific and realistic problem.

So without further ado...

Please begin by running bundler.

````
  bundle install
````

Then run migrations to create the schema (the development-default Sqlite3 will be used. You're welcome to swap in another DBMS if you want, but there isn't much point).

````
  bin/rake db:migrate
````

Finally, seed the database:
````
  bin/rake db:seed
````

The schema consists of "shows" and "reviews". We've dropped corresponding models into app/models and set up the relation between them (a show has many reviews). The seeds script that you've run will have populated the database with twenty randomly-named shows and a couple hundred random reviews (with different numbers of reviews per show, and each review giving the show a score between 0 and 100).

### Your task is simply this:

Build a page that displays the top 10 shows by average score (in descending order, with the highest-rated show at the top of the list). The interface should display the show title, its average score (you can limit the decimals to 1, i.e. "score: 70.5") and its review count.

Even though this is a simple demo app that we're running in a development environment, if there are any special tricks you would use to increase the performance of an interface like this in a production environment (caching strategies, for instance, or special ActiveRecord functions) feel free to show those off.

You can share your work with us either by opening a pull request on the repository (https://bitbucket.org/nzaillian/leaderboard-challenge/overview) or by sending your project tree to us by email in a compressed directory.



### Thinking and Choices
Depending on the number of shows and the number of reviews associated to them, the retrieve of the top ten shows can result into a really heavy operation with multiple calls to the db. To ensure the optimus performance of the site, we have to avoid making heavy calculations and operations and reduce as much as possible the number of calls to the db needed to retrieve the top ten shows. To acomplish that, the idea is to cache both the reviews count and reviews average score for every show by adding two new fields to the shows table to store those values. Then, we have to make sure that every time a new review is created, the reviews count and the reviews average score values for the show are aumented by one and recalculated respectively, given the score of the review.

By doing this we ensure that the retrieve of the top ten shows is reduced to a single call to the db: order the shows in descendent way by the reviews average score and set a limit of 10 records to retrieve.


## Strategy
* Add two new fields to the shows table to cache the reviews count and the reviews average score for every show.
* Update the reviews count and the reviews average score values for the show every time a new review is created.


### Changelog
## Gemfile
* Set ruby version to '2.2.0'.
* Add 'quiet_assets' gem.
* Clean and organize the file.

## db/migrate/20150515002816_create_schema.rb
* Add to shows table :reviews_count and :reviews_average fields.

## app/models/review.rb
* Add some general validations.
* Create method #update_show_average_rating and set it to be called in the :after_create callback.

## app/models/show.rb
* Add some general validations.
* Add private method #calculate_reviews_average to calculate the new reviews average given a new score.
* Add method #update_reviews_average to update the values of :reviews_average and :reviews_count attributes.
* Define scope :top_ten to retrieve from the db the top ten shows ordered by :reviews_average.

## config/routes.rb
* Set the root route to the :index action on the shows controller.

## app/controllers/shows.rb
* Create :index action to handle the request to display the shows top ten list.

## app/assets/stylesheets/application.rb
* Convert from .css to .scss and import bootstrap.

## app/views/layout/application.rb
* Add the viewport meta tag to ensure proper rendering and touch zooming on mobile devices.

## app/views/shows/index.rb
* Design a very simple responsive view to display the shows top ten list.

## test/fixtures/shows.yml
* Create sample data for a show.

## test/models/reviews.rb
* Define test to test the #update_show_average_rating method and make sure it is called on the :after_create callback.

## test/models/shows.rb
* Define test to test the #calculate_reviews_average method.
* Define test to test the #update_reviews_average method.