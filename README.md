# ExcelUtils

[![Gem Version](https://badge.fury.io/rb/minitest-extended_assertions.svg)](https://rubygems.org/gems/minitest-extended_assertions)
[![Build Status](https://travis-ci.com/gabynaiman/minitest-extended_assertions.svg?branch=master)](https://travis-ci.com/gabynaiman/minitest-extended_assertions)
[![Coverage Status](https://coveralls.io/repos/github/gabynaiman/minitest-extended_assertions/badge.svg?branch=master)](https://coveralls.io/github/gabynaiman/minitest-extended_assertions?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/minitest-extended_assertions.svg)](https://codeclimate.com/github/gabynaiman/minitest-extended_assertions)

Extended assertions for Minitest

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-extended_assertions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-extended_assertions

## Usage

### Hash
```ruby
expected = {a: 1, b: 2}
actual = {a: 2, b: 1}

assert_equal_hash expected, actual
actual.must_equal_hash expected

# [:a]
# Expected: 1
#   Actual: 2

# [:b]
# Expected: 2
#   Actual: 1
```

### Array
```ruby
expected = [1, 2, 3, 4]
actual = [1, 20, 3, 40]

assert_equal_array expected, actual
actual.must_equal_array expected

# [1]
# Expected: 2
#   Actual: 20

# [3]
# Expected: 4
#   Actual: 40
```

### JSON
```ruby
expected = '{"a": 1, "b": 2}'
actual = '{"a": 2, "b": 1}'

assert_equal_json expected, actual
actual.must_equal_json expected

# ["a"]
# Expected: 1
#   Actual: 2

# ["b"]
# Expected: 2
#   Actual: 1
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/minitest-extended_assertions.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).