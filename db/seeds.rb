# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.delete_all
product = Product.create(
  title: 'Rails Scales!',
  description: %(
    <p>
      <em>Practical Techniques for Performance and Growth</em>
      Rails doesn’t scale. So say the naysayers. They’re wrong. Ruby on Rails runs some of the biggest sites in the world, impacting the lives of millions of users while efficiently crunching petabytes of data. This reveals how they do it, and how you can apply the same techniques to applications. Optimize everything necessary to make an application at scale: monitoring, product design, Ruby code, software, database access, caching, and more. Even if your app may have millions of users, you reduce the costs of hosting and it.
    </p>
  ),
    price: 30.95
)

product.image.attach(
  io: File.open(
    Rails.root.join('db', 'images', 'cprpo.jpg')
  ),
  filename: 'cprpo.jpg'
)

product.save!
