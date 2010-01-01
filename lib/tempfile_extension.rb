require "tempfile"
require 'net/http/post/multipart'

class Tempfile
  def upload_to_imageshack(key)
    url  = URI.parse("http://www.imageshack.us/upload_api.php")
    http = Net::HTTP.new(url.host, url.port)
    req  = Net::HTTP::Post::Multipart.new(url.path, :key => key, :fileupload => self)

    result = http.start { |http| http.request(req) }

    if result && xml = result.body
      hash = Hash.from_xml(xml)
      
      raise hash['links']['error'] if hash['links'] && hash['links']['error']

      info   = hash['imginfo']['files']
      server = info['server']
      bucket = info['bucket']
      image  = info['image']

      return "http://img#{server}.imageshack.us/img#{server}/#{bucket}/#{image}"
    else
      return nil
    end
  end
end