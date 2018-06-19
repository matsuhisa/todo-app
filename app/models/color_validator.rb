class ColorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    binding.pry
    unless value =~ /\A#([\da-fA-F]{6}|[\da-fA-F]{3})\z/
      record.errors[attribute] << '入力が正しくありません'
    end
  end
end
