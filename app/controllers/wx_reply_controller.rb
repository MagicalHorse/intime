# encoding: utf-8
class WxReplyController < ApiBaseController
  def update
    input_data = params[:data]
    return render :json=> error_500_msg('data is emtpy') if input_data.nil?
    reply = WxReplyMsg.find_or_initialize_by_rkey(input_data[:rkey])
    reply.status= input_data[:status]
    reply.rkey =input_data[:rkey]
    reply.rmsg= input_data[:rmsg]
      
    reply.save
    return render :json=> succ_200
  end
end
