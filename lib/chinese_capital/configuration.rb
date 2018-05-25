module ChineseCapital
  class Configuration
    attr_accessor :normal, :money

    NORMAL = {
      figure: '零一二三四五六七八九',
      minor_units: '十百千',
      major_units: '万亿',
      point_unit: '点',
      minus_unit: '负'
    }

    MONEY = {
      figure: '零壹贰叁肆伍陆柒捌玖',
      minor_units: '拾佰仟',
      major_units: '万亿',
      decimal_units: '角分',
      unit: '元',
      round_unit: '整',
      minus_unit: '负'
    }

    def initialize
      @normal = deal_attribute('normal')
      @money = deal_attribute('money')
    end

    def normal=(hash_normal)
      @normal = deal_attribute('normal', hash_normal)
    end

    def money=(hash_money)
      @money = deal_attribute('money', hash_money)
    end

    private

    def deal_attribute(type, value={})
      value = value.map { |k, v| [k.to_sym, v] }.to_h
      attribute = if type == 'normal'
                    @normal = NORMAL.merge(value)
                  elsif type == 'money'
                    @money = MONEY.merge(value)
                  end
      attribute[:figure] = attribute[:figure].strip.chars
      attribute[:minor_units] = attribute[:minor_units].strip.chars.unshift(nil)
      attribute[:major_units] = attribute[:major_units].strip.chars.unshift(nil)
      attribute[:decimal_units] = attribute[:decimal_units].strip.chars if attribute[:decimal_units]
      attribute
    end
  end
end
