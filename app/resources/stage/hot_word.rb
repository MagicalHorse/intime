module Stage
  class HotWord < Stage::Base
    self.collection_name = :hotword

    class << self
      def list
        get(:list)
      end
    end

  end
end
