class Amazon

  def self.basic_info_hash(response)

  end

  def self.search(search_term)

    iso_time = Time.now.iso8601.split("-")
    day_ahead = iso_time[2].split("T")
    iso_time[2] = (day_ahead.first.to_i + 1).to_s + "T" + day_ahead.last
    iso_time = iso_time[0]+"-"+iso_time[1]+"-"+iso_time[2].gsub(/\:/, "%3A")+".000Z"

    key = "5Yhv3A5LCzbBeDmNlzDW4j4fIdhfWNyVFEFF2IFd"
    data = "GET
webservices.amazon.com
/onca/xml
AWSAccessKeyId=AKIAJOST6FYFMTXDJ3NA&AssociateTag=giftrcom-20&Condition=All&Keywords=#{URI.escape(search_term)}&Operation=ItemSearch&ResponseGroup=Images%2CItemAttributes&SearchIndex=All&Service=AWSECommerceService&Timestamp=#{iso_time}&Version=2011-08-01"

    sig_code = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data)).strip()
    # sig_code.gsub!(/\+/, "%2")
    # sig_code.gsub!(/\//, "%2")
    # sig_code.gsub!(/\=/, "%3D")

    CGI.escape(sig_code)

    data = data.split("\n")

    api_call = "http://"+data[1]+data[2]+"?"+data[3]+"&Signature="+sig_code
    HTTParty.get(api_call)
  end
end
