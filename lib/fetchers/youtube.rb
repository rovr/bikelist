module Fetchers
  class Youtube
    attr_reader :url, :bike

    def initialize(bike)
      @bike = bike
      @url = "https://www.youtube.com/results?search_query=#{@bike.brand.name} #{@bike.name}"
    end

    def fetch_videos
      @bike.update_attributes(video_id: video_id) if exact_match.present?
      @bike.update_attributes(all_videos: all_videos_json) if all_videos_json.any?
    end

    def video_id
      get_id(exact_match)
    end

    def exact_match
      all_videos.detect {|f| f.text.match(/#{bike.name}/i)}.try(:href)
    end

    def all_videos_json
      all_videos.each_with_object({}) {|s, obj| obj[s.text] = get_id(s.href)}
    end

    def all_videos
      @all_videos ||= page.links.select {|a| a.href.match(/watch/) && a.text.match(/\D{5,}/)}
    end

    def page
      Rails.logger.info "Fetching #{url}"
      @page ||= agent.get(url)
    end

    def get_id link
      link.gsub(/\/watch\?v\=/, '').gsub(/\&.*/, '')
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
