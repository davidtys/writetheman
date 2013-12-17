require 'factory_girl'
require 'shared_values'

FactoryGirl.define do

  factory :blog, class: Writetheman::Blog do 
    initialize_with { Writetheman::Blog.new( Dir.pwd + '/spec/tmp' ) }
  end

  factory :article, class: Writetheman::Article::Base do 
    initialize_with { Writetheman::Article::Base.new( Dir.pwd + '/spec/tmp' ) }
    title { Faker::Lorem.sentence(3) }
    date { DateTime.now }
  end  

end