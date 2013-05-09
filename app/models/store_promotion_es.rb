require 'tire'
require 'json'
class StorePromotionES
  include Tire::Model::Persistence
  index_name ES_DEFAULT_INDEX
  document_type 'esstorepromotions'
  property :name
  property :description
  property :createDate
  property :activeStartDate
  property :activeEndDate
  property :couponStartDate
  property :couponEndDate
  property :notice
  property :minPoints
  property :usageNotice
  property :inScopeNotice
  property :promotionType
  property :acceptPointType
  property :status
  property :createUser
  property :exchangeRule
  property :unitPerPoints
  
  def exchangerule_message
    t(:exchangepointsuccess).sub('[minpoints]',self.minPoints.to_s).sub('[unitperpoints]',self.unitPerPoints)
  end
end