module EqualHashExamples

  extend Minitest::Spec::DSL

  it 'Success' do
    expected = {a: 1, b: 2}
    actual = {a: 1, b: 2}

    run_assertion expected, actual
  end

  it 'Fail' do
    expected = {a: "1", b: 2}
    actual = {a: 2, b: true}

    expected_error = "[:a]\nExpected: \"1\"\n  Actual: 2\n\n[:b]\nExpected: 2\n  Actual: true"

    assert_fail_with_error(expected_error) do
      run_assertion expected, actual
    end
  end

end