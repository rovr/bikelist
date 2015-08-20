module Fetchers
  class Giant < BikeFetcher
    attr_reader :url

    def initialize url = nil
      @url = url.match(/www/) ? url : base_url+url
    end

    def fetch_bikes
      all_models.each do |model|
        Bike.create(type_id: bike_type_id, brand_id: brand_id, name: model.text, url: model.href) unless Bike.where(name: model.text).any?
      end
    end

    private


    ## Get list of all bikes ##

    # def fetch_all_bikes
    #   agent.get(all_bikes_url)
    # end

    # def all_bikes_url
    #   "http://www.giant-bicycles.com/en-us/bike-catalogue/filter/"
    # end


    ## Get all bike links ##

    def brand_id
      brand_id ||= Brand.find_or_create_by(name: "Giant").id
    end

    def bike_type_name
      if url.match /x\-road/
        "Hybrid"
      elsif url.match /off\-road/
        "Mountain"
      else
        "Road"
      end
    end

    def series_links
      series_links ||= general_list.links.select{|l| l.href.match(/bikes\/series/) && l.text.present?}.uniq(&:href).map(&:href)
    end

    def model_links series_path
      agent.get(base_url+series_path).links.select {|l| l.href.match(/model/)}.uniq(&:href)
    end

    def all_models
      @all_models ||= fetch_all_models
    end

    def fetch_all_models
      model_links_list = []
      series_links.each do |series_path|
        model_links_list << model_links(series_path)
      end
      model_links_list.flatten
    end

    def general_list
      @general_list ||= agent.get url
    end

    ## Helpers ##

    def base_url
      "http://www.giant-bicycles.com"
    end
  end


  class GiantIterator
    class << self
      def iterate_over_all_bike_types
        bike_types_paths.each do |path|
          Fetchers::Giant.new(bike_type_base_path+path).fetch_bikes
        end
      end

      def bike_types_paths
        ["/on-road/7/",
          "/x-road/9/",
          "/off-road/8/",
          "/on-road/51/",
          "/x-road/52/",
          "/off-road/53/",
          "/on-road/54/",
          "/bmx/57/",
          "/off-road/56/"]
        end

      def bike_type_base_path
        '/en-us/bike-catalogue/series'
      end
    end
  end

  class GiantBikeInfo < DetailFetcher

    private

    def specs
      specifications.map {|spec| process_specifications(spec)}
    end

    def process_specifications spec
      heading = spec.search('.heading').text
      specs = spec.search('tr').each_with_object({}) do |tr, hash|
        value = tr.children.search('td').try(:text)
        value.blank? ? next : hash[tr.children.search('th').text] = value
      end
      {heading => specs}
    end

    def specifications
      bike_page.search('.bike-specifications')
    end

    def image_urls
      bike_page.images.select {|i| i.src.match(/_generated_us/)}.uniq(&:src).map(&:src)
    end

    def description
      bike_page.search(".content").text
    end

    def price
      bike_page.search(".price").text
    end
  end
end
