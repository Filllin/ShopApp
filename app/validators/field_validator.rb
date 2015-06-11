class FieldValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'не может быть пустым') unless value.present?
  end
end