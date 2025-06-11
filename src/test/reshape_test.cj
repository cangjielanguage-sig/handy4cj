package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestReshapePHDemo {
    let placeHolder: Rune
    let format: String
    let sequence: String
    let expectedOutput: String
    public init(placeHolder: Rune, format: String, sequence: String, expectedOutput: String) {
        this.placeHolder = placeHolder
        this.format = format
        this.sequence = sequence
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestReshape {
    @TestCase
    public func test_reshapePH() {
        let testList = Array<TestReshapePHDemo>(
            [
                TestReshapePHDemo(r'#', "###-##-####", "1234567890", "123-45-67890"),
                TestReshapePHDemo(r'#', "abcdefg", "1234567890", "abcdefg1234567890"),
                TestReshapePHDemo(r'#', "", "1234567890", "1234567890"),
                TestReshapePHDemo(r'#', "###-##-####", "", ""),
                TestReshapePHDemo(r'#', "###-##-####", "123", "123"),
                TestReshapePHDemo(r'*', "***-***-****", "1234567890", "123-456-7890"),
                TestReshapePHDemo(r'@', "@@@-@@@", "123456", "123-456"),
                TestReshapePHDemo(r'#', "abc###xyz", "1234567890", "abc123xyz4567890"),
                TestReshapePHDemo(r'#', "abc###", "1234567890", "abc1234567890")
            ]
        )
        testList |>
            forEach<TestReshapePHDemo> {i => @Expect(reshapePH(i.placeHolder, i.format, i.sequence), i.expectedOutput)}
    }

    @TestCase
    public func test_reshape() {
        @Expect(reshape("###-##-####", "1234567890"),"123-45-67890",)
        @Expect(reshape("", "1234567890"),"1234567890",)
        @Expect(reshape("###-##-####", ""),"",)
        @Expect(reshape("###-##-####", "123"),"123",)
        @Expect(reshape("###", "123"),"123",)
        @Expect(reshape("***-***-****", "1234567890"),"***-***-****1234567890",)
        @Expect(reshape("abc###xyz", "1234567890"),"abc123xyz4567890",)
        @Expect(reshape("abc###", "1234567890"),"abc1234567890",)
        @Expect(reshape("####", "1234567890"),"1234567890",)
        @Expect(reshape("###-###", "123"),"123", )
        @Expect(reshape("abcdefg", "1234567890"),"abcdefg1234567890",)
        @Expect(reshape("###-###-####", "abc123xyz456"),"abc-123-xyz456", )
        @Expect(reshape("###-###", ""),"",)
    }
}
