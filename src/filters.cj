package handy4cj

import std.collection.*
import std.regex.*

let reDupSpaces = Regex("\\s+")

// dedupSpaces 移除重复的空格、制表符和换行符
public func dedupSpaces(s: String): String {
    if (s == "") {
        return ""
    }
    let matcher = Matcher(reDupSpaces, s)
    return matcher.replaceAll(" ")
}

// cleanSpaces 移除重复的空格、制表符和换行符，然后修剪字符串两端的空格
public func cleanSpaces(s: String): String {
    if (s == "") {
        return ""
    }
    return dedupSpaces(s).trimAscii()
}

// onlyLetters 仅返回给定字符串中的字母，去除所有其他字符（如数字、空格等）
public func onlyLetters(sequence: String): String {
    if (sequence.toRuneArray().size == 0) {
        return ""
    }
    let letters = ArrayList<String>([])
    sequence.toRuneArray() |> filter {i => i.isAsciiLetter()} |> forEach<Rune> {i => letters.append(i.toString())}
    return String.join(letters.toArray())
}

// onlyDigits 仅返回给定字符串中的数字，去除所有其他字符（如字母、空格等）
public func onlyDigits(sequence: String): String {
    if (sequence.toRuneArray().size == 0) {
        return ""
    }
    let digits = ArrayList<String>([])
    sequence.toRuneArray() |> filter {i => i.isAsciiNumber()} |> forEach<Rune> {i => digits.append(i.toString())}
    return String.join(digits.toArray())
}

// onlyLettersAndNumbers 仅返回给定字符串中的字母和数字，去除所有其他字符，如空格和特殊符号。
public func onlyLettersAndNumbers(sequence: String): String {
    if (sequence.toRuneArray().size == 0) {
        return ""
    }
    let alphanumeric = ArrayList<String>([])
    sequence.toRuneArray() |> filter {i => i.isAsciiNumberOrLetter()} |>
        forEach<Rune> {i => alphanumeric.append(i.toString())}
    return String.join(alphanumeric.toArray())
}

// removeDigits 返回给定字符串，移除所有数字/数值字符
public func removeDigits(sequeue: String): String {
    if (sequeue.toRuneArray().size == 0) {
        return ""
    }
    let rs = ArrayList<String>([])
    sequeue.toRuneArray() |> filter {i => !i.isAsciiNumber()} |> forEach<Rune> {i => rs.append(i.toString())}
    return String.join(rs.toArray())
}
