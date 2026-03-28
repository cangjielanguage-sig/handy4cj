package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestCheckPhoneDemo {
    let summary: String
    let input: String
    let allowEmpty: Bool
    let expectedOutput: Bool
    public init(summary: String, input: String, allowEmpty: Bool, expectedOutput: Bool) {
        this.summary = summary
        this.input = input
        this.allowEmpty = allowEmpty
        this.expectedOutput = expectedOutput
    }
}

public class TestBetweenDemo {
    let summary: String
    let number: Int
    let min: Int
    let max: Int
    let expectedOutput: Bool
    public init(summary: String, number: Int, min: Int, max: Int, expectedOutput: Bool) {
        this.summary = summary
        this.number = number
        this.min = min
        this.max = max
        this.expectedOutput = expectedOutput
    }
}

public class TestTruncateDemo {
    let summary: String
    let input: String
    let limit: Int
    let trim: Bool
    let expectedOutput: String
    public init(summary: String, input: String, limit: Int, trim: Bool, expectedOutput: String) {
        this.summary = summary
        this.input = input
        this.limit = limit
        this.trim = trim
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestHandy {
    @TestCase
    public func test_runeHasSymbol() {
        @Assert(runeHasSymbol(r'a'), false)
        @Assert(runeHasSymbol(r'A'), false)
        @Assert(runeHasSymbol(r'1'), false)
        @Assert(runeHasSymbol(r'!'), true)
        @Assert(runeHasSymbol(r'#'), true)
        @Assert(runeHasSymbol(r'$'), true)
        @Assert(runeHasSymbol(r'*'), true)
        @Assert(runeHasSymbol(r'('), true)
        @Assert(runeHasSymbol(r'}'), true)
        @Assert(runeHasSymbol(r']'), true)
        @Assert(runeHasSymbol(r' '), false)
        @Assert(runeHasSymbol(r'@'), true)
        @Assert(runeHasSymbol(r','), true)
        @Assert(runeHasSymbol(r'.'), true)
        @Assert(runeHasSymbol(r'~'), true)
        @Assert(runeHasSymbol(r'é'), false)
    }

    @TestCase
    public func test_stringHash() {
        @Assert(stringHash("Handy"), "e80649a6418b6c24fccb199dab7cb5bd6ec37593ea0285d52d717fcc7aee5fb3")
        @Assert(stringHash("123456"), "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92")
        @Assert(stringHash("Handy12345"), "c82333db3a6d91f98be188c6c7b928df4960b9ec3f3eb8cb50293368c673be3d")
        @Assert(stringHash("#handy_12Ax"), "507512071aaea24a94ecbb0f32ee74169fd59160ee9232819c504f39656e61f7")
    }

    @TestCase
    public func test_checkPhone() {
        let testList = [
                TestCheckPhoneDemo("Normal input", "948034118", false, true),
                TestCheckPhoneDemo("Empty return false", "", false, false),
                TestCheckPhoneDemo("Empty allowing empty", "", true, true),
                TestCheckPhoneDemo("Normal input but allowing empty", "948034118", true, true),
                TestCheckPhoneDemo("invalid input", "48034118", false, false)
            ]
        testList |> forEach<TestCheckPhoneDemo> {i => @Assert(checkPhone(i.input, i.allowEmpty), i.expectedOutput)}
    }

    @TestCase
    public func test_between() {
        let testList = [
                TestBetweenDemo("normal test", 5, 0, 10, true),
                TestBetweenDemo("with negative", -5, -10, 0, true),
                TestBetweenDemo("mix with negative", 5, -10, 100, true),
                TestBetweenDemo("Large Numbers", 1000, -1000, 10000, true),
                TestBetweenDemo("Give me a false!", -5, -4, 0, false)
            ]
        testList |> forEach<TestBetweenDemo> {i => @Assert(between(i.number, i.min, i.max), i.expectedOutput)}
    }

    @TestCase
    public func test_tif() {
        @Assert(tif(true, "true", "false") as String, "true")
        @Assert(tif(false, "true", "false") as String, "false")
        @Assert(tif(false, 10, 15) as Int, 15)
        @Assert(tif(true, 10, 15) as Int, 10)
        @Assert(tif(true, true, false) as Bool, true)
        @Assert(tif(false, true, false) as Bool, false)
    }

    @TestCase
    public func test_truncate() {
        let testList = [
                TestTruncateDemo("normal Test",
                    "The Go programming language is an open source project to make programmers more productive.", 25,
                    false, "The Go programming langua"),
                TestTruncateDemo("normal Test with trim",
                    "   The Go programming language is an open source project to make programmers more productive.", 45,
                    true, "The Go programming language is an open sou"),
                TestTruncateDemo("zero",
                    "The Go programming language is an open source project to make programmers more productive.", 0,
                    true, ""),
                TestTruncateDemo("zero zero", "", 45, true, "")
            ]
        testList |> forEach<TestTruncateDemo> {i => @Assert(truncate(i.input, i.limit, i.trim), i.expectedOutput)}
    }

    @TestCase
    public func test_matchesAny() {
        @Assert(matchesAny(20, 1, 50, 20), true)
        @Assert(matchesAny("The Cangjie programming language ",
                "is an open source project to make programmers more productive.", "language", "lalala",
                "The Cangjie programming language "), true)
        @Assert(matchesAny("The Cangjie programming language ",
                "is an open source project to make programmers more productive.", "language", "lalala",
                "The Cangjie programming"), false)
        @Assert(matchesAny(60.40, 1, 50, 60.4), true)
        @Assert(matchesAny(true, false, false, true), true)
    }

    @TestCase
    public func test_hasOnlyNumbers() {
        @Assert(hasOnlyNumbers("20"), true)
        @Assert(hasOnlyNumbers("The Cangjie programming language "), false)
        @Assert(hasOnlyNumbers("20The Cangjie programming language "), false)
        @Assert(hasOnlyNumbers(""), false)
    }

    @TestCase
    public func test_hasOnlyLetters() {
        @Assert(hasOnlyLetters("TheCangjieprogramminglanguage"), true)
        @Assert(hasOnlyLetters("20"), false)
        @Assert(hasOnlyLetters("The Cangjie programming language "), false)
        @Assert(hasOnlyLetters("20The Cangjie programming language "), false)
        @Assert(hasOnlyLetters(""), false)
    }

    @TestCase
    public func test_trimLen() {
        @Assert(trimLen("TheCangjieprogramminglanguage"), 29)
        @Assert(trimLen("The Cangjie programming language"), 32)
        @Assert(trimLen("20"), 2)
        @Assert(trimLen("20The Cangjie programming language "), 34)
        @Assert(trimLen(""), 0)
        @Assert(trimLen(" "), 0)
    }

    @TestCase
    public func test_checkMinLen() {
        @Assert(checkMinLen("TheCangjieprogramminglanguage", 29), true)
        @Assert(checkMinLen("The Cangjie programming language", 32), true)
        @Assert(checkMinLen("20", 2), true)
        @Assert(checkMinLen("20The Cangjie programming language", 29), true)
        @Assert(checkMinLen("20The Cangjie programming language", 260), false)
    }

    @TestCase
    public func test_isNumericType() {
        @Assert(isNumericType(22), true)
        @Assert(isNumericType(22.40), true)
        @Assert(isNumericType("22"), false)
        @Assert(isNumericType(UIntNative(22)), true)
        @Assert(isNumericType(UInt8(22)), true)
        @Assert(isNumericType(UInt16(22)), true)
        @Assert(isNumericType(UInt32(22)), true)
        @Assert(isNumericType(UInt64(22)), true)
        @Assert(isNumericType(IntNative(22)), true)
        @Assert(isNumericType(Int8(22)), true)
        @Assert(isNumericType(Int16(22)), true)
        @Assert(isNumericType(Int32(22)), true)
        @Assert(isNumericType(Int64(22)), true)
        @Assert(isNumericType(Float16(22)), true)
        @Assert(isNumericType(Float32(22)), true)
        @Assert(isNumericType(Float64(22)), true)
    }

    @TestCase
    public func test_bit() {
        @Assert(bit(0), UInt8(0))
        @Assert(bit(1), UInt8(1))
        @Assert(bit("ha"), UInt8(0))
        @Assert(bit("1"), UInt8(0))
    }

    @TestCase
    public func test_boolean() {
        @Assert(boolean(0), false)
        @Assert(boolean(1), true)
        @Assert(boolean("ha"), false)
        @Assert(boolean("1"), true)
        @Assert(boolean(true), false)
        @Assert(boolean("t"), true)
        @Assert(boolean("true"), true)
    }

    @TestCase
    public func test_reverseString() {
        @Assert(reverseString("Miguel"), "leugiM")
        @Assert(reverseString("Fe"), "eF")
        @Assert(reverseString("Ha1"), "1aH")
        @Assert(reverseString(""), "")
        @Assert(reverseString("仓颉"),"颉仓")
    }

    @TestCase
    public func test_stringReplaceAll() {
        @Assert(stringReplaceAll("test string", "t", "d"), "desd sdring")
        @Assert(stringReplaceAll("test string", " ", "e"), "testestring")
        @Assert(stringReplaceAll("test string", "t", "d", " ", "e"), "desdesdring")
        @Assert(stringReplaceAll("", "t", "d", " ", "e"), "")
        @AssertThrows[Exception](stringReplaceAll("test string", "t", "d", "e"))
    }

    @TestCase
    public func test_positiveOrZero() {
        @Assert(positiveOrZero(0), 0)
        @Assert(positiveOrZero(1), 1)
        @Assert(positiveOrZero(-20), 0)
        @Assert(positiveOrZero(100), 100)
        @Assert(positiveOrZero(-99), 0)
    }
}
