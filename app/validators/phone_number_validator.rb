class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'не соответствует правильному формату') unless value =~ /\d{3}-\d{3}-\d{4}/
  end
end