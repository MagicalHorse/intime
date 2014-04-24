# encoding: utf-8
class Version < ActiveRecord::Base
  attr_accessible :desc, :downloadurl, :no, :status,:versionno,:updatetype
  
  class << self
    def version_fromstring(version)
      return 0 if version.nil?
      version_int = 0
      version.split('.'). each_with_index do |v,i|
      break if i > 2
      version_int += v.to_i*(10 ** (2-i))
      end
      version_int
    end
  end
end
