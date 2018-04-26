module ChineseCapital
  require 'bigdecimal'

  class Number
    NORMAL_FIGURE = '零一二三四五六七八九'.chars
    MONEY_FIGURE = '零壹贰叁肆伍陆柒捌玖'.chars
    NORMAL_MINOR_UNITS = '十百千'.chars.unshift(nil)
    MONEY_MINOR_UNITS = '拾佰仟'.chars.unshift(nil)
    MAJOR_UNITS = '万亿'.chars.unshift(nil)
    MONEY_DECIMAL_UNITS = '角分'.chars
    MONEY_UNIT = '元'.freeze
    ROUND_UNIT = '整'.freeze
    POINT_UNIT = '点'.freeze
    MINUS_UNIT = '负'.freeze

    class << self
      def parse(num)
        result = []
        b_num = BigDecimal(num.to_s)

        return '零' if b_num.zero?

        temp = b_num.abs.divmod(1)
        round_section = temp[0].to_s('F').to_i
        decimal_section = temp[1].to_s('F').split('.')[1]

        result_round_section = round_section_zh(round_section)
        result << result_round_section unless result_round_section.empty?
        result << NORMAL_FIGURE[0] if temp[1] != 0 && result.empty?
        result << POINT_UNIT unless temp[1].zero?
        result << decimal_section_zh(decimal_section) unless temp[1].zero?
        result.unshift(MINUS_UNIT) if b_num < 0
        result.join
      end

      def to_money(num)
        result = []
        # 金额只保留前两位小数
        b_num = BigDecimal(num.to_s).truncate(2)

        return "零#{MONEY_UNIT}#{ROUND_UNIT}" if b_num.zero?

        temp = b_num.abs.divmod(1)
        round_section = temp[0].to_s('F').to_i
        decimal_section = temp[1].to_s('F').split('.')[1]

        result_round_section = round_section_zh(round_section, 'money')
        result << result_round_section unless result_round_section.empty?
        result << MONEY_UNIT unless result_round_section.empty?
        unless temp[1].zero?
          result_decimal_section = decimal_section_zh(decimal_section, 'money')
          result_decimal_section.gsub!(/(?<=\A|["#{MONEY_FIGURE[0]}"])["#{MONEY_FIGURE[0]}"]+/, '') if result.empty?
          result << result_decimal_section
        end
        result << ROUND_UNIT if BigDecimal(decimal_section).zero?
        result.unshift(MINUS_UNIT) if b_num < 0 && result
        result.join
      end

      private

      def round_section_zh(num, parse_type='normal')
        result = []
        unit_index = -1

        figure_type = Number.const_get("#{parse_type.upcase}_FIGURE")
        unit_type = Number.const_get("#{parse_type.upcase}_MINOR_UNITS")

        num.to_s.chars.map(&:to_i).reverse.each_slice(4) do |figures|
          section = figures.zip(unit_type).map do |figure, unit|
            figure ||= 0
            if figure.zero?
              figure_type[0]
            else
              "#{figure_type[figure]}#{unit}"
            end
          end.reverse.join

          unit_index += 1

          section.gsub!(/["#{figure_type[0]}"]+\z/x, '')

          next if section.empty?

          result << round_section_unit(unit_index)
          result << section
        end

        result.reverse.join.gsub(/(?<=\A|["#{figure_type[0]}"])["#{figure_type[0]}"]+/, '')
      end

      def round_section_unit(unit_index)
        MAJOR_UNITS[1] * (unit_index % 2) + MAJOR_UNITS[2] * (unit_index / 2)
      end

      def decimal_section_zh(num, parse_type='normal')
        figure_type = Number.const_get("#{parse_type.upcase}_FIGURE")
        figures = if parse_type == 'money'
                    num.chars.map(&:to_i).zip(MONEY_DECIMAL_UNITS)
                  else
                    num.chars.map(&:to_i).zip([])
                  end

        figures.map do |figure, unit|
          if figure.zero?
            figure_type[0]
          else
            "#{figure_type[figure]}#{unit}"
          end
        end.join
      end
    end
  end
end
