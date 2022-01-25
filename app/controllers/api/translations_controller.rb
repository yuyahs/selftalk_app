class Api::TranslationsController < ApplicationController
  require 'httpclient'

  def translate
    @answer = current_user.answers.find(params[:id])
    answer_text = @answer.content
    api_key = Rails.application.credentials.deepl[:api_key]
    url = "https://api-free.deepl.com/v2/translate"
    client = HTTPClient.new
    query = {
      auth_key: api_key,
      text: answer_text,
      target_lang: "JA"
    }
    @response = client.get(url, query: query)
    render json: @response
  end
end
