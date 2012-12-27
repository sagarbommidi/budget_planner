<% component_content = escape_javascript(render_cell :component, :edit, :user => current_user, :component => @income) %>
$('#modal-body-container').html('<%= component_content %>')