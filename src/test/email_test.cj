package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestCheckEmail {
    let input: String
    let expectedOutput: Bool
    public init(input: String, expectedOutput: Bool) {
        this.input = input
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestEmail {
    @TestCase
    public func test_checkEmail() {
        let testList = Array<TestCheckEmail>(
            [
                TestCheckEmail("test@example.com", true),
                TestCheckEmail("user.name@subdomain.example.co", true),
                TestCheckEmail("invalid-email@", false),
                TestCheckEmail("@example.com", false),
                TestCheckEmail("user@.com", false),
                TestCheckEmail("user@com", false),
                TestCheckEmail("user@domain..com", false),
                TestCheckEmail("user@domain.com.", false),
                TestCheckEmail("", false),
                TestCheckEmail("valid.email+tag@example.com", true),
                TestCheckEmail("a@b.c", true)
            ]
        )
        testList |> forEach<TestCheckEmail> {
            i => @Expect(checkEmail(i.input), i.expectedOutput)
        }
    }
}
