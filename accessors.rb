module Accessors
  
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      names_history = "@#{name}_history".to_sym
      names_history = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        names_history << value
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history".to_sym) { names_history }
    end
  end
  
  def strong_attr_accessor(name, var_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        if value.class == var_class
          instance_variable_set(var_name, value)
        else
          raise "Error in class variables" 
        end
      end
  end
end

class Check
  extend Accessors
  attr_accessor_with_history :a
end

