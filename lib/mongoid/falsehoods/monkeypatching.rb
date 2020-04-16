require 'mongoid'

class FalseClass
  def __evolve_time__
    false
  end
end

module Mongoid
  module Extensions
    module DateTime
      module ClassMethods
        alias_method :original_mongoize, :mongoize
        alias_method :original_demongoize, :demongoize

        def mongoize(object)
          return false if object == false

          original_mongoize(object)
        end

        def demongoize(object)
          return false if object == false

          original_demongoize(object)
        end
      end
    end
  end
end

module Mongoid
  module Extensions
    module Time
      module ClassMethods
        alias_method :original_mongoize, :mongoize
        alias_method :original_demongoize, :demongoize

        def mongoize(object)
          return false if object == false

          original_mongoize(object)
        end

        def demongoize(object)
          return false if object == false

          original_demongoize(object)
        end
      end
    end
  end
end

::DateTime.extend(Mongoid::Extensions::DateTime::ClassMethods)
::Time.extend(Mongoid::Extensions::Time::ClassMethods)
