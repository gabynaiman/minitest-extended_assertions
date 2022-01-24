require 'json'

require_relative 'extended_assertions/version'
require_relative 'extended_assertions/deep_comparator'

module Minitest
  module Assertions

    def assert_equal_hash(expected, actual)
      differences = ExtendedAssertions::DeepComparator.compare expected, actual
      assert differences.empty?, differences.map(&:to_s).join("\n\n")
    end
    alias_method :assert_equal_array, :assert_equal_hash

    def assert_equal_json(expected, actual)
      assert_equal_hash JSON.parse(expected), JSON.parse(actual)
    end

  end

  module Expectations

    infect_an_assertion :assert_equal_hash, :must_equal_hash

    infect_an_assertion :assert_equal_array, :must_equal_array

    infect_an_assertion :assert_equal_json, :must_equal_json

  end
end