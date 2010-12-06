module AttrOptional

  def self.included(klass)
    klass.send :extend, ClassMethods
  end

  module ClassMethods

    def inherited(klass)
      super
      unless optional_attributes.empty?
        klass.attr_optional *optional_attributes
      end
    end

    def attr_optional(*keys)
      @optional_attributes ||= []
      @optional_attributes += Array(keys)
      attr_accessor *keys
    end

    def attr_optional?(key)
      optional_attributes.include?(key)
    end

    def optional_attributes
      Array(@optional_attributes)
    end

  end

  def optional_attributes
    self.class.optional_attributes
  end

  def attr_optional?(key)
    self.class.attr_optional? key
  end

end