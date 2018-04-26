require "chinese_capital/version"
require "chinese_capital/number"

module ChineseCapital

  # transform number to chinese numerals
  #
  # Example:
  #   >> ChineseCapital.parse(30)
  #   => 三十
  #
  # Arguments:
  #   num: (String/Integer)
  def self.parse(num)
    Number.parse(num)
  end

  # transform number to chinese money
  #
  # Example:
  #   >> ChineseCapital.to_money(30)
  #   => 叁拾元整
  #
  # Arguments:
  #   num: (String/Integer)
  def self.to_money(num)
    Number.to_money(num)
  end
end
