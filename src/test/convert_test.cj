package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestStringAsFloatDemo {
    let input: String
    let decimalSeparator: Rune
    let thousandsSeparator: Rune
    let expectedOutput: Float64
    public init(input: String, decimalSeparator: Rune, thousandsSeparator: Rune, expectedOutput: Float64) {
        this.input = input
        this.decimalSeparator = decimalSeparator
        this.thousandsSeparator = thousandsSeparator
        this.expectedOutput = expectedOutput
    }
}

public class TestStringAsIntDemo {
    let input: String
    let expectedOutput: Int64
    public init(input: String, expectedOutput: Int64) {
        this.input = input
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestConvert {
    @TestCase
    public func test_stringAsFloat() {
        let testList = [
                TestStringAsFloatDemo("123.45", r'.', r',', 123.45),
                TestStringAsFloatDemo("1,234.56", r'.', r',', 1234.56),
                TestStringAsFloatDemo("1.234,56", r'.', r',', 1.23456),
                TestStringAsFloatDemo("123456789", r'.', r',', 123456789.0),
                TestStringAsFloatDemo("1234567890123456789012", r'.', r',', 1234567890123456789.0),
                TestStringAsFloatDemo("123.45.67", r'.', r',', 0.0),
                TestStringAsFloatDemo("abc", r'.', r',', 0.0),
                TestStringAsFloatDemo("", r'.', r',', 0.0)
            ]
        testList |>
            forEach<TestStringAsFloatDemo> {
            i => @Expect(stringAsFloat(i.input, i.decimalSeparator, i.thousandsSeparator) , i.expectedOutput)
        }
    }

    @TestCase
    public func test_stringAsInt() {
        let testList = [
                TestStringAsIntDemo("", 0),
                TestStringAsIntDemo("123", 123),
                TestStringAsIntDemo("-123", -123),
                TestStringAsIntDemo("0", 0),
                TestStringAsIntDemo("abc", 0),
                TestStringAsIntDemo("2147483647", 2147483647),
                TestStringAsIntDemo("-2147483647", -2147483647),
                TestStringAsIntDemo("2147483648", 2147483648),
                TestStringAsIntDemo("-2147483648", -2147483648)
            ]
        testList |> forEach<TestStringAsIntDemo> {i => @Expect(stringAsInteger(i.input), i.expectedOutput)}
    }
}
