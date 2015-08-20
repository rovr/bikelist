module Fetchers
  class Fuji < BikeFetcher
    attr_reader :year, :category
    TYPES =       {
      1 => 'Road',
      2 => 'Mountain',
      3 => 'Specialty',
      4 => 'Womens',
      5 => 'Lifestyle',
      6 => 'Kids'}

    def initialize year='2015', category
      @year = year
      @category = category
    end

    def fetch_bikes
      all_models.each do |model|
        Bike.create(type_id: bike_type_id, brand_id: brand_id, name: model.text, url: model.href.gsub(/#{base_base_url}/, ''), year: year) unless Bike.where(name: model.text).any?
      end
    end

    private

    def all_models
      agent.post(base_url, modelyear: year, category: category).links
    end

    def bike_type_name
      TYPES[category]
    end

    def brand_id
      brand_id ||= Brand.find_or_create_by(name: "Fuji Bikes", website: base_base_url).id
    end

    def base_base_url
      'http://archive.fujibikes.com'
    end

    def base_url
      "http://www.fujibikes.com/archive/archivebikes"
    end
  end


  class FujiDetails < DetailFetcher
    private

    def specs
      spec_data = specifications.search('tr').each_with_object({}) do |tr, hash|
        value, desc = tr.search('#name').try(:text), tr.search('#desc').try(:text).encode!("utf-8", "utf-8", invalid: :replace)
        next if value.blank? || desc.blank?
        hash[value.try(:capitalize)] = desc
      end
      @spec ||= {"Specs" => spec_data}
    end

    def specifications
      bike_page.search('.specs')
    end

    def description
      "FujiBike #{bike.type.name} bike."
    end

    def image_urls
      bike_page.images.map {|i| i.src if i.src.match(/downloads/)}.compact
    end
  end

  class FujiIterator
    def self.fetch_all
      %w(2012 2013 2014 2015).each do |year|
        Fetchers::Fuji::TYPES.keys.each do |type|
          Fetchers::Fuji.new(year, type).fetch_bikes
        end
      end
    end
  end
end
