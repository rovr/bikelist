# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#youtube_playlist tr').click ->
    youtube_id = $(this).data('youtube')
    video_url = "http://www.youtube.com/embed/#{youtube_id}"
    $('#youtube_videos iframe').attr('src', video_url)
