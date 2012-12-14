# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ($) ->
  $('#tag-list li').live "click", ->
    clicked_tag = $(this).text() + ','
    if $('#tag_names').val().indexOf(clicked_tag) > -1
      $(this).removeClass('selected')
      reg_ex = new RegExp(clicked_tag + '\s*')
      $('#tag_names').val($('#tag_names').val().replace(reg_ex, ''))
    else
      $(this).addClass('selected')
      prev_val = $('#tag_names').val().trim()
      str_length = prev_val.length - 1
      if prev_val.length == 0
        $('#tag_names').val(clicked_tag + ' ')
      else if prev_val.length > 0 && prev_val[str_length] != ','
        $('#tag_names').val(prev_val + ', ' + clicked_tag + ' ')
      else
        $('#tag_names').val(prev_val + ' ' + clicked_tag + ' ')
    $('#tag_names').focus()

  $('#tag_names').live "keyup", ->
    str = $('#tag_names').val().replace(/\s\s+/, ' ')
    #$('#tag_names').val(str)
    arr = str.split(',').map (name) -> name.trim()
    
    for list in $('#tag-list li')
      do (list) ->
        if $(list).text() in arr
          $(list).addClass('selected')
        else
          $(list).removeClass('selected')
