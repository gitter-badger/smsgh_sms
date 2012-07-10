require "smsgh_sms/version"
require 'cgi'

module SmsghSms
  API_URL = "http://api.smsgh.com/v2/messages/send?"
  @@api_username = nil
  @@api_password = nil
  @@api_senderid = "SMSGH-API"
  
  # Expects :msg, :to and an optional :from param
  # The :from param defaults to @@api_senderid when its omitted
  
  def self.push(options={})
    url_construct = "#{API_URL}&username=#{@@api_username}&password=#{@@api_password}&from=#{@@api_senderid}"
    full_url = "#{url_construct}&text=#{CGI.escape(options[:msg])}&to=#{options[:to]}"
    raise ArgumentError, ':msg and :to params expected' if options[:msg].nil? || options[:to].nil?
    response = CurbFu.get(full_url)
    {:status => response.status, :message => response.body}
  end
end