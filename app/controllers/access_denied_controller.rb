class AccessDeniedController < ApplicationController
  def index
    flash[:notice] = "Acesso Negado"
  end

end

