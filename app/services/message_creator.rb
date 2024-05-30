class MessageCreator
  include ActionView::RecordIdentifier

  def initialize(model:, target:, params: [])
    @client = OpenAI::Client.new
    @model = model
    @target = target
    @params = params
    @buffer = []
  end

  def call
    send_request
  end

  private

  def send_request
    @client.chat(parameters: default_parameters)

    @buffer.join('').presence
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
      ],
      stream: handle_streaming
    }
  end

  def handle_streaming
    proc do |chunk, _bytesize|
      @buffer << chunk.dig('choices', 0, 'delta', 'content')

      body = @buffer.join('')

      @model.broadcast_body(dom_id(@target), body)
    end
  end
end
