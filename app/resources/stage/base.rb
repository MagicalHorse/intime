# encoding: utf-8
module Stage
  class Base < ActiveResource::Base
    self.site="http://mockup"
    self.element_name="mockup"
  end
end
