class Amazon

  def self.search(search_term)
    amazon_items = amazon_search(search_term)['ItemSearchResponse']['Items']['Item']

    results = Array.new

    amazon_items.each do |item_hash|
      info = item_hash['ItemAttributes']

      item = Hash.new
      item[:name] = info['Title']
      item[:category] = info['Binding'] ? info['Binding'] : "None"
      item[:price] = info['ListPrice'] ? info['ListPrice']['Amount'].to_i : 0
      item[:small_image_url] = item_hash['SmallImage']['URL']
      item[:large_image_url] = item_hash['LargeImage']['URL']
      item[:amazon_url] = item_hash['DetailPageURL']

      results << item
    end

    results
  end

  def self.amazon_search(search_term)

    iso_time = "9999-12-31T23%3A59%3A59.000Z"

    # iso_time = Time.now.iso8601.split("-")
    # day_ahead = iso_time[2].split("T")
    # iso_time[2] = (day_ahead.first.to_i + 1).to_s + "T" + day_ahead.last
    # iso_time = iso_time[0]+"-"+iso_time[1]+"-"+iso_time[2]+".000Z"


    key = ENV["AWSSecretKey"]
    access_key= ENV["AWSAccessKeyId"]
    data = "GET
webservices.amazon.com
/onca/xml
AWSAccessKeyId=#{access_key}&AssociateTag=giftrcom-20&Condition=All&Keywords=#{URI.escape(search_term)}&Operation=ItemSearch&ResponseGroup=Images%2CItemAttributes&SearchIndex=All&Service=AWSECommerceService&Timestamp=#{iso_time}&Version=2011-08-01"

    sig_code = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data)).strip()
    # sig_code.gsub!(/\+/, "%2")
    # sig_code.gsub!(/\//, "%2")
    # sig_code.gsub!(/\=/, "%3D")

    data = data.split("\n")

    api_call = "http://"+data[1]+data[2]+"?"+data[3]+"&Signature="+CGI.escape(sig_code)
    HTTParty.get(api_call)

  end
end
