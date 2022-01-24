require 'minitest_helper'

describe Minitest::ExtendedAssertions::DeepComparator do

  def assert_differences(expected, actual, expected_diffs)
    actual_diffs = Minitest::ExtendedAssertions::DeepComparator.compare expected, actual

    assert_equal expected_diffs, actual_diffs.map { |d| d.to_h.reject { |k,v| v.nil? } }
  end

  describe 'Primitives' do

    it 'Equal' do
      assert_differences 1, 1, []
    end

    it 'Different values' do
      assert_differences 1, 2, [expected: 1, actual: 2]
    end

    it 'Different types' do
      assert_differences 1, 'text', [expected: 1, actual: 'text']
    end

  end

  describe 'Hashes' do

    it 'Equal' do
      expected = {a: 1, b: 2}
      actual = {b: 2, a: 1}

      assert_differences expected, actual, []
    end

    it 'Different keys' do
      expected = {a: 1, b: 2}
      actual = {c: 3}

      assert_differences expected, actual, [path: '.keys', expected: [:a, :b], actual: [:c]]
    end

    it 'Different values' do
      expected = {a: 1, b: 2}
      actual = {b: 3, a: 4}

      assert_differences expected, actual, [
        {path: '[:a]', expected: 1, actual: 4},
        {path: '[:b]', expected: 2, actual: 3}
      ]
    end

  end

  describe 'Arrays' do

    it 'Equal' do
      expected = [1, 2]
      actual = [1, 2]

      assert_differences expected, actual, []
    end

    it 'Different size' do
      expected = [1, 2, 3]
      actual = [1, 2]

      assert_differences expected, actual, [path: '.count', expected: 3, actual: 2]
    end

    it 'Different values' do
      expected = [1, 3, 4]
      actual = [1, 2, 5]

      assert_differences expected, actual, [
        {path: '[1]', expected: 3, actual: 2},
        {path: '[2]', expected: 4, actual: 5}
      ]
    end

  end

  describe 'Nested' do

    describe 'Hash -> Hash -> Hash' do

      let :expected do
        {
          key_1: 1,
          key_2: {
            key_2_1: 2,
            key_2_2: {
              key_2_2_1: 3
            }
          },
        }
      end

      it 'Equal' do
        actual = deep_clone expected

        assert_differences expected, actual, []
      end

      it 'Different' do
        actual = deep_clone expected
        actual[:key_1] = 10
        actual[:key_2][:key_2_1] = 20
        actual[:key_2][:key_2_2][:key_2_2_1] = 30

        assert_differences expected, actual, [
          {path: '[:key_1]', expected: 1, actual: 10},
          {path: '[:key_2][:key_2_1]', expected: 2, actual: 20},
          {path: '[:key_2][:key_2_2][:key_2_2_1]', expected: 3, actual: 30}
        ]
      end

    end

    describe 'Array -> Array -> Arrary' do

      let :expected do
        [1, [2, [3, 4]]]
      end

      it 'Equal' do
        actual = deep_clone expected

        assert_differences expected, actual, []
      end

      it 'Different' do
        actual = deep_clone expected
        actual[0] = 10
        actual[1][0] = 20
        actual[1][1][0] = 30

        assert_differences expected, actual, [
          {path: '[0]', expected: 1, actual: 10},
          {path: '[1][0]', expected: 2, actual: 20},
          {path: '[1][1][0]', expected: 3, actual: 30}
        ]
      end

    end

    describe 'Hash -> Array -> Hash -> Array' do

      let :expected do
        {
          key_1: 1,
          key_2: [
            2,
            {
              key_2_1: 3,
              key_2_2: [4, 5]
            }
          ]
        }
      end

      it 'Equal' do
        actual = deep_clone expected

        assert_differences expected, actual, []
      end

      it 'Different' do
        actual = deep_clone expected
        actual[:key_1] = 10
        actual[:key_2][0] = 20
        actual[:key_2][1][:key_2_1] = 30
        actual[:key_2][1][:key_2_2][0] = 40

        assert_differences expected, actual, [
          {path: '[:key_1]', expected: 1, actual: 10},
          {path: '[:key_2][0]', expected: 2, actual: 20},
          {path: '[:key_2][1][:key_2_1]', expected: 3, actual: 30},
          {path: '[:key_2][1][:key_2_2][0]', expected: 4, actual: 40}
        ]
      end

    end

  end

  describe 'Difference' do

    let (:difference) { Minitest::ExtendedAssertions::DeepComparator::Difference.new '[:key]', 1, 2 }

    let (:difference_without_path) { Minitest::ExtendedAssertions::DeepComparator::Difference.new nil, 1, 2 }

    it 'to_h' do
      expected = {path: '[:key]', expected: 1, actual: 2}
      assert_equal expected, difference.to_h
    end

    it 'to_h (without path)' do
      expected = {path: nil, expected: 1, actual: 2}
      assert_equal expected, difference_without_path.to_h
    end

    it 'to_s' do
      expected = "[:key]\nExpected: 1\n  Actual: 2"
      assert_equal expected, difference.to_s
    end

    it 'to_s (without path)' do
      expected = "Expected: 1\n  Actual: 2"
      assert_equal expected, difference_without_path.to_s
    end

  end

end