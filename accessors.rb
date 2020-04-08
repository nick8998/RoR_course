module Accessors
  
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      name_history = "@#{name}_history".to_sym
      values = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        values << value
        instance_variable_set(var_name, value)
        instance_variable_set(name_history, values)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(name_history) }
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


