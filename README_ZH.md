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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
