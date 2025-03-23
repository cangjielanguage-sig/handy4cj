package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestCheckPersonNameDemo {
    let summary: String
    let name: String
    let acceptEmpty: Bool
    let expectedOutput: UInt8
    public init(summary: String, name: String, acceptEmpty: Bool, expectedOutput: UInt8) {
        this.summary = summary
        this.name = name
        this.acceptEmpty = acceptEmpty
        this.expectedOutput = expectedOutput
    }
}

public class TestNameDemo {
    let summary: String
    let name: String
    let transformFlags: UInt
    let expectedOutput: String
    public init(summary: String, name: String, transformFlags: UInt, expectedOutput: String) {
        this.summary = summary
        this.name = name
        this.transformFlags = transformFlags
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestName {
    @TestCase
    public func test_checkPersonName() {
        let testList = Array<TestCheckPersonNameDemo>(
            [
                TestCheckPersonNameDemo("Only two letters", "T S", false, CheckPersonNameResultTooSimple),
                TestCheckPersonNameDemo("only four letters", "ABC D", false, CheckPersonNameResultTooSimple),
                TestCheckPersonNameDemo("five letters with non-ascii runes", "ça vá", false,
                    CheckPersonNameResultTooSimple),
                TestCheckPersonNameDemo("mixing letters and numbers", "W0RDS W1TH NUMB3RS", false,
                    CheckPersonNameResultPolluted),
                TestCheckPersonNameDemo("Sending and accepting empty string", "", true, CheckPersonNameResultOK),
                TestCheckPersonNameDemo("Sending spaces-only string and accepting empty", "     ", true,
                    CheckPersonNameResultOK),
                TestCheckPersonNameDemo("Sending but not accepting empty string", " ", false,
                    CheckPersonNameResultTooShort),
                TestCheckPersonNameDemo("Sending spaces-only string and refusing empty", "     ", false,
                    CheckPersonNameResultTooShort),
                TestCheckPersonNameDemo("Sending numbers, expecting false", " 5454 ", true,
                    CheckPersonNameResultPolluted),
                TestCheckPersonNameDemo("OneWorded string", "ONEWORD", false, CheckPersonNameResultTooFewWords),
                TestCheckPersonNameDemo("Minimum acceptable", "AB CDE", false, CheckPersonNameResultOK),
                TestCheckPersonNameDemo("Non-ascii stuff", "ÑÔÑÀSÇÏÏ ÇÃO ÀË", false, CheckPersonNameResultOK),
                TestCheckPersonNameDemo("Words with symbols. Expecting true", "WORDS-WITH SYMBOLS'", false,
                    CheckPersonNameResultOK),
                TestCheckPersonNameDemo("Words with symbols. Expecting false", "WORDS WITH SYMBOLS`", false,
                    CheckPersonNameResultPolluted),
                TestCheckPersonNameDemo("less than two letters", "a", false, CheckPersonNameResultTooFewWords),
                TestCheckPersonNameDemo("Sending numbers, expecting false", "5454", false, CheckPersonNameResultPolluted
                )
            ]
        )
        testList |> forEach {i => @Expect(checkPersonName(i.name, i.acceptEmpty), i.expectedOutput)}
    }

    @TestCase
    public func test_nameFirstAndLast() {
        let testList = Array<TestNameDemo>(
            [
                TestNameDemo("Only two letters", "x Y", TransformNone, "x Y"),
                TestNameDemo("one word name", "namë", TransformNone, "namë"),
                TestNameDemo("all non-ascii runes", "çá öáã àÿ", TransformNone, "çá àÿ"),
                TestNameDemo("all non-ascii runes to upper", "çá öáã àÿ", TransformFlagUpperCase, "ÇÁ ÀŸ"),
                TestNameDemo("mixing letters and numbers and then filtering digits off", "W0RDS W1TH NUMB3RS",
                    TransformFlagRemoveDigits, "WRDS NUMBRS"),
                TestNameDemo("empty string", "", TransformNone, ""),
                TestNameDemo("only spaces", "     ", TransformNone, ""),
                TestNameDemo("with spaces and tabs", " FIRST NAME - MIDDLENAME 	LAST	 ", TransformNone,
                    "FIRST LAST"),
                TestNameDemo("last name single rune", "NAME X", TransformNone, "NAME X"),
                TestNameDemo("only symbols", "5454#@$", TransformNone, "5454#@$"),
                TestNameDemo("single letter", "x", TransformNone, "x"),
                TestNameDemo("only spaces empty return", " 		 ", TransformNone, ""),
                TestNameDemo("regular name to upper", "name lastname", TransformFlagUpperCase, "NAME LASTNAME"),
                TestNameDemo("regular name to title", "name LASTNAME", TransformFlagTitleCase, "Name Lastname"),
                TestNameDemo("REGULAR Name to lOwEr", "name LASTNAME", TransformFlagLowerCase, "name lastname")
            ]
        )

        testList |> forEach<TestNameDemo> {i => @Expect(nameFirstAndLast(i.name, i.transformFlags), i.expectedOutput)}
    }

    @TestCase
    public func test_nameFirst() {
        let testList = Array<TestNameDemo>(
            [
                TestNameDemo("Only two letters", "x Y", TransformNone, "x"),
                TestNameDemo("one word name", "namë", TransformNone, "namë"),
                TestNameDemo("all non-ascii runes", "çá öáã àÿ", TransformNone, "çá"),
                TestNameDemo("all non-ascii runes to upper", "çá öáã àÿ", TransformFlagUpperCase, "ÇÁ"),
                TestNameDemo("mixing letters and numbers and then filtering digits off", "W0RDS W1TH NUMB3RS",
                    TransformFlagRemoveDigits, "WRDS"),
                TestNameDemo("empty string", "", TransformNone, ""),
                TestNameDemo("only spaces", "     ", TransformNone, ""),
                TestNameDemo("with spaces and tabs", " FIRST NAME - MIDDLENAME 	LAST	 ", TransformNone, "FIRST"),
                TestNameDemo("last name single rune", "NAME X", TransformNone, "NAME"),
                TestNameDemo("only symbols", "5454#@$", TransformNone, "5454#@$"),
                TestNameDemo("single letter", "x", TransformNone, "x"),
                TestNameDemo("only spaces empty return", " 		 ", TransformNone, ""),
                TestNameDemo("regular name to upper", "name lastname", TransformFlagUpperCase, "NAME"),
                TestNameDemo("regular name to title", "name LASTNAME", TransformFlagTitleCase, "Name"),
                TestNameDemo("REGULAR Name to lOwEr", "name LASTNAME", TransformFlagLowerCase, "name")
            ]
        )
        testList |> forEach<TestNameDemo> {i => @Expect(nameFirst(i.name, i.transformFlags), i.expectedOutput)}
    }

    @TestCase
    public func test_nameInitials() {
        let testList = Array<TestNameDemo>(
            [
                TestNameDemo("simplest 2 words name", "miguel pragier", TransformNone, "m p"),
                TestNameDemo("3 words name separated", "ivan alexandrovitch kleshtakov", TransformNone, "i a k"),
                TestNameDemo("3 words with unicode", "Ívän Âlexandrovitch Çzelyatchenko", TransformNone, "Í Â Ç"),
                TestNameDemo("3 words with unicode title-case", "ívän âlexandrovitch çzelyatchenko",
                    TransformFlagTitleCase, "Í Â Ç"),
                TestNameDemo("empty string", "", TransformNone, ""),
                TestNameDemo("dot", ".", TransformNone, "."),
                TestNameDemo("spaces and tabs", "  \t\t \n", TransformNone, ""),
                TestNameDemo("name with tabs", "richard\t\tstallmann", TransformNone, "r s"),
                TestNameDemo("noble name with 1", "dom pedro 1", TransformNone, "d p 1"),
                TestNameDemo("noble name with I uppercase", "dom pedro I", TransformFlagUpperCase, "D P I"),
                TestNameDemo("3 letters", "x y z", TransformNone, "x y z"),
                TestNameDemo("one word", "asingleword", TransformNone, "a"),
                TestNameDemo("comma separators", "name,with,comma,separators", TransformNone, "n")
            ]
        )
        testList |> forEach<TestNameDemo> {i => @Expect(nameInitials(i.name, i.transformFlags), i.expectedOutput)}
    }
}
