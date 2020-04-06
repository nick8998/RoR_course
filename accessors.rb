module Accessors
  
  def attr_accessor_with_history(*names)
    values = {}
    value_a = []
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        value_a << value
        instance_variable_set(var_name, value)
        values[name] = value_a
      end
      define_method("#{name}_history".to_sym) do 
        values[name].each { |value| print "#{value} " }
      end
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

