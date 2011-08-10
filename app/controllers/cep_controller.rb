class CepController < ApplicationController

  require 'open-uri'

  def findCep
    @data = findCepWeb params[:cep]
    headers["Content-type"] = "text/html; charset=utf-8"

    respond_to do |format|
      format.html
      format.json  { render :json => @data }
    end
  end

  protected

  def findCepWeb cep
    data = {}
    if !cep or cep.size < 8
      data['result'] = "-2"
      data['result_txt'] = "CEP inválido"
      return data
    end
    url = "http://www.buscarcep.com.br/?formato=string&chave=1ed9xX5kaRulHjiaHNUmbxA3Db8e061&cep=" + cep
    pares = open(url).read.split("&")
    data = {}
    pares.each { |p|
      p = p.split("=")
      data[p[0]] = Iconv.conv('utf-8', 'ISO-8859-1', p[1]) if p[0]
    }

    data['estate_id'] = findIdUf data['uf'] unless data['uf'].blank?

    return data
  end

  def findIdUf uf
    id = Estate.find_by_acronym(uf)
    return id.id
  end

end

