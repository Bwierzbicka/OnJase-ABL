module ApplicationHelper
  def render_markdown(text)
    Kramdown::Document.new(text, input: 'GFM', syntax_highlighter: "rouge").to_html
  end

  def show_bottom_navbar?
    !(params[:controller].in?(%w[chats user_conversations]) && params[:action] == 'show') &&
      !(params[:controller] == 'users/registrations' && params[:action] == 'edit')
  end
end
