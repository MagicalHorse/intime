# encoding: utf-8
class V22::SpecialTopicController < SpecialTopicController
# list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort}
  # ouput:
  # => {}
  def list

   
    return render :json=>SpecialTopic.list_by_page({
      :page=>params[:page],
      :pagesize=>params[:pagesize],
      :type=>params[:type],
      :refreshts=>params[:refreshts]
    })
    
  end
end
