FactoryGirl.define do
  factory :bike do
    name "Enchant 20 Lite "
    url "/en-us/bikes/model/enchant.20.lite/22259/84102/"
    association :brand
    association :type
  end

  factory :brand do
    name 'Giant'
    website "http://www.giant-bicycles.com"
  end

  factory :type do
    name 'Mountain'
  end
end
