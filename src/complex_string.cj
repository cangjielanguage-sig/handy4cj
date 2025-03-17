package handy4cj

import std.collection.*
import std.core.*
import std.regex.*
import std.unicode.*

// 判断字符串中是否有数字字符
public func hasNumber(s: String): Bool {
    return s.toRuneArray() |> any {p => p.isNumber()}
}

// 判断字符串中是否有字母字符
public func hasLetter(s: String): Bool {
    return s.toRuneArray() |> any {p => p.isLetter()}
}

// 判断字符串中是否有非字母数字空格字符
public func hasSymbol(s: String): Bool {
    return s.toRuneArray() |> any {p => !p.isWhiteSpace() && !p.isLetter() && !p.isNumber()}
}

// CheckStrAllowEmpty 允许空字符串 ""
const checkStrAllowEmpty: UInt64 = 1

// CheckStrDenySpaces 禁止空格、制表符、换行符和回车符
const checkStrDenySpaces: UInt64 = 2

// CheckStrDenyNumbers 禁止数字
const checkStrDenyNumbers: UInt64 = 4

// CheckStrDenyLetters 禁止字母
const checkStrDenyLetters: UInt64 = 8

// CheckStrDenySymbols 禁止符号。如果它不是数字、字母或空格，就认为是符号
const checkStrDenySymbols: UInt64 = 16

// CheckStrDenyMoreThanOneWord 禁止多个单词
const checkStrDenyMoreThanOneWord: UInt64 = 32

// CheckStrDenyUpperCase 禁止大写字母
const checkStrDenyUpperCase: UInt64 = 64

// CheckStrDenyLowercase 禁止小写字母
const checkStrDenyLowerCase: UInt64 = 128

// CheckStrDenyUnicode 禁止非 ASCII 字符
const checkStrDenyUnicode: UInt64 = 256

// CheckStrRequireNumbers 要求字符串中至少包含 1 个数字
const checkStrRequireNumbers: UInt64 = 512

// CheckStrRequireLetters 要求字符串中至少包含 1 个字母
const checkStrRequireLetters: UInt64 = 1024

// CheckStrRequireSymbols 要求字符串中至少包含 1 个符号。如果它不是数字、字母或空格，就认为是符号
const checkStrRequireSymbols: UInt64 = 2048

// CheckStrRequireMoreThanOneWord 要求字符串中至少包含 2 个单词
const checkStrRequireMoreThanOneWord: UInt64 = 4096

// CheckStrRequireUpperCase 要求字符串中至少包含 1 个大写字母
const checkStrRequireUpperCase: UInt64 = 8192

// CheckStrRequireLowercase 要求字符串中至少包含 1 个小写字母
const checkStrRequireLowercase: UInt64 = 16384

// CheckStrOk 意味着“正常”
const checkStrOk: Int8 = 0

// CheckStrEmptyDenied 字符串为空时返回此值
const checkStrEmptyDenied: Int8 = -1

// CheckStrTooShort 字符串太短时返回此值
const checkStrTooShort: Int8 = -2

// CheckStrTooLong 字符串太长时返回此值
const checkStrTooLong: Int8 = -4

// CheckStrSpaceDenied 禁止空格时返回此值
const checkStrSpaceDenied: Int8 = -5

// CheckStrNumbersDenied 禁止数字时返回此值
const checkStrNumbersDenied: Int8 = -6

// CheckStrLettersDenied 禁止字母时返回此值
const checkStrLettersDenied: Int8 = -7

// CheckStrSymbolsDenied 禁止符号时返回此值
const checkStrSymbolsDenied: Int8 = -8

// CheckStrMoreThanOneWordDenied 禁止多个单词时返回此值
const checkStrMoreThanOneWordDenied: Int8 = -9

// CheckStrUpperCaseDenied 禁止大写字母时返回此值
const checkStrUpperCaseDenied: Int8 = -10

// CheckStrLowercaseDenied 禁止小写字母时返回此值
const checkStrLowerCaseDenied: Int8 = -11

// CheckStrUnicodeDenied 禁止非 ASCII 字符时返回此值
const checkStrUnicodeDenied: Int8 = -12

// CheckStrNumbersNotFound 没有找到数字时返回此值
const checkStrNumbersNotFound: Int8 = -13

// CheckStrLettersNotFound 没有找到字母时返回此值
const checkStrLettersNotFound: Int8 = -14

// CheckStrSymbolsNotFound 没有找到符号时返回此值
const checkStrSymbolsNotFound: Int8 = -15

// CheckStrMoreThanOneWordNotFound 没有找到多个单词时返回此值
const checkStrMoreThanOneWordNotFound: Int8 = -16

// CheckStrUpperCaseNotFound 没有找到大写字母时返回此值
const checkStrUpperCaseNotFound: Int8 = -17

