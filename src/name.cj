package handy4cj

import std.collection.*
import std.unicode.*

// CheckPersonNameResultOK 表示名字已通过验证
const CheckPersonNameResultOK: UInt8 = 0
// CheckPersonNameResultPolluted 该函数只接受字母、单引号和空格
const CheckPersonNameResultPolluted: UInt8 = 1
// CheckPersonNameResultTooFewWords 该函数要求至少有 2 个单词
const CheckPersonNameResultTooFewWords: UInt8 = 2
// CheckPersonNameResultTooShort 所有字符的总和必须 >= 6
const CheckPersonNameResultTooShort: UInt8 = 3
// CheckPersonNameResultTooSimple 名字规则要求至少有一个单词
const CheckPersonNameResultTooSimple: UInt8 = 4

// checkPersonName 如果名字包含至少两个单词，一个长度 >= 3 个字符，另一个长度 >= 2 个字符，则返回 true。
// 这是一个特殊的标准，但这是 OpenSourceMagic，你可以根据自己的需求进行更改和适配。
public func checkPersonName(name: String, acceptEmpty: Bool): UInt8 {
    let trimName = name.trimAscii()
    if (trimName == "") {
        return match (acceptEmpty) {
            case true => CheckPersonNameResultOK
            case false => CheckPersonNameResultTooShort
        }
    }

    if (trimName.toRuneArray() |>
        any {i => !i.isLetter() && i.toString() != " " && i.toString() != "\'" && i.toString() != "-"}) {
        return CheckPersonNameResultPolluted
    }
    let splitName = trimName.split(" ", removeEmpty: true)
    if (splitName.size < 2) {
        return CheckPersonNameResultTooFewWords
    }

    var found3 = false
    var found2 = false
    for (i in splitName) {
        if (!found3 && i.toRuneArray().size >= 3) {
            found3 = true
            continue
        }
        if (!found2 && i.toRuneArray().size >= 2) {
            found2 = true
            continue
        }
    }

    if (!found2 || !found3) {
        return CheckPersonNameResultTooSimple
    }
    return CheckPersonNameResultOK
}

// nameFirstAndLast 返回给定输入中的第一个和最后一个单词/名字，可选地根据 transformFlags 进行转换
// 示例：handy.NameFirstAndLast("friedrich wilhelm nietzsche", handy.TransformFlagTitleCase) // 返回 "Friedrich Nietzsche"
public func nameFirstAndLast(name: String, transformFlags: UInt): String {
    var newName = name.replace("\t", " ")
    if (transformFlags != TransformNone) {
        newName = transform(newName, newName.toRuneArray().size, transformFlags)
    }
    let trimName = newName.trimAscii()
    let words = trimName.split(" ", removeEmpty: true)
    if (words.size <= 0) {
        return ""
    }
    if (words.size == 1) {
        return words[0]
    }
    return String.join([words[0], words[words.size - 1]], delimiter: " ")
}

// NameFirst 返回给定输入中的第一个单词/名字，可选地根据 transformFlags 进行转换
// 示例：handy.NameFirst("friedrich wilhelm nietzsche", handy.TransformFlagTitleCase) // 返回 "Friedrich"
public func nameFirst(name: String, transformFlags: UInt): String {
    var newName = name.replace("\t", " ")
    if (transformFlags != TransformNone) {
        newName = transform(newName, newName.toRuneArray().size, transformFlags)
    }
    let trimName = newName.trimAscii()
    let words = trimName.split(" ", removeEmpty: true)
    if (words.size >= 1) {
        return words[0]
    }
    return ""
}

// NameInitials 返回给定输入每个单词的首字母，可选地根据 transformFlags 进行转换   
public func nameInitials(name: String, transformFlags: UInt): String {
    var newName = name.trimAscii().replace("\t", " ")
    if (newName == "") {
        return ""
    }
    if (transformFlags != TransformNone) {
        newName = transform(newName, newName.toRuneArray().size, transformFlags)
    }
    let words = newName.split(" ", removeEmpty: true)
    if (words.size <= 0) {
        return ""
    }
    let result = ArrayList<String>()
    words |> forEach<String> {i => result.add(i.toRuneArray()[0].toString())}
    return String.join(result.toArray(), delimiter: " ")
}
