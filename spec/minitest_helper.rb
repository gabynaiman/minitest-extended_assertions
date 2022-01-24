require 'coverage_helper'
require 'minitest/autorun'
require 'minitest/colorin'
require 'pry-nav'

require 'minitest/extended_assertions'
require_relative 'equal_hash_examples'
require_relative 'equal_array_examples'
require_relative 'equal_json_examples'

class Minitest::Test

  private

  def assert_fail_with_error(expected_error)
    begin
      yield
      fail "Expected assertion fail with message:\n#{expected_error}"

    rescue Minitest::Assertion => error
      assert_equal expected_error, error.message
    end
  end

  def deep_clone(object)
    Marshal.load(Marshal.dump(object))
  end

end