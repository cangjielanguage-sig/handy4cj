package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestRandomNumericStringDemo {
    let title: String
    let forbiddenDigits: ArrayList<Int>
    let lengthMin: Int
    let lengthMax: Int
    let expectedOutput: String
    public init(title: String, forbiddenDigits: ArrayList<Int>, lengthMin: Int, lengthMax: Int, expectedOutput: String) {
        this.title = title
        this.forbiddenDigits = forbiddenDigits
        this.lengthMin = lengthMin
        this.lengthMax = lengthMax
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestRandomNumericString {
    @TestCase
    public func test_random_numeric_string() {
        let testList = [
                TestRandomNumericStringDemo("zero length string", ArrayList<Int>(), 0, 0, ""),
                TestRandomNumericStringDemo("all digits forbidden, min length = max length = 3",
                    ArrayList<Int>([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]), 3, 3, ""),
                TestRandomNumericStringDemo("max length less than min length", ArrayList<Int>(), 5, 3, ""),
                TestRandomNumericStringDemo("only one digit is allowed", ArrayList<Int>([0, 1, 2, 3, 4, 5, 6, 7, 8]), 3,
                    3, "999")
            ]
        testList |>
            forEach<TestRandomNumericStringDemo> {
            i => @Assert(randomNumericString(i.forbiddenDigits, i.lengthMin, i.lengthMax), i.expectedOutput)
        }

        @Assert(randomNumericString(ArrayList<Int>(), 1, 1).size == 1)
        @Assert(randomNumericString(ArrayList<Int>(), 5, 5).size == 5)
        @Assert(between(randomNumericString(ArrayList<Int>(), 3, 5).size, 3, 5))

        let result1 = randomNumericString(ArrayList<Int>([0, 1, 2]), 5, 5)
        @Assert(result1.size == 5 && !(ArrayList<Int>([0, 1 ,2]) |> any<Int>{ i => result1.toRuneArray().contains(Rune(i))}))
        let result2 = randomNumericString(ArrayList<Int>([3, 5]), 3, 3)
        @Assert(result2.size == 3 && !(ArrayList<Int>([3, 5]) |> any<Int>{ i => result2.toRuneArray().contains(Rune(i))}))
        let result3 = randomNumericString(ArrayList<Int>([7, 8]), 4, 4)
        @Assert(result3.size == 4 && !(ArrayList<Int>([7, 8]) |> any<Int>{ i => result3.toRuneArray().contains(Rune(i))}))
    }
}
