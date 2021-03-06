# ChineseCapital

transform number to chinese numerals or to chinese money.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'chinese_capital'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chinese_capital

## Usage

transform number to chinese numerals


```ruby
  ChineseCapital.parse(10103)  # => 一万零一百零三
```

transform number to chinese money

```ruby
  ChineseCapital.to_money(10103)  # => 壹万零壹佰零叁元整
```

with custom config

In Rails direction 'config/initializers/', create file 'chinese_capital.rb', and add code：

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
