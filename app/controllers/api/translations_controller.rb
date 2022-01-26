class Api::TranslationsController < ApplicationController
  require 'httpclient'

  def translate
    api_key = Rails.application.credentials.deepl[:api_key]
    url = "https://api-free.deepl.com/v2/translate"
    client = HTTPClient.new
    query = {
      auth_key: api_key,
      text: "This is a test",
      target_lang: "JA"
    }
    @response = client.get(url, params: query)

    render json: @response


  end
end
