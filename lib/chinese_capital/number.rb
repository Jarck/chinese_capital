module ChineseCapital
  require 'bigdecimal'
  require 'chinese_capital/configuration'

  class Number
    class << self
      attr_accessor :config

      def config
        @config ||= Configuration.new
      end

      def reset
        @config = Configuration.new
      end

      def configure
        yield(config)
      end

      def parse(num)
        result = []
        b_num = BigDecimal(num.to_s)

        normal_zero = config.normal[:figure][0]
        return normal_zero if b_num.zero?

        temp = b_num.abs.divmod(1)
        round_section = temp[0].to_s('F').to_i
        decimal_section = temp[1].to_s('F').split('.')[1]

        result_round_section = round_section_zh(round_section)
        result << result_round_section unless result_round_section.empty?
        result << normal_zero if temp[1] != 0 && result.empty?
        result << config.normal[:point_unit] unless temp[1].zero?
        result << decimal_section_zh(decimal_section) unless temp[1].zero?
        result.unshift(config.normal[:minus_unit]) if b_num < 0
        result.join
      end

      def to_money(num)
        result = []

        # 金额只保留前两位小数
        b_num = BigDecimal(num.to_s).truncate(2)

        money_zero = config.money[:figure][0]
        return "#{money_zero}#{config.money[:unit]}#{config.money[:round_unit]}" if b_num.zero?

        temp = b_num.abs.divmod(1)
        round_section = temp[0].to_s('F').to_i
        decimal_section = temp[1].to_s('F').split('.')[1]

        result_round_section = round_section_zh(round_section, 'money')
        result << result_round_section unless result_round_section.empty?
        result << config.money[:unit] unless result_round_section.empty?
        unless temp[1].zero?
          result_decimal_section = decimal_section_zh(decimal_section, 'money')
          result_decimal_section.gsub!(/(?<=\A|["#{money_zero}"])["#{money_zero}"]+/, '') if result.empty?
          result << result_decimal_section
        end
        result << config.money[:round_unit] if BigDecimal(decimal_section).zero?
        result.unshift(config.money[:minus_unit]) if b_num < 0 && result
        result.join
      end

      private

      def round_section_zh(num, parse_type='normal')
        result = []
        unit_index = -1

        figure_type = config.send(parse_type.to_sym)[:figure]
        unit_type = config.send(parse_type.to_sym)[:minor_units]

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

          result << round_section_unit(unit_index, parse_type)
          result << section
        end

        result.reverse.join.gsub(/(?<=\A|["#{figure_type[0]}"])["#{figure_type[0]}"]+/, '')
      end

      def round_section_unit(unit_index, parse_type)
        major_units = config.send(parse_type.to_sym)[:major_units]
        major_units[1] * (unit_index % 2) + major_units[2] * (unit_index / 2)
      end

      def decimal_section_zh(num, parse_type='normal')
        figure_type = config.send(parse_type.to_sym)[:figure]
        figures = if parse_type == 'money'
                    num.chars.map(&:to_i).zip(config.money[:decimal_units])
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
