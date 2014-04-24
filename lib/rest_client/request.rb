# encoding: utf-8
module RestClient
  
  class Request

    def make_headers user_headers
      unless @cookies.empty?
        user_headers[:cookie] = @cookies.map { |(key, val)| "#{key.to_s}=#{CGI::unescape(val)}" }.sort.join('; ')
      end
      headers = stringify_headers(default_headers).merge(stringify_headers(user_headers))
      # replace if headers["Content-Type"] has value
      # headers.merge!(@payload.headers) if @payload
      headers.merge!(@payload.headers) if @payload and headers["Content-Type"].blank?
      headers
    end
    
  end
end
