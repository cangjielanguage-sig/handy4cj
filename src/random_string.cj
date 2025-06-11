package handy4cj

import std.collection.*
import std.log.*
import std.random.*
import std.unicode.*

// isSymbol 判断给定的字符是否是符号
public func isSymbol(r: Rune) {
    if ((r >= Rune(0x20A0) && r <= Rune(0x20CF)) || (r >= Rune(0x2200) && r <= Rune(0x22FF)) || (r >= Rune(0x2300) &&
        r <= Rune(0x23FF)) || (r >= Rune(0x2B50) && r <= Rune(0x2B59)) || (r >= Rune(0x2980) && r <= Rune(0x29FF)) || (r >=
        Rune(0x2B00) && r <= Rune(0x2BFF)) || (r >= Rune(0x2E00) && r <= Rune(0x2E7F)) || (r >= Rune(0x2000) && r <=
        Rune(0x206F))) {
        return true
    }
    return false
}

// minimumPrintableRune 和 maximumPrintableRune 对生成字符的范围进行限制
const minimumPrintableRune = 32
const maximumPrintableRune = 1114111

// RandomString 根据给定的参数/规则生成一个字符串序列
public func randomString(minLen: Int, maxLen: Int, allowUnicode: Bool, allowNumbers: Bool, allowSymbols: Bool,
    allowSpaces: Bool): String {
    if (minLen < 0 || maxLen < 0) {
        return ""
    }
    var newMinLen = minLen
    var strLen = 0
    match {
        case maxLen == 0 => return ""
        case minLen == 0 => newMinLen = 1
        case minLen > maxLen => return ""
        case minLen < maxLen => strLen = randomInt(minLen, maxLen)
        case _ => strLen = maxLen
    }

    let firstOrLast = {i: Int, strLen: Int => i == 0 || i == strLen - 1}
    let asciiTable = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
        .toRuneArray()

    let str = ArrayList<Rune>([])
    var r: Rune = r' '
    while (str.size < strLen) {
        match (allowUnicode) {
            case false => r = asciiTable[Int64(randomInt(0, asciiTable.size))]
            case true => try {
                r = Rune(randomInt(minimumPrintableRune, maximumPrintableRune))
            } catch (e: OverflowException) {
                r = Rune(randomInt(minimumPrintableRune, maximumPrintableRune))
            }
        }
        match {
            case r.isLetter() => str.append(r)
            case r.isNumber() && allowNumbers => str.append(r)
            case (r.isAsciiPunctuation() || isSymbol(r)) && allowSymbols => str.append(r)
            case r.isWhiteSpace() && allowSpaces && !firstOrLast(str.size, strLen) => str.append(r)
            case _ => continue
        }
    }

    return String(str)
}
