module Minitest
  module ExtendedAssertions
    class DeepComparator

      class Difference

        attr_reader :path, :expected, :actual

        def initialize(path, expected, actual)
          @path = path
          @expected = expected
          @actual = actual
        end

        def to_h
          {
            path: path,
            expected: expected,
            actual: actual
          }
        end

      end

      class << self

        def compare(expected, actual, path=nil)
          if expected.class != actual.class
            [Difference.new(path, expected, actual)]
          else
            if expected.is_a? Hash
              compare_hash expected, actual, path
            elsif expected.is_a? Array
              compare_array expected, actual, path
            elsif expected != actual
              [Difference.new(path, expected, actual)]
            else
              []
            end
          end
        end

        private

        def compare_hash(expected, actual, path)
          if expected.keys.sort != actual.keys.sort
            [Difference.new("#{path}.keys", expected.keys.sort, actual.keys.sort)]
          else
            expected.flat_map do |k, v|
              compare v, actual[k], "#{path}[#{k.inspect}]"
            end
          end
        end

        def compare_array(expected, actual, path)
          if expected.count != actual.count
            [Difference.new("#{path}.count", expected.count, actual.count)]
          else
            expected.flat_map.with_index do |v, i|
              compare v, actual[i], "#{path}[#{i}]"
            end
          end
        end

      end
    end
  end
end