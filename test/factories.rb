FactoryGirl.define do
  factory :bike do
    name "Enchant 20 Lite "
    url "/en-us/bikes/model/enchant.20.lite/22259/84102/"
    association :brand
    association :type
    factory :gt_bike do
      name 'Palomar'
      url '/usa_en/2015/bikes/mountain/2014-palomar'
      association :brand, factory: :gt_brand
    end
  end

  factory :brand do
    name 'Giant'
    website "http://www.giant-bicycles.com"
    factory :gt_brand, parent: :brand do
      name 'GT'
      website 'http://www.gtbicycles.com'
    end
  end

  factory :type do
    name 'Mountain'
  end
end
