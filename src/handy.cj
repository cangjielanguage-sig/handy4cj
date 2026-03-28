package handy4cj

import stdx.crypto.digest.*
import stdx.encoding.hex.*
import std.collection.*
import std.core.*

import std.regex.*
import std.unicode.*

// runeHasSymbol 如果给定的字符包含符号，则返回 true
public func runeHasSymbol(ru: Rune): Bool {
    let allowedSymbols = "!\"#$%&'(),*+´-./:;<=>?@[\\]^_`{|}~"
    return allowedSymbols.toRuneArray() |> any {i => ru == i}
}

// stringHash 简单地生成给定字符串的 SHA256 哈希值
// 如果发生错误，返回 ""
public func stringHash(s: String): String {
    let h = SHA256()
    try {
        h.write(s.toArray())
    } catch (e: Exception) {
        return ""
    }
    return toHexString(h.finish())
}

// checkPhone 如果给定的输入包含 9 到 14 位数字，则返回 true
public func checkPhone(phone: String, acceptEmpty: Bool): Bool {
    let newPhone = onlyDigits(phone)
    return (acceptEmpty && newPhone == "") || ((newPhone.size >= 9) && (newPhone.size <= 14))
}

// between 检查参数 n 是否在低值和高值之间
public func between(n: Int64, low: Int64, high: Int64): Bool {
    return n >= low && n <= high
}

// tif 是一个简单实现的三元 IF 运算符
public func tif(condition: Bool, tifThen: Any, tifElse: Any): Any {
    return match (condition) {
        case true => tifThen
        case fasle => tifElse
    }
}

// truncate 限制给定字符串的长度，根据参数决定是否修剪
public func truncate(s: String, maxLen: Int64, trim: Bool): String {
    if (s == "") {
        return s
    }
    return match (trim) {
        case false => String(s.toRuneArray().slice(0, maxLen))
        case true => String(s.toRuneArray().slice(0, maxLen)).trimAscii()
    }
}

// matchesAny 如果给定的任何项与目标（搜索参数）匹配（相等），则返回 true
public func matchesAny(search: Any, items: Array<Any>): Bool {
    return items |> any<Any> {i => (i as String) == (search as String)}
}

// hasOnlyNumbers 如果输入完全是数字，则返回 true
public func hasOnlyNumbers(sequence: String): Bool {
    if (sequence.toRuneArray().size == 0) {
        return false
    }
    return sequence.toRuneArray() |> all {i => i.isNumber()}
}

// hasOnlyLetters 如果输入完全由字母组成，则返回 true
public func hasOnlyLetters(sequence: String): Bool {
    if (sequence.toRuneArray().size == 0) {
        return false
    }
    return sequence.toRuneArray() |> all {i => i.isLetter()}
}

// trimLen 返回修剪掉空格后的字符数量
public func trimLen(text: String): Int64 {
    return text.trimAscii().toRuneArray().size
}

// checkMinLen 验证字符数是否大于或等于给定的最小值
// 如果给定的字符串长度大于或等于 minLength 参数，则返回 true
public func checkMinLen(value: String, minLength: Int64): Bool {
    return value.trimAscii().size >= minLength
}

// isNumericType 检查参数的具体类型是否对应原生数值类型
public func isNumericType(x: Any): Bool {
    if ((x is Int8) || (x is Int16) || (x is Int32) || (x is Int64) || (x is IntNative) || (x is UInt8) || (x is UInt16) ||
        (x is UInt32) || (x is UInt64) || (x is UIntNative) || (x is Float16) || (x is Float32) || (x is Float64)) {
        return true
    }
    return false
}

// bit 仅返回 uint8(0) 或 uint8(1)。
// 它接收一个Any类型的参数，当它是一个数字且该数字为 0 时，返回 0，否则返回 1。
// 如果参数不是数字，返回 0。
public func bit(x: Any): UInt8 {
    if (isNumericType(x) && (x as Int64) != 0) {
        return 1
    }
    return 0
}

// boolean 返回某个值的布尔版本/解释；
// 它接收一个接口，当值是数字时，boolean() 返回零为假，非零为真。
// 如果是字符串，则尝试查找 "1"、"T"、"TRUE" 来返回真。
// 其他情况返回假。
public func boolean(x: Any): Bool {
    if (isNumericType(x)) {
        return (x as Int64) != 0
    }
    match (x as String) {
        case None => return false
        case Some(v) => return matchesAny(transform(v, 4, TransformFlagLowerCase | TransformFlagLowerCase), "1", "true",
            "t")
    }
}

// reverse 返回给定字符串的反向，字母顺序反转。
public func reverseString(s: String): String {
    if (s.toRuneArray().size < 2) {
        return s
    }
    let reverseStr = s.toRuneArray()
    reverseStr.reverse()
    return String(reverseStr)
}

// stringReplaceAll 持续替换，直到没有更多的替换项。
public func stringReplaceAll(original: String, replacementParis: Array<String>): String {
    if (replacementParis.size % 2 != 0) {
        throw Exception("The number of elements in replacementParis should be even")
    }
    var result = original
    for (i in 0..replacementParis.size / 2) {
        result = result.replace(replacementParis[2 * i], replacementParis[2 * i + 1])
    }
    return result
}

// positiveOrZero 检查一个有符号数字是否为负数，如果是负数则返回零。
public func positiveOrZero(n: Int64): Int64 {
    match (n > 0) {
        case true => return n
        case false => return 0
    }
}
