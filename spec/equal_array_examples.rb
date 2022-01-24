module EqualArrayExamples

  extend Minitest::Spec::DSL

  it 'Success' do
    expected = [1, 2, 3]
    actual = [1, 2, 3]

    run_assertion expected, actual
  end

  it 'Fail' do
    expected = [1, 2, 3, 4]
    actual = [1, 20, 3, 40]

    expected_error = "[1]\nExpected: 2\n  Actual: 20\n\n[3]\nExpected: 4\n  Actual: 40"

    assert_fail_with_error(expected_error) do
      run_assertion expected, actual
    end
  end

end