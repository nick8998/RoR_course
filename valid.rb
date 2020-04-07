module Validation
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances_variable = 0
    def validate(name, type, extra = nil)
      valid = self.class_variable_get(:@@valid_values)
      name =  "@#{name}".to_sym
      type = "@#{type}".to_sym
      valid[@@instances_variable] = [name, type, extra] unless extra.nil?
      valid[@@instances_variable] = [name, type] if extra.nil?
      @@instances_variable += 1
      define_method("validate_@presence".to_sym) { raise "Enter name" if @valid_name.nil? or @valid_name == "" }
      define_method("validate_@format".to_sym) { raise "Invalid format" if @valid_name !~ @valid_extra }
      define_method("validate_@type".to_sym) { raise "Invalid type" if @valid_name.class != @valid_extra } 
    end
  end

  module InstanceMethods
    def validate!
      valid = self.class.class_variable_get(:@@valid_values)
      valid.each do |key, value|
        @valid_name = self.instance_variable_get(value[0])
        @valid_type = value[1]
        @valid_extra = value[2]
        send("validate_#{@valid_type}")
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


 
