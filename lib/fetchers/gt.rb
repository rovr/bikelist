module Fetchers
  class GT < BikeFetcher
    attr_reader :url, :year, :type

    def initialize url = nil
      @url = url.match(/www/) ? url : base_url+url
      @year, _, @type = @url.match(/\d{4}\/bikes\/.*$/).to_s.split("/")
    end

    def fetch_bikes
      all_models.each do |model|
        Bike.create(type_id: bike_type_id, brand_id: brand_id, name: model[0], url: model[1].gsub(/http\:\/\/www.gtbicycles.com/, ''), year: year.to_i) unless Bike.where(name: model[0]).any?
      end
    end

    def all_models
      general_list.search("#products-list").children.search("a").each_with_object({}) do |l, all|
        title = l.attributes['title'].try(:value)
        title.blank? ? next : all[title] = l.attributes['href'].value
      end
    end

    private

    ## Get all bike links ##

    def bike_type_id
      bike_type_id ||= Type.find_or_create_by(name: type.capitalize).id
    end

    def brand_id
      brand_id ||= Brand.find_or_create_by(name: "GT", website: base_url).id
    end

    def general_list
      @general_list ||= agent.get url
    end

    ## Helpers ##

    def base_url
      "http://www.gtbicycles.com"
    end
  end


  class GTIterator
    class << self
      def iterate_over_all_bike_types
        bike_types_paths.each do |path|
          Fetchers::GT.new(bike_type_base_path+path).fetch_bikes
        end
      end

      def bike_types_paths
        %w(mountain road urban womens bmx kids)
      end

      def bike_type_base_path
        '/usa_en/2015/bikes/'
      end
    end
  end

  class GTBikeInfo < DetailFetcher

    private

    def specs
      process_specifications(specifications)
    end

    def process_specifications spec
      heading = "Specs"
      specs = specifications.search('tr').each_with_object({}) do |tr, hash|
        value = tr.children.search('td').try(:text)
        value.blank? ? next : hash[tr.children.search('th').text.gsub(/\:/, '')] = value
      end
      {heading => specs}
    end

    def specifications
      bike_page.search('#product-attribute-specs-table')
    end

    def image_urls
      [bike_page.search("#bike-image").last.attributes['src'].try(:value), geometry_image].compact
    end

    def geometry_image
      bike_page.images.detect {|i| i.src.match(/product\//) && i.alt == "Palomar Geometry"}.try(:src)
    end

    def description
      bike_page.search(".product-description").text
    end

    def price
      bike_page.search("#product-info .regular-price").text.strip
    end
  end
end
