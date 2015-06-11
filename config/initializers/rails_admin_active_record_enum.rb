module ActiveRecord
  module RailsAdminEnum
    def enum(definitions)
      super

      definitions.each do |name, values|
        define_method("#{ name }_enum") { self.class.send(name.to_s.pluralize).to_a }

        define_method("#{ name }_enum") {
          self.class.send(name.to_s.pluralize).to_a.map do |k, v|
            translated = I18n.t(k, scope: [:activerecord, :attributes, self.class.to_s.downcase, name.to_s.pluralize])
            processed_key = translated.include?('translation missing') ? k : translated
            [processed_key, v]
          end
        }
      end
    end
  end
end
