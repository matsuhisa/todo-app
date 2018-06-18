class ColorValidator < ActiveModel::EachValidator
  def validator_each(record, attribute, value)
    unless value =~ /\A#([\da-fA-F]{6}|[\da-fA-F]{3})\z/
      record.errors[attribute] << '入力が正しくありません'
    end
  end
end
