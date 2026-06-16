module ApplicationHelper
  def render_markdown(text)
    Kramdown::Document.new(text, input: 'GFM', syntax_highlighter: "rouge").to_html
  end

  HIDDEN_NAVBAR_ACTIONS = {
    'chats' => %w[show],
    'user_conversations' => %w[show],
    'users/registrations' => %w[new edit],
    'devise/sessions' => %w[new],
    'devise/passwords' => %w[new create],
    'pages' => %w[home]
  }.freeze

  def show_bottom_navbar?
    !HIDDEN_NAVBAR_ACTIONS[params[:controller]]&.include?(params[:action])
  end

  def current_page
    if params[:controller] == 'pages'
      params[:action]
    else
      params[:controller]
    end
  end
end
