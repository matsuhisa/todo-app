class ColorValidator < ActiveModel::EachValidator
  def validator_each(record, attribute, value)
    record.errors[attribute] << '入力が正しくありません' unless
      value =~ /\A#([\da-fA-F]{6}|[\da-fA-F]{3})\z/
  end
end
