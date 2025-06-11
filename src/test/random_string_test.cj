package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestRandomStringDemo {
    let title: String
    let minLen: Int
    let maxLen: Int
    let allowUnicode: Bool
    let allowNumbers: Bool
    let allowSymbols: Bool
    let allowSpaces: Bool
    let expectedOutput: String
    public init(title: String, minLen: Int, maxLen: Int, allowUnicode: Bool, allowNumbers: Bool, allowSymbols: Bool,
        allowSpaces: Bool, expectedOutput: String) {
        this.title = title
        this.minLen = minLen
        this.maxLen = maxLen
        this.allowUnicode = allowUnicode
        this.allowNumbers = allowNumbers
        this.allowSymbols = allowSymbols
        this.allowSpaces = allowSpaces
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestRandomString {
    @TestCase
    public func test_random_string() {
        let testList = Array<TestRandomStringDemo>(
            [
                TestRandomStringDemo("zeroed len", 0, 0, false, false, false, false, ""),
                TestRandomStringDemo("zeroedMaxLen", 1, 0, false, false, false, false, ""),
                TestRandomStringDemo("minLen>maxLen", 2, 1, false, false, false, false, "")
            ]
        )
        testList |>
            forEach<TestRandomStringDemo> {
            i => @Assert(randomString(i.minLen, i.maxLen, i.allowUnicode, i.allowNumbers, i.allowSymbols, i.allowSpaces), i.expectedOutput)
        }

        @Assert(between(randomString(1, 3, false, false, false,false).size, 1,3))
        @Assert(randomString(1, 1, false, false, false,false).toRuneArray().size == 1)
        @Assert(randomString(32, 32, true, true, true,true).toRuneArray().size == 32)
        @Assert(randomString(32, 32, false, true, true,true).toRuneArray().size == 32)
        @Assert(randomString(32, 32, false, false, true,true).toRuneArray().size == 32)
        @Assert(randomString(32, 32, false, false, false,false).toRuneArray().size == 32)
        @Assert(randomString(32, 32, false, false, false,false).toRuneArray().size == 32)
    }
}
