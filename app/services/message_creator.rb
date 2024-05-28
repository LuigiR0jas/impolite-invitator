class MessageCreator
  def initialize
    @client = OpenAI::Client.new
  end

  def call
    send_request
  end

  private

  def send_request
    response = @client.chat(parameters: default_parameters)

    response.dig("choices", 0, "message", "content")
  end

  def default_parameters
    {
      model: "gpt-4o",
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant."
        },
        {
          role: "user",
          content: "Write an invitation letter for an event."
        }
      ]
    }
  end
end