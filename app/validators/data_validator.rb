class DataValidator
  def self.make(data, validations)
    Class.new do
      include ActiveModel::Validations

      attr_reader(*validations.keys)

      validations.each do |attribute, attribute_validations|
        validates attribute, attribute_validations
      end

      def self.model_name
        ActiveModel::Name.new(self, nil, "DataValidator::Validator")
      end

      def initialize(data)
        data.each do |key, value|
          self.instance_variable_set("@#{key.to_sym}", value)
        end
      end
    end.new(data)
  end
end