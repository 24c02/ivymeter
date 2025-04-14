# frozen_string_literal: true

module IvyMeter
  module Prop
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def prop(name, json_name, _csv_name, type: :string)
        define_method(name) do
          value = @data[json_name]
          return nil if value.nil?

          case type
          when :date
            Date.parse(value)
          when :datetime
            value.is_a?(DateTime) ? value : DateTime.parse(value)
          else
            value
          end
        end

        define_method("#{name}=") do |value|
          return @data[json_name] = nil if value.nil?

          @data[json_name] = case type
                             when :date
                               value.is_a?(Date) ? value : Date.parse(value)
                             when :datetime
                               if value.is_a?(DateTime)
                                 value
                               else
                                 begin
                                   DateTime.parse(value)
                                 rescue ArgumentError
                                   DateTime.iso8601(value)
                                 end
                               end
                             else
                               value
                             end
        end
      end
    end
  end
end
