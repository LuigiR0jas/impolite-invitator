class MessageCreator
  def initialize(params: [])
    @client = OpenAI::Client.new
    @params = params
  end

  def call
    send_request
  end

  private

  def send_request
    response = @client.chat(parameters: default_parameters)

    response.dig('choices', 0, 'message', 'content')
  end

  def default_parameters
    {
      model: 'gpt-4o',
      messages: [
        {
          role: 'system',
          content: 'You are a helpful assistant.'
        },
        {
          role: 'user',
          content: "Write an invitation letter for an event using the following information #{@params}.
          Make sure to use recipient likes in the letter as a form of convincing the recipient to attend the event.
          Return only the contents of the letter"
        }
      ]
    }
  end
end
