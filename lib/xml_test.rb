require 'rubygems'
require 'nokogiri'

@doc = Nokogiri::XML(File.open("../xmls/nf.xml"))

@doc.xpath("//obsfre")

