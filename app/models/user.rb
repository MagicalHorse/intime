# encoding: utf-8
class User < ActiveRecord::Base
  include Tire::Model::Search
  index_name ES_DEFAULT_INDEX
  document_type 'esusers'
  attr_accessible :email, :level, :logo, :mobile, :name, :nickie, :pwd, :status

  class<<self
    def esfind_by_id(user_id)
      model = self.search :per_page=>1,:page=>1 do 
            query do
              match :id,user_id
            end
          end
      return nil if model.total<=0
      return model.results[0]
    end
  end
end
