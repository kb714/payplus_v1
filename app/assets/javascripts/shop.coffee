# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "form", (ev, data) ->
  console.log "#{data.body}"
  console.log data

$(document).on "ajax:error", "form", (evt, xhr, status, error) ->
  errors = xhr.responseJSON
  for message of errors
    console.log errors