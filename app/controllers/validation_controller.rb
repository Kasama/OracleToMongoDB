class ValidationController < ApplicationController
  def validation
    @oracle = {back_path: root_url}
  end
end
