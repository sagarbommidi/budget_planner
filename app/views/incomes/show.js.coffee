<% component_content = escape_javascript(render_cell :component, :show, :user => current_user, :component => @income) %>
$('#component-container').html("<%= component_content %>").show()
$('#componentModal').show()
$('.modalClose').live 'click', ->
  $('#component-container').hide()