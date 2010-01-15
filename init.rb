module ValidatesCoordinatesFormatOf 

  def validates_longitude_format_of(*attr_names)
    # Set the default configuration
    configuration = { :allow_nil => false }

    # Update defaults with any supplied configuration values
    configuration.update(attr_names.extract_options!)

    # Validate each attribute, passing in the configuration
    validates_each(attr_names, configuration) do |record, attr_name, value|
      if !value.nil?
        record.errors.add(attr_name, 'does not appear to be a valid latitude') if value > 180 or value < -180
      elsif value.nil? and !configuration[:allow_nil]
        record.errors.add(attr_name, 'cannot be null')
      end
    end
  end

  def validates_latitude_format_of(*attr_names)
    # Set the default configuration
    configuration = { :allow_nil => false }

    # Update defaults with any supplied configuration values
    configuration.update(attr_names.extract_options!)

    # Validate each attribute, passing in the configuration
    validates_each(attr_names, configuration) do |record, attr_name, value|
      if !value.nil?
        record.errors.add(attr_name, 'does not appear to be a valid latitude') if value < -90 or value > 90
      elsif value.nil? and !configuration[:allow_nil]
        record.errors.add(attr_name, 'cannot be null')
      end
    end
  end

end

ActiveRecord::Base.extend(ValidatesCoordinatesFormatOf)

