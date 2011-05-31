class ImportsController < ApplicationController
  def index
    @doc = Nokogiri::XML(File.open("xmls/tr.xml")) {|config| config.noblanks}
  end

end

