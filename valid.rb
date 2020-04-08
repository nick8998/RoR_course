module Validation
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, extra = nil)
      @valid_checks ||= []
      @valid_checks << { type: type, name: "@#{name}".to_sym, extra: extra} 
    end
  end

  module InstanceMethods
    def validate!
      valid_checks = self.class.instance_variable_get(:@valid_checks)
      valid_checks.each do |check|
        value = self.class.instance_variable_get(check[:name])
        send("validate_#{check[:type]}", value, check[:extra])
      end
    end

    def validate_presence(name, extra)
      raise "Enter name" if name.nil? or name == ""
    end

    def validate_format(name, extra)
      raise "Invalid format" if name !~ extra
    end

    def validate_type(name, extra)
      raise "Invalid type" if name.class != extra
    end

    def valid?
      validate!
      true 
    rescue
      false
    end
  end

end



