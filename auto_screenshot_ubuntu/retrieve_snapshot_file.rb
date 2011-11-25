#!/usr/bin/env ruby

require 'uri'
require 'rexml/document'

xbel_file = ARGV[0] || '~/.local/share/recently-used.xbel'

def get_screenshot_file_from_xbel_file(xbel_file)
  xbel_content = File.read(xbel_file)
  xbel_doc = REXML::Document.new(xbel_content)
  snapshot_href = xbel_doc.get_elements('xbel').last.get_elements('bookmark').last.attribute('href').value
  raise "invalid href(#{snapshot_href}) for file" unless snapshot_href.start_with?('file:///')
  URI.decode snapshot_href[('file://'.length)..-1]
end

puts screenshot_file = get_screenshot_file_from_xbel_file(File.expand_path(xbel_file))

