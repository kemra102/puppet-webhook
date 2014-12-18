require 'sinatra'
require 'json'

post '/payload' do
  push = JSON.parse(request.body.read)
  logger.info("json payload: #{push.inspect}")

  # User defined parameters that we expect from the POST and want to utilise.
  <% @hook_params.sort.map do |k,v| -%>
    <%=  k %> = <%=  v %>
  <% end %>
  customCmd(<% if @cmd_param %><%= @cmd_param %><% end %>)

end

# Define what command we're going to run.
def customCmd(<% if @cmd_param %><%= @cmd_param %><% end %>)
  customCmd = "<%= @hook_cmd %>"
  `#{customCmd}`
end
