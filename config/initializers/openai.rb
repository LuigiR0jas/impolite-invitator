OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:openai_access_token)
end