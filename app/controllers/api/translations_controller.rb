class Api::TranslationsController < ApplicationController
  require 'httpclient'

  def translate
    @question = Question.find(params[:id])
    api_key = Rails.application.credentials.deepl[:api_key]
    uri = "https://api-free.deepl.com/v2/translate"
    client = HTTPClient.new
    query = {
      auth_key: api_key,
      text: @question.content,
      target_lang: "EN"
    }
    headers = {
      Authorization: api_key
    }
    @response = client.get(uri, body: query, header: headers)
    render json: @response.body
  end
end
