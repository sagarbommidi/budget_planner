<% unless @result_arr.blank? %>
$('#auto-suggest-tags').show()
content = ''
  <% @result_arr.each do |ele| %>
console.log("<%= ele[1] %>")
content = content + "<li><a href='javascript:void(0)''><%= ele[1] %></a></li>"
  <% end %>
$('#auto-suggest-tags').html(content)
<% else %>
$('#auto-suggest-tags').hide()
<% end %>