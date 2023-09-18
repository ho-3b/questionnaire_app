class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid_email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

    unless value =~ valid_email_regexp
      record.errors.add attribute, (options[:message] || "の形式が不正です。")
    end
  end
end