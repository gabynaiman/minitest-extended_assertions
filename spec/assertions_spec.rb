require 'minitest_helper'

describe Minitest::Assertions do

  describe 'assert_equal_hash' do

    include EqualHashExamples

    def run_assertion(expected, actual)
      assert_equal_hash expected, actual
    end

  end

  describe 'assert_equal_array' do

    include EqualArrayExamples

    def run_assertion(expected, actual)
      assert_equal_array expected, actual
    end

  end

  describe 'assert_equal_json' do

    include EqualJsonExamples

    def run_assertion(expected, actual)
      assert_equal_json expected, actual
    end

  end

end