package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestNewPasswordDemo {
    let summary: String
    let password: String
    let checkPassword: String
    let minimumLength: UInt
    let flag: UInt8
    let expectedOutput: UInt8
    public init(summary: String, password: String, checkPassword: String, minimumLength: UInt, flag: UInt8,
        expectedOutput: UInt8) {
        this.summary = summary
        this.password = password
        this.checkPassword = checkPassword
        this.minimumLength = minimumLength
        this.flag = flag
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestPassword {
    @TestCase
    public func test_checkNewPassword() {
        let testList = [
                TestNewPasswordDemo("test lowest flag", "1234AB", "1234AB", 6, CheckNewPasswordComplexityLowest,
                    CheckNewPasswordResultOK),
                TestNewPasswordDemo("test check password", "1234AB", "1234A", 6, CheckNewPasswordComplexityLowest,
                    CheckNewPasswordResultDivergent),
                TestNewPasswordDemo("Only Numbers with Default Flag", "1234", "1234", 4,
                    CheckNewPasswordComplexityLowest, CheckNewPasswordResultOK),
                TestNewPasswordDemo("Only letters with Default Flag", "lala", "lala", 4,
                    CheckNewPasswordComplexityLowest, CheckNewPasswordResultOK),
                TestNewPasswordDemo("testing minimum length", "1234", "1234", 2, CheckNewPasswordComplexityLowest,
                    CheckNewPasswordResultOK),
                TestNewPasswordDemo("testing minimum length for password", "123", "123", 2,
                    CheckNewPasswordComplexityLowest, CheckNewPasswordResultTooShort),
                TestNewPasswordDemo("test require letter success", "1234AB", "1234AB", 4,
                    CheckNewPasswordComplexityRequireLetter, CheckNewPasswordResultOK),
                TestNewPasswordDemo("test require letter error", "1234", "1234", 4,
                    CheckNewPasswordComplexityRequireLetter, CheckNewPasswordResultTooSimple),
                TestNewPasswordDemo("test require uppercase success", "1234Ab", "1234Ab", 4,
                    CheckNewPasswordComplexityRequireUpperCase | CheckNewPasswordComplexityRequireLetter,
                    CheckNewPasswordResultOK),
                TestNewPasswordDemo("test require uppercase error", "1234ab", "1234ab", 4,
                    CheckNewPasswordComplexityRequireUpperCase | CheckNewPasswordComplexityRequireLetter,
                    CheckNewPasswordResultTooSimple),
                TestNewPasswordDemo("test require number success", "abc1", "abc1", 4,
                    CheckNewPasswordComplexityRequireNumber, CheckNewPasswordResultOK),
                TestNewPasswordDemo("test require number error", "abcd", "abcd", 4,
                    CheckNewPasswordComplexityRequireNumber, CheckNewPasswordResultTooSimple),
                TestNewPasswordDemo("test require space success", "abc d", "abc d", 4,
                    CheckNewPasswordComplexityRequireSpace, CheckNewPasswordResultOK),
                TestNewPasswordDemo("test require space error", "abcd", "abcd", 4,
                    CheckNewPasswordComplexityRequireSpace, CheckNewPasswordResultTooSimple),
                TestNewPasswordDemo("test require symbol success", "abc#", "abc#", 4,
                    CheckNewPasswordComplexityRequireSymbol, CheckNewPasswordResultOK),
                TestNewPasswordDemo("test require symbol error", "abcd", "abcd", 4,
                    CheckNewPasswordComplexityRequireSymbol, CheckNewPasswordResultTooSimple)
            ]
        testList |>
            forEach<TestNewPasswordDemo> {
            i => @Assert(checkNewPassword(i.password, i.checkPassword, i.minimumLength, i.flag), i.expectedOutput)
        }
    }
}
