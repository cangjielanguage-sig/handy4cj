package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
public class TestFliters {
    @TestCase
    public func test_dedugSpaces() {
        @Assert(dedupSpaces("Hello  World"), "Hello World")
        @Assert(dedupSpaces("Hello\t\tWorld"), "Hello World")
        @Assert(dedupSpaces("Hello\n\nWorld"), "Hello World")
        @Assert(dedupSpaces("   Hello   World   "), " Hello World ")
        @Assert(dedupSpaces("\t\tHello\n\nWorld\t\t"), " Hello World ")
        @Assert(dedupSpaces(""), "")
        @Assert(dedupSpaces("HelloWorld"), "HelloWorld")
        @Assert(dedupSpaces("   "), " ")
        @Assert(dedupSpaces("\n\t"), " ")
    }

    @TestCase
    public func test_cleanSpaces() {
        @Assert(cleanSpaces("Hello  World"), "Hello World")
        @Assert(cleanSpaces("Hello\t\tWorld"), "Hello World")
        @Assert(cleanSpaces("Hello\n\nWorld"), "Hello World")
        @Assert(cleanSpaces("   Hello   World   "), "Hello World")
        @Assert(cleanSpaces("   Hello World"),"Hello World")
        @Assert(cleanSpaces("Hello World    "),"Hello World")
        @Assert(cleanSpaces("\t\tHello\n\nWorld\t\t"), "Hello World")
        @Assert(cleanSpaces(""), "")
        @Assert(cleanSpaces("HelloWorld"), "HelloWorld")
        @Assert(cleanSpaces("   "), "")
        @Assert(cleanSpaces("\n\t"), "")
    }

    @TestCase
    public func test_onlyLetters() {
        @Assert(onlyLetters("abc123"), "abc")
        @Assert(onlyLetters("abc 123!"), "abc")
        @Assert(onlyLetters("1234"), "")
        @Assert(onlyLetters("  abc  def  "), "abcdef")
        @Assert(onlyLetters(""), "")
        @Assert(onlyLetters("A B C"), "ABC")
        @Assert(onlyLetters("!@#$%^"), "")
        @Assert(onlyLetters("Hello, World!"), "HelloWorld")
        @Assert(onlyLetters("123 ABC456 DEF"), "ABCDEF")
        @Assert(onlyLetters("Good#Morning123"), "GoodMorning")
        @Assert(onlyLetters("A B C!@#"), "ABC")
    }

    @TestCase
    public func test_onlyDigits() {
        @Assert(onlyDigits("abc123"), "123")
        @Assert(onlyDigits("abc 123!"), "123")
        @Assert(onlyDigits("1234"), "1234")
        @Assert(onlyDigits(""), "")
        @Assert(onlyDigits("1 2 3 4 5"), "12345")
        @Assert(onlyDigits("!@#$%^"), "")
        @Assert(onlyDigits("4567,890"), "4567890")
        @Assert(onlyDigits("123-45_67"), "1234567")
        @Assert(onlyDigits("!12!34"), "1234")
        @Assert(onlyDigits("123abc456"), "123456")
    }

    @TestCase
    public func test_OnlyLettersAndNumbers() {
        @Assert(onlyLettersAndNumbers("abc123"), "abc123")
        @Assert(onlyLettersAndNumbers("abc 123!"), "abc123")
        @Assert(onlyLettersAndNumbers("1234"), "1234")
        @Assert(onlyLettersAndNumbers("abcd"), "abcd")
        @Assert(onlyLettersAndNumbers(""), "")
        @Assert(onlyLettersAndNumbers(" !@#$%^   "), "")
        @Assert(onlyLettersAndNumbers("123 abc!@# def 456"), "123abcdef456")
        @Assert(onlyLettersAndNumbers("123-45_67"), "1234567")
        @Assert(onlyLettersAndNumbers("abC@D123"), "abCD123")
    }

    @TestCase
    public func test_removeDigits() {
        @Assert(removeDigits("abc123"), "abc")
        @Assert(removeDigits("abc"), "abc")
        @Assert(removeDigits("1234"), "")
        @Assert(removeDigits("a1b2c3d"), "abcd")
        @Assert(removeDigits(""), "")
        @Assert(removeDigits(" !@#$%^    "), " !@#$%^    ")
        @Assert(removeDigits("123 abc!@# def 456"), " abc!@# def ")
        @Assert(removeDigits("123-45_67"), "-_")
        @Assert(removeDigits("abC@D123"), "abC@D")
    }
}
