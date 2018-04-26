require 'spec_helper'

describe ChineseCapital do
  context 'to chinese capital' do
    it "should go works for -1.003" do
      expect(ChineseCapital.parse(-1.003)).to eq('负一点零零三')
    end

    it "should go works for 0.003" do
      expect(ChineseCapital.parse(0.003)).to eq('零点零零三')
    end

    it "should go works for 0.03" do
      expect(ChineseCapital.parse(0.03)).to eq('零点零三')
    end

    it "should go works for 0.3" do
      expect(ChineseCapital.parse(0.3)).to eq('零点三')
    end

    it "should go works for 0.0" do
      expect(ChineseCapital.parse(0.0)).to eq('零')
    end

    it "should go works for 0" do
      expect(ChineseCapital.parse(0)).to eq('零')
    end

    it "should go works for 1.003" do
      expect(ChineseCapital.parse(1.003)).to eq('一点零零三')
    end

    it "should go works for 3" do
      expect(ChineseCapital.parse(3)).to eq('三')
    end

    it "should go works for 30" do
      expect(ChineseCapital.parse(30)).to eq('三十')
    end

    it "should go works for 103" do
      expect(ChineseCapital.parse(103)).to eq('一百零三')
    end

    it "should go works for 1003" do
      expect(ChineseCapital.parse(1003)).to eq('一千零三')
    end

    it "should go works for 1103" do
      expect(ChineseCapital.parse(1103)).to eq('一千一百零三')
    end

    it "should go works for 10103" do
      expect(ChineseCapital.parse(10103)).to eq('一万零一百零三')
    end

    it "should go works for 100003" do
      expect(ChineseCapital.parse(100003)).to eq('一十万零三')
    end

    it "should go works for 100103" do
      expect(ChineseCapital.parse(100103)).to eq('一十万零一百零三')
    end
  end

  context 'to chinese money' do
    it "should go works for -1.003" do
      expect(ChineseCapital.to_money(-1.003)).to eq('负壹元整')
    end

    it "should go works for -0.03" do
      expect(ChineseCapital.to_money(-0.03)).to eq('负叁分')
    end

    it "should go works for 0.003" do
      expect(ChineseCapital.to_money(0.003)).to eq('零元整')
    end

    it "should go works for 0.03" do
      expect(ChineseCapital.to_money(0.03)).to eq('叁分')
    end

    it "should go works for 0.3" do
      expect(ChineseCapital.to_money(0.3)).to eq('叁角')
    end

    it "should go works for 0" do
      expect(ChineseCapital.to_money(0)).to eq('零元整')
    end

    it "should go works for 1.03" do
      expect(ChineseCapital.to_money(1.03)).to eq('壹元零叁分')
    end

    it "should go works for 1.003" do
      expect(ChineseCapital.to_money(1.003)).to eq('壹元整')
    end

    it "should go works for 3" do
      expect(ChineseCapital.to_money(3)).to eq('叁元整')
    end

    it "should go works for 30" do
      expect(ChineseCapital.to_money(30)).to eq('叁拾元整')
    end

    it "should go works for 103" do
      expect(ChineseCapital.to_money(103)).to eq('壹佰零叁元整')
    end

    it "should go works for 1003" do
      expect(ChineseCapital.to_money(1003)).to eq('壹仟零叁元整')
    end

    it "should go works for 1103" do
      expect(ChineseCapital.to_money(1103)).to eq('壹仟壹佰零叁元整')
    end

    it "should go works for 10103" do
      expect(ChineseCapital.to_money(10103)).to eq('壹万零壹佰零叁元整')
    end

    it "should go works for 100003" do
      expect(ChineseCapital.to_money(100003)).to eq('壹拾万零叁元整')
    end

    it "should go works for 100103" do
      expect(ChineseCapital.to_money(100103)).to eq('壹拾万零壹佰零叁元整')
    end
  end
end
