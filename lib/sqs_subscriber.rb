# encoding: utf-8
require 'json'
module ISAwsSqs
  ROUTES_NAME = %w(comment storecoupon promotioncoupon)
  class Subscriber
    # msg is hash with the format of {:type,:data}
    def self.dispatch(message)
      return if message.nil?
      msg = JSON.parse message,:symbolize_names => true
      route_name = msg[:type].downcase
      Rails.logger.info "begin process route:#{route_name}"
      return unless ROUTES_NAME.include?(route_name)
      case route_name
      when 'comment'
        CommentES.subscribe msg[:data]
      when 'storecoupon'
        StoreCoupon.sync_one msg[:data],1
      when 'promotioncoupon'
        StoreCoupon.sync_one msg[:data],2
       else
         return
       end
      
    end
  end
end
