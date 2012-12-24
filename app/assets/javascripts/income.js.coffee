# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

add_error_styles = (attr_id, message) ->
  $('#' + attr_id).parent().parent().addClass('error')
  $('#' + attr_id).siblings('.help-inline').text(message)

remove_error_styles = (attr_id) ->
  $('#' + attr_id).parent().parent().removeClass('error')
  $('#' + attr_id).siblings('.help-inline').text('')

jQuery ($) ->
  $('#add-component-btn').live "click", ->
    is_validated = true
    amount = parseFloat($('#component-amount').val())
    if isNaN(amount)
      is_validated = false
      add_error_styles("component-amount", "please enter valid amount")
    else
      $('#component-amount').val(amount)
      remove_error_styles("component-amount")

    if $('#tag_names').val().trim() == ''
      is_validated = false
      add_error_styles("tag_names", "please enter a tag name/names")
    else
      remove_error_styles("tag_names")

    if $('#component-description').val().trim() == ''
      is_validated = false
      add_error_styles("component-description", "please enter description")
    else
      remove_error_styles("component-description")
    
    return is_validated

  $('#tags-btn').live 'click', ->
    $('#tags-btn').addClass('selected')
    $('#timeline-btn').removeClass('selected')
    $('#timeline-container').hide()
    $('#tags-container').show()

  $('#timeline-btn').live 'click', ->
    $('#timeline-btn').addClass('selected')
    $('#tags-btn').removeClass('selected')
    $('#tags-container').hide()
    $('#timeline-container').show()