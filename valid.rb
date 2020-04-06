module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, extra = nil)
      @name =  "@#{name}".to_sym 
      @type = "@#{type}".to_sym
      @extra = extra
    end
  end

  module InstanceMethods
    def validate!
      var_type = self.class.instance_variable_get(:@type)
      var_name = self.instance_variable_get(self.class.instance_variable_get(:@name))
      var_extra = self.class.instance_variable_get(:@extra)
      if var_type == :@presence
        raise "Enter name" if var_name.nil? or var_name == ""
      elsif var_type == :@format
        raise "Invalid format" if var_name !~ var_extra
      elsif var_type == :@type
        raise "Invalid type" if var_name.class != var_extra
      end
    end

    def valid?
      validate!
      true 
      rescue
      false
    end
  end

end

 
