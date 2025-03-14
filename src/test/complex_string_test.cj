package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestCheckStrDemo {
    let summary: String
    let input: String
    let minLen: UIntNative
    let maxLen: UIntNative
    let flags: UInt64
    let expectedOutput: Int8

    public init(summary: String,input: String,minLen: UIntNative,maxLen: UIntNative,flags: UInt64,expectedOutput: Int8){
        this.summary = summary
        this.input = input 
        this.minLen = minLen
        this.maxLen = maxLen
        this.flags = flags
        this.expectedOutput = expectedOutput
    }
}

public class TestStrContainsEmailDemo{
    let summary: String
    let input: String
    let expectedOutput: Bool

    public init(summary: String,input: String,expectedOutput: Bool){
        this.summary = summary
        this.input = input
        this.expectedOutput = expectedOutput
    }
}

@Test
public class ComplexStringTest{
    @TestCase
    public func test_checkStr(){
        let testList = Array<TestCheckStrDemo>([
           TestCheckStrDemo("perfect string", "ЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏ АБВГДЕЖЗИЙКЛМНОП РСТУФХЦЧШЩЪЫ ЬЭЮЯ абвгдежзийкл мнопрстуфхцчшщ ъыьэюяѐёђѓєѕіїј љњћќѝўџѠѡѢѣѤѥѦѧѨѩѪѬѭѮѯ", 0, 118, 0, checkStrOk),
           TestCheckStrDemo("allowed empty string", "", 0, 1000, checkStrAllowEmpty, checkStrOk),
           TestCheckStrDemo("fails on empty string", "", 0, 100, 0, checkStrEmptyDenied),
           TestCheckStrDemo("fails on min length", "four", 5, 100, 0, checkStrTooShort),
           TestCheckStrDemo("fails on max length", "four", 4, 3, 0, checkStrTooLong),
           TestCheckStrDemo("denies space", "two words", 0, 100, checkStrDenySpaces, checkStrSpaceDenied),
           TestCheckStrDemo("denies tab", "two	words", 0, 100, checkStrDenySpaces, checkStrSpaceDenied),
           TestCheckStrDemo("denies \n", "row\nrow", 0, 100, checkStrDenySpaces, checkStrSpaceDenied),
           TestCheckStrDemo("denies \r", "row\rrow", 0, 100, checkStrDenySpaces, checkStrSpaceDenied),
           TestCheckStrDemo("denies numbers", "this is a number: 9", 0, 100, checkStrDenyNumbers, checkStrNumbersDenied),
           TestCheckStrDemo("denies numbers UNICODE", " 九 に 三 Ⅷ'", 0, 100, checkStrDenyNumbers, checkStrNumbersDenied),
           TestCheckStrDemo("denies letters", "o123456789", 0, 100, checkStrDenyLetters, checkStrLettersDenied),
           TestCheckStrDemo("denies symbols", "a symbol %", 0, 100, checkStrDenySymbols, checkStrSymbolsDenied),
           TestCheckStrDemo("denies more than one word", "two words", 0, 100, checkStrDenyMoreThanOneWord, checkStrMoreThanOneWordDenied),
           TestCheckStrDemo("denies words separated by new line", "one\ntwo", 0, 100, checkStrDenyMoreThanOneWord, checkStrMoreThanOneWordDenied),
           TestCheckStrDemo("denies uppercase", "upper Case", 0, 100, checkStrDenyUpperCase, checkStrUpperCaseDenied),
           TestCheckStrDemo("denies lowercase", "LOWER cASE", 0, 100, checkStrDenyLowerCase, checkStrLowerCaseDenied),
           TestCheckStrDemo("denies unicode", "TAB	ÇÂÖÉд", 0, 100, checkStrDenyUnicode, checkStrUnicodeDenied),
           TestCheckStrDemo("missed numbers", "NO NUMBERS", 0, 100, checkStrRequireNumbers, checkStrNumbersNotFound),
           TestCheckStrDemo("missed letters", " 87 %323232	", 0, 100, checkStrRequireLetters, checkStrLettersNotFound),
           TestCheckStrDemo("missed symbols", "NO SYMBOLS 123", 0, 100, checkStrRequireSymbols, checkStrSymbolsNotFound),
           TestCheckStrDemo("missed more than one word", "FHFJKDHFSDJKH012308312-0=-0=-00", 0, 100, checkStrRequireMoreThanOneWord, checkStrMoreThanOneWordNotFound),
           TestCheckStrDemo("missed uppercase", "all lowercase 456", 0, 100, checkStrRequireUpperCase, checkStrUpperCaseNotFound),
           TestCheckStrDemo("missed lowercase", "ALL UPPERCASE 789", 0, 100, checkStrRequireLowercase, checkStrLowercaseNotFound)
        ])

        var i=0
        while (i < testList.size){
            @Expect(checkStr(testList[i].input, testList[i].minLen, testList[i].maxLen, testList[i].flags), testList[i].expectedOutput)
            i++
        }
    }

    @TestCase
    public func test_strContainsEmail(){
        let testList = Array<TestStrContainsEmailDemo>([
            TestStrContainsEmailDemo("empty string", "", false),
		    TestStrContainsEmailDemo("no valid email", "email-gmail.com", false),
		    TestStrContainsEmailDemo("the string is an email address", "email@gmail.com", true),
		    TestStrContainsEmailDemo("valid email within", "dasdsdsdsda-*9email@gmail.comdsdsds.88", true)
        ])

        var i = 0
        while (i < testList.size){
            @Expect(strContainsEmail(testList[i].input),testList[i].expectedOutput)
            i++
        }
    }

    
}