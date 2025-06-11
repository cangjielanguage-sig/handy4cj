package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestTransformDemo {
    let summary: String
    let input: String
    let max: Int
    let flags: UInt
    let expectedOutput: String
    public init(summary: String, input: String, max: Int, flags: UInt, expectedOutput: String) {
        this.summary = summary
        this.input = input
        this.max = max
        this.flags = flags
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestTransform {
    @TestCase
    public func test_transform() {
        let testList = Array<TestTransformDemo>(
            [
                TestTransformDemo("without flags",
                    "The Cj programming language is an open source project to make programmers more productive.", 20,
                    TransformNone, "The Cj programming l"),
                TestTransformDemo("with trim",
                    "   The Cj programming language is an open source project to make programmers more productive.", 20,
                    TransformFlagTrim, "The Cj programming l"),
                TestTransformDemo("with lower case",
                    "The Cj programming language is an open source project to make programmers more productive.", 20,
                    TransformFlagLowerCase, "the cj programming l"),
                TestTransformDemo("with upper case",
                    "The Cj programming language is an open source project to make programmers more productive.", 20,
                    TransformFlagUpperCase, "THE CJ PROGRAMMING L"),
                TestTransformDemo("with Only Digits",
                    "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                    20, TransformFlagOnlyDigits, "1"),
                TestTransformDemo("with Only Letters",
                    "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                    20, TransformFlagOnlyLetters, "TheCjistheºprogrammi"),
                TestTransformDemo("with Only Letters and Numbers",
                    "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                    20, TransformFlagOnlyLettersAndDigits, "TheCjisthe1ºprogramm"),
                TestTransformDemo("with Only Hash",
                    "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                    20, TransformFlagHash, "e0b10702c3efa47b748c"),
                TestTransformDemo("with Only Hash and letters",
                    "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                    20, TransformFlagHash | TransformFlagOnlyLetters, "c236e532cf9072177cec"),
                TestTransformDemo("empty", "", 20, TransformFlagHash | TransformFlagOnlyLetters, ""),
                TestTransformDemo("spacing", " ", 1,
                    TransformFlagOnlyLettersAndDigits | TransformFlagOnlyLetters | TransformFlagOnlyDigits |
                        TransformFlagOnlyLetters | TransformFlagTrim | TransformFlagLowerCase | TransformFlagUpperCase,
                    "")
            ]
        )
        testList |> forEach<TestTransformDemo> {i => @Expect(transform(i.input, i.max, i.flags), i.expectedOutput)}
    }

    @TestCase
    public func test_transformSerially() {
        @Expect(transformSerially("", 20, TransformFlagHash, TransformFlagOnlyLetters), "")
        @Expect(transformSerially("The Cj programming language is an open source project to make programmers more productive.",
                20, TransformNone), "The Cj programming l")
        @Expect(transformSerially("The Cj programming language is an open source project to make programmers more productive.",
                20, TransformFlagTitleCase), "The Cj Programming L")
        @Expect(transformSerially("ívän âlexandrovitch çzelyatchenko", 20, TransformFlagTitleCase), "Ívän Âlexandrovitch ")
        @Expect(transformSerially(
                "   The Cj programming language is an open source project to make programmers more productive.", 20,
                TransformFlagTrim), "The Cj programming l")
        @Expect(transformSerially("The Cj programming language is an open source project to make programmers more productive.",
                20, TransformFlagLowerCase), "the cj programming l")
        @Expect(transformSerially("The Cj programming language is an open source project to make programmers more productive.",
                20, TransformFlagUpperCase), "THE CJ PROGRAMMING L")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagOnlyDigits), "1")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagOnlyLetters), "TheCjistheºprogrammi")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagOnlyLettersAndDigits), "TheCjisthe1ºprogramm")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagHash), "e0b10702c3efa47b748c")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagHash, TransformFlagOnlyLetters), "ebcefabcfbfecadeeaec")
        @Expect(transformSerially(" ", 1, TransformFlagOnlyLettersAndDigits, TransformFlagOnlyLetters, TransformFlagOnlyDigits,
                TransformFlagOnlyLetters, TransformFlagTrim, TransformFlagLowerCase, TransformFlagUpperCase), "")
        @Expect(transformSerially(
                "   The Cj programming language is an open source project to make programmers more productive.", 20,
                TransformFlagTrim, TransformFlagLowerCase), "the cj programming l")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagHash, TransformFlagOnlyDigits), "01070234774814327906")
        @Expect(transformSerially(
                "   The Cj programming language is an open source project to make programmers more productive.", 20,
                TransformFlagTrim, TransformFlagLowerCase, TransformFlagHash), "e9b36d33b93d28c28ffe")
        @Expect(transformSerially(
                "The Cj is the 1º programming language is an open source project to make programmers more productive.",
                20, TransformFlagTrim, TransformFlagLowerCase, TransformFlagOnlyLetters), "thecjistheºprogrammi")
    }
}
