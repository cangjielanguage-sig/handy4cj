package handy4cj

import std.collection.*
import std.unicode.*

// TransformNone 没有排序任何转换，仅限制最大长度
// TransformNone 会关闭所有其他标志。
const TransformNone: UInt = 1

// TransformFlagTrim 在处理输入时修剪前后空格
// TransformFlagTrim 会修剪字符串，去除前导和尾随空格
const TransformFlagTrim: UInt = 2

// TransformFlagLowerCase 将字符串转换为小写
// 如果多个大小写转换标志被组合，则最后一个转换标志生效，按以下顺序考虑：TransformFlagTitleCase、TransformFlagLowerCase 和 TransformFlagUpperCase。
const TransformFlagLowerCase: UInt = 4

// TransformFlagUpperCase 将字符串转换为大写
// 如果多个大小写转换标志被组合，则最后一个转换标志生效，按以下顺序考虑：TransformFlagTitleCase、TransformFlagLowerCase 和 TransformFlagUpperCase。
const TransformFlagUpperCase: UInt = 8

// TransformFlagOnlyDigits 移除所有非数字字符
const TransformFlagOnlyDigits: UInt = 16

// TransformFlagOnlyLetters 移除所有非字母字符
const TransformFlagOnlyLetters: UInt = 32

// TransformFlagOnlyLettersAndDigits 仅保留字母和数字
const TransformFlagOnlyLettersAndDigits: UInt = 64

// TransformFlagHash 在处理所有其他标志后，对字符串应用 SHA256 哈希输出
// 该例程对给定字符串应用 handy.StringHash() 函数
const TransformFlagHash: UInt = 128

// TransformFlagTitleCase 将字符串首字母大写
// 如果多个大小写转换标志被组合，则最后一个转换标志生效，按以下顺序考虑：TransformFlagTitleCase、TransformFlagLowerCase 和 TransformFlagUpperCase。
const TransformFlagTitleCase: UInt = 256

// TransformFlagRemoveDigits 移除所有数字字符，不影响其他字符
// 如果与 TransformFlagOnlyLettersAndDigits、TransformFlagOnlyDigits 或 TransformFlagOnlyLetters 组合使用，则无效
const TransformFlagRemoveDigits: UInt = 512

// TODO
// 实现对字符串标题化
public func title(s: String):String{
    var prev = " "
    let result = ArrayList<Rune>([])
    for (i in s.toRuneArray()){
        match (prev.isBlank()) {
            case true => result.append(i.toTitleCase())
            case false => result.append(i)
        }
        prev = i.toString()
    }
    return String(result.toArray())
}

// transform 根据给定的标志/参数处理字符串，具体如下：
// 转换操作是按任意顺序进行的，这可能导致意外的输出。如果输入很重要，请使用 TransformSerially。
// 如果 maxLen == 0，则跳过截断。
// 最后的操作按顺序是截断和修剪。
public func transform(s: String, maxLen: Int64, transformFlags: UInt): String {
    if (s == "") {
        return s
    }

    var result = s
    if ((transformFlags & TransformNone) == TransformNone) {
        return String(result.toRuneArray().slice(0, maxLen))
    }

    if ((transformFlags & TransformFlagOnlyLettersAndDigits) == TransformFlagOnlyLettersAndDigits) {
        result = onlyLettersAndNumbers(result)
    }

    if ((transformFlags & TransformFlagOnlyDigits) == TransformFlagOnlyDigits) {
        result = onlyDigits(result)
    }

    if ((transformFlags & TransformFlagOnlyLetters) == TransformFlagOnlyLetters) {
        result = onlyLetters(result)
    }

    if ((transformFlags & TransformFlagRemoveDigits) == TransformFlagRemoveDigits) {
        result = removeDigits(result)
    }

    if ((transformFlags & TransformFlagTrim) == TransformFlagTrim) {
        result = result.trimAscii()
    }

    if ((transformFlags & TransformFlagTitleCase) == TransformFlagTitleCase) {
        result = title(result.toLower())
    }

    if ((transformFlags & TransformFlagUpperCase) == TransformFlagUpperCase) {
        result = result.toUpper()
    }

    if ((transformFlags & TransformFlagLowerCase) == TransformFlagLowerCase) {
        result = result.toLower()
    }

    if ((transformFlags & TransformFlagHash) == TransformFlagHash) {
        result = stringHash(result)
    }

    if (result == "") {
        return result
    }

    if (result.toRuneArray().size > maxLen && maxLen > 0) {
        result = String(result.toRuneArray().slice(0, maxLen))
    }

    if ((transformFlags & TransformFlagTrim) == TransformFlagTrim) {
        result = result.trimAscii()
    }
    return result
}

// transformSerially 按照参数顺序重新格式化给定的字符串
// 示例：transformSerially("uh lalah 123", 4, TransformFlagOnlyDigits, TransformFlagHash, TransformFlagUpperCase)
//          首先移除非数字字符，然后对字符串进行哈希处理，最后将其转换为大写。
// 如果 maxLen == 0，则跳过截断。
// 截断是最后一个操作。
public func transformSerially(s: String, maxLen: Int, transformFlags: Array<UInt>): String {
    if (s == "") {
        return ""
    }

    var result = s
    for (flag in transformFlags) {
        if ((flag & TransformFlagOnlyLettersAndDigits) == TransformFlagOnlyLettersAndDigits) {
            result = onlyLettersAndNumbers(result)
        }

        if ((flag & TransformFlagOnlyDigits) == TransformFlagOnlyDigits) {
            result = onlyDigits(result)
        }

        if ((flag & TransformFlagOnlyLetters) == TransformFlagOnlyLetters) {
            result = onlyLetters(result)
        }

        if ((flag & TransformFlagRemoveDigits) == TransformFlagRemoveDigits) {
            result = removeDigits(result)
        }

        if ((flag & TransformFlagTrim) == TransformFlagTrim) {
            result = result.trimAscii()
        }

        if ((flag & TransformFlagTitleCase) == TransformFlagTitleCase) {
            result = title(result.toLower())
        }

        if ((flag & TransformFlagUpperCase) == TransformFlagUpperCase) {
            result = result.toUpper()
        }

        if ((flag & TransformFlagLowerCase) == TransformFlagLowerCase) {
            result = result.toLower()
        }

        if ((flag & TransformFlagHash) == TransformFlagHash) {
            result = stringHash(result)
        }
    }

    if (maxLen > 0 && result.toRuneArray().size > maxLen) {
        result = String(result.toRuneArray().slice(0, maxLen))
    }

    return result
}
