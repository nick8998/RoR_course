module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanseMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanseMethods
    protected
    def register_instance
      self.class.instances ||=0
      self.class.instances += 1
    end
  end

end