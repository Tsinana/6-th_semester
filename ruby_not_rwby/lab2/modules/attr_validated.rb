module AttrValidated
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def attr_validated(*args, &validator)
      args.each_with_index do |name, index|
        define_method("#{name}=") do |value|
          if block_given? && index == 0
            raise ArgumentError, "Value '#{value}' is invalid" unless validator.call(value)
          end

          instance_variable_set("@#{name}", value)
        end

        define_method(name) do
          instance_variable_get("@#{name}")
        end
      end
    end

    def attr_writer_validated(*args, &validator)
      args.each_with_index do |name, index|
        define_method("#{name}=") do |value|
          if block_given? && index == 0
            raise ArgumentError, "Value '#{value}' is invalid" unless validator.call(value)
          end
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end