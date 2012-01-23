#!/usr/bin/env ruby 
require 'rubygems'
require 'nokogiri'

input_xml = "../to_tests/teste.Xml"
schema   = "leiauteNFe_v2.00.xsd"
errors   =[]

xsd = Nokogiri::XML::Schema(File.read(schema))
doc = Nokogiri::XML(input_xml)
xsd.validate(doc).each do |error|
    errors << error.message
end
