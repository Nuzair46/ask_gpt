# frozen_string_literal: true

require_relative 'ask_gpt/version'
require 'ruby/openai'

module Ask
  class GPT
    attr_accessor :messages, :history, :model, :temperature, :unable_to_get_answer_text, :api_key

    def initialize(api_key, model: 'gpt-3.5-turbo', temperature: 0.7, unable_to_get_answer_text: nil)
      @api_key = api_key
      @model = model
      @temperature = temperature
      @messages = []
      @history = []
      @unable_to_get_answer_text = unable_to_get_answer_text || 'Unable to get answer from ChatGPT. Make sure API key is valid and has enough credits.'
    end

    def ask(question)
      return if question.empty?

      replay_history
      update_messages(question)
      answer = get_completion

      return unable_to_get_answer_text unless answer

      update_history(question, answer)
      answer
    end

    private

    def get_completion
      response = openai_client.chat(
        parameters: {
          model: model,
          temperature: temperature,
          messages: messages
        }
      )
      raise StandardError, response['error'] if response['error']

      response.dig('choices', 0, 'message', 'content')
    end

    def replay_history
      history.each do |input_text, completion_text|
        messages.push({ role: 'user', content: input_text })
        messages.push({ role: 'assistant', content: completion_text })
      end
    end

    def update_messages(question)
      messages.push({ role: 'user', content: question })
    end

    def update_history(question, answer)
      history.push([question, answer])
    end

    def openai_client
      @_openai_client ||= OpenAI::Client.new(access_token: api_key)
    end
  end
end
