class PasswordResetsController < ApplicationController

  #validationについてはapi/pasword_resetsのupdate実行時に行われるのでここでは設けない
  #メールに組み込まれるurlに'api'が含まれると違和感があるのでeditだけ通常にcontrollerで処理する
  def edit
  end

end
