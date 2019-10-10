module OpenAPIParser
  class OpenAPIError < StandardError
    def initialize(reference)
      @reference = reference
    end
  end

  class ValidateError < OpenAPIError
    def initialize(data, type, reference)
      super(reference)
      @data = data
      @type = type
    end

    def message
      "#{@reference} expected #{@type}, but received #{@data.class}: #{@data}"
    end

    class << self
      # create ValidateError for SchemaValidator return data
      # @param [Object] value
      # @param [OpenAPIParser::Schemas::Base] schema
      def build_error_result(value, schema)
        [nil, OpenAPIParser::ValidateError.new(value, schema.type, schema.object_reference)]
      end
    end
  end

  class NotNullError < OpenAPIError
    def message
      "#{@reference} does not allow null values"
    end
  end

  class NotExistRequiredKey < OpenAPIError
    def initialize(keys, reference)
      super(reference)
      @keys = keys
    end

    def message
      "#{@reference} missing required parameters: #{@keys.join(", ")}"
    end
  end

  class NotExistPropertyDefinition < OpenAPIError
    def initialize(keys, reference)
      super(reference)
      @keys = keys
    end

    def message
      "#{@reference} does not define properties: #{@keys.join(", ")}"
    end
  end

  class NotExistDiscriminatorMappedSchema < OpenAPIError
    def initialize(mapped_schema_reference, reference)
      super(reference)
      @mapped_schema_reference = mapped_schema_reference
    end

    def message
      "discriminator mapped schema #{@mapped_schema_reference} does not exist in #{@reference}"
    end
  end

  class NotExistDiscriminatorPropertyName < OpenAPIError
    def initialize(key, value, reference)
      super(reference)
      @key   = key
      @value = value
    end

    def message
      "discriminator propertyName #{@key} does not exist in value #{@value} in #{@reference}"
    end
  end

  class NotOneOf < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} isn't one of in #{@reference}"
    end
  end

  class NotAnyOf < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} isn't any of in #{@reference}"
    end
  end

  class NotEnumInclude < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} isn't include enum in #{@reference}"
    end
  end

  class LessThanMinimum < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} cannot be less than minimum value in #{@reference}"
    end
  end

  class LessThanExclusiveMinimum < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} cannot be less than or equal to exclusive minimum value in #{@reference}"
    end
  end

  class MoreThanMaximum < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} cannot be more than maximum value in #{@reference}"
    end
  end

  class MoreThanExclusiveMaximum < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@value} cannot be more than or equal to exclusive maximum value in #{@reference}"
    end
  end

  class InvalidPattern < OpenAPIError
    def initialize(value, pattern, reference)
      super(reference)
      @value = value
      @pattern = pattern
    end

    def message
      "#{@reference} pattern #{@pattern} does not match value: #{@value}"
    end
  end

  class InvalidEmailFormat < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@reference} email address format does not match value: #{@value}"
    end
  end

  class NotExistStatusCodeDefinition < OpenAPIError
    def message
      "#{@reference} status code definition does not exist"
    end
  end

  class NotExistContentTypeDefinition < OpenAPIError
    def message
      "#{@reference} response definition does not exist"
    end
  end

  class MoreThanMaxLength < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@reference} #{@value} is longer than max length"
    end
  end

  class LessThanMinLength < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@reference} #{@value} is shorter than min length"
    end
  end

  class MoreThanMaxItems < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@reference} #{@value} contains more than max items"
    end
  end

  class LessThanMinItems < OpenAPIError
    def initialize(value, reference)
      super(reference)
      @value = value
    end

    def message
      "#{@reference} #{@value} contains fewer than min items"
    end
  end
end
