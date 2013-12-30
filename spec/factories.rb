require 'factory_girl'
require 'shared_values'

tmp_path = Dir.pwd + '/spec/tmp'

FactoryGirl.define do
  factory :blog, class: Writetheman::Blog do 
    initialize_with { Writetheman::Blog.new(tmp_path) }
  end

  factory :article, class: Writetheman::Article::Base do 
    initialize_with { Writetheman::Article::Base.new(tmp_path) }
    title { Faker::Lorem.sentence(3) }
    date { DateTime.now }
  end 
end