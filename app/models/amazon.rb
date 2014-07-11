require 'ruby_hmac'

class Amazon

  def self.basic_info_hash(response)

  end

  def self.search(search_term)

    api_call = "http://webservices.amazon.com/onca/xml?AWSAccessKeyId=AKIAJOST6FYFMTXDJ3NA&AssociateTag=giftrcom-20&Condition=All&Keywords=#{URI.escape(search_term)}&Operation=ItemSearch&ResponseGroup=Images%2CItemAttributes&SearchIndex=All&Service=AWSECommerceService&Timestamp=20140710&Version=2011-08-01"

    HTTParty.get(api_call)
  end

  def self.search_url(search_term)

    require 'openssl'
    require 'Base64'

    key = "5Yhv3A5LCzbBeDmNlzDW4j4fIdhfWNyVFEFF2IFd"
    data = "GET
webservices.amazon.com
/onca/xml
AWSAccessKeyId=AKIAJOST6FYFMTXDJ3NA&AssociateTag=giftrcom-20&Condition=All&Keywords=#{URI.escape(search_term)}&Operation=ItemSearch&ResponseGroup=Images+ItemAttributes&SearchIndex=All&Service=AWSECommerceService&Timestamp=#{Time.now.iso8601}&Version=2011-08-01"

    sig_code = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'), key, data)).strip()
    sig_code.gsub!(/\+/, "%2")
    sig_code.gsub!(/\//, "%2")
    sig_code.gsub!(/\=/, "%3D")

    data = data.split("\n")
    "http://"+data[1]+data[2]+"?"+data[3]+"&Signature="+sig_code

  end
end
