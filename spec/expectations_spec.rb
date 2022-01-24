require 'minitest_helper'

describe Minitest::Expectations do

  describe 'must_equal_hash' do

    include EqualHashExamples

    def run_assertion(expected, actual)
      actual.must_equal_hash expected
    end

  end

  describe 'must_equal_json' do

    include EqualJsonExamples

    def run_assertion(expected, actual)
      actual.must_equal_json expected
    end

  end

end