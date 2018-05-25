# ChineseCapital

将数字转换成中文或中文大写金额。

## 安装

Add this line to your application's Gemfile:

```ruby
  gem 'chinese_capital'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chinese_capital

## 使用

数字转中文

```ruby
  ChineseCapital.parse(10103)  # => 一万零一百零三
```

数字转大写金额

```ruby
  ChineseCapital.to_money(10103)  # => 壹万零壹佰零叁元整
```

使用自定义配置

在Rails 'config/initializers/' 目录下, 新建文件 'chinese_capital.rb', 并添加：

config/initializers/chinese_capital.rb

```ruby
  ChineseCapital::Number.configure do |config|
    config.normal = {
      figure: '〇一二三四五六七八九'
    }
    config.money = {
      unit: '美元'
    }
  end
```

```ruby
  ChineseCapital.parse(10103)  # => 一万〇一百〇三
  ChineseCapital.to_money(10103)  # => 壹万零壹佰零叁美元整
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