// CheckStrLowercaseNotFound 没有找到小写字母时返回此值
const checkStrLowercaseNotFound: Int8 = -18

public func checkStr(seq: String, minLen: UIntNative, maxLen: UIntNative, rules: UInt64): Int8 {
    let strLen = UIntNative(seq.toRuneArray().size)

    // 判断字符串是否为空
    if (seq == "") {
        if ((rules & checkStrAllowEmpty) == checkStrAllowEmpty) {
            return checkStrOk
        }
        return checkStrEmptyDenied
    }

    // 判断字符串是否小于最短长度
    if (strLen < minLen) {
        return checkStrTooShort
    }

    // 判断字符串字符串是否大于最大长度
    if (maxLen > 0 && strLen > maxLen) {
        return checkStrTooLong
    }

    // 判断字符串是否有空格
    if (((rules & checkStrDenySpaces) == checkStrDenySpaces) && (seq.contains("\n") || seq.contains("\t") ||
        seq.contains("\r") || seq.contains(" "))) {
        return checkStrSpaceDenied
    }

    // 判断字符串是否有数字字符
    let containsNumbers = hasNumber(seq)
    if (((rules & checkStrDenyNumbers) == checkStrDenyNumbers) && containsNumbers) {
        return checkStrNumbersDenied
    }

    // 判断字符串是否有字母字符
    let containsLetters = hasLetter(seq)
    if (((rules & checkStrDenyLetters) == checkStrDenyLetters) && containsLetters) {
        return checkStrLettersDenied
    }

    // 判断字符串是否有符号（非数字字母空格）字符
    let containsSymbols = hasSymbol(seq)
    if (((rules & checkStrDenySymbols) == checkStrDenySymbols) && containsSymbols) {
        return checkStrSymbolsDenied
    }

    // 判断字符串是否多于一个单词，按照空白字符进行切割
    var containsMoreThanOneWord = 0
    var inWord = false
    for (i in seq.toRuneArray()) {
        if (i.toString().isBlank()) {
            inWord = false
        } else {
            if (!inWord) {
                containsMoreThanOneWord++
                inWord = true
            }
        }
    }
    if (((rules & checkStrDenyMoreThanOneWord) == checkStrDenyMoreThanOneWord) && containsMoreThanOneWord > 1) {
        return checkStrMoreThanOneWordDenied
    }

    // 判断字符串是否有大写字母字符
    let containsUpperCase = seq.toRuneArray() |> any {p => containsLetters && p.isUpperCase()}
    if (((rules & checkStrDenyUpperCase) == checkStrDenyUpperCase) && containsUpperCase) {
        return checkStrUpperCaseDenied
    }

    // 判断字符串是否有小写字母字符
    let containsLowerCase = seq.toRuneArray() |> any {p => containsLetters && p.isLowerCase()}
    if (((rules & checkStrDenyLowerCase) == checkStrDenyLowerCase) && containsLowerCase) {
        return checkStrLowerCaseDenied
    }

    // 判断字符串中是否有不符合ASCII码的字符
    if (((rules & checkStrDenyUnicode) == checkStrDenyUnicode) && (seq.toRuneArray() |> any {p => !p.isAscii()})) {
        return checkStrUnicodeDenied
    }

    // 判断字符串是否没有数字
    if (((rules & checkStrRequireNumbers) == checkStrRequireNumbers) && !containsNumbers) {
        return checkStrNumbersNotFound
    }

    // 判断字符串是否没有字母
    if (((rules & checkStrRequireLetters) == checkStrRequireLetters) && !containsLetters) {
        return checkStrLettersNotFound
    }

    // 判断字符串是否没有符号
    if (((rules & checkStrRequireSymbols) == checkStrRequireSymbols) && !containsSymbols) {
        return checkStrSymbolsNotFound
    }

    // 判断字符串是否少于一个单词
    if (((rules & checkStrRequireMoreThanOneWord) == checkStrRequireMoreThanOneWord) && !(containsMoreThanOneWord > 1)) {
        return checkStrMoreThanOneWordNotFound
    }

    // 判断字符串是否没有大写字母
    if (((rules & checkStrRequireUpperCase) == checkStrRequireUpperCase) && !containsUpperCase) {
        return checkStrUpperCaseNotFound
    }

    // 判断字符串时候没有小写字母
    if (((rules & checkStrRequireLowercase) == checkStrRequireLowercase) && !containsLowerCase) {
        return checkStrLowercaseNotFound
    }

    // 字符串正常
    return checkStrOk
}

// 判断是否符合电子邮件格式
let reEmailFinder = Regex("([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-zA-Z0-9_-]+)")

public func strContainsEmail(seq: String): Bool {
    let matchEmail = Matcher(reEmailFinder, seq)
    return !matchEmail.findAll().isNone()
}
