package handy4cj

import std.collection.*
import std.unicode.*

// CheckNewPasswordResultOK 表示检查顺利通过
const CheckNewPasswordResultOK: UInt8 = 0
// CheckNewPasswordResultDivergent 密码与确认密码不一致
const CheckNewPasswordResultDivergent: UInt8 = 1
// CheckNewPasswordResultTooShort 密码太短
const CheckNewPasswordResultTooShort: UInt8 = 2
// CheckNewPasswordResultTooSimple 给定的密码不符合复杂度规则
const CheckNewPasswordResultTooSimple: UInt8 = 3
// CheckNewPasswordComplexityLowest 除了最低长度要求外没有其他规则
// >>> 此标志会关闭所有其他规则 <<<
const CheckNewPasswordComplexityLowest: UInt8 = 1
// CheckNewPasswordComplexityRequireLetter 密码至少需要一个字母
const CheckNewPasswordComplexityRequireLetter: UInt8 = 2
// CheckNewPasswordComplexityRequireUpperCase 密码至少需要一个大写字母。
// 只有在启用 CheckNewPasswordComplexityRequireLetter 时才有效
const CheckNewPasswordComplexityRequireUpperCase: UInt8 = 4
// CheckNewPasswordComplexityRequireNumber 密码至少需要一个数字
const CheckNewPasswordComplexityRequireNumber: UInt8 = 8
// CheckNewPasswordComplexityRequireSpace 密码必须包含至少一个空格
const CheckNewPasswordComplexityRequireSpace: UInt8 = 16
// CheckNewPasswordComplexityRequireSymbol 密码必须包含至少一个特殊字符，如 # 或 -
const CheckNewPasswordComplexityRequireSymbol: UInt8 = 32

// CheckNewPassword 根据给定的选项对新密码进行一些基本检查
// 该函数要求密码至少包含 4 个字符
// 示例：仅要求最低长度：CheckNewPassword("lalala", "lalala", 10, CheckNewPasswordComplexityLowest)
// 示例：要求数字和符号：CheckNewPassword("lalala", "lalala", 10, CheckNewPasswordComplexityRequireNumber|CheckNewPasswordComplexityRequireSymbol)
public func checkNewPassword(password: String, passwordConfirmation: String, minimumLength: UInt, flagComplexity: UInt8): UInt8 {
    let minPasswordLengthDefault: UInt = 4
    var newMinimumLength = minimumLength
    if (newMinimumLength < minPasswordLengthDefault) {
        newMinimumLength = 4
    }

    if (password.trimAscii().toRuneArray().size < Int64(newMinimumLength)) {
        return CheckNewPasswordResultTooShort
    }

    if (password != passwordConfirmation) {
        return CheckNewPasswordResultDivergent
    }

    var letterFound = false
    var numberFound = false
    var symbolFound = false
    var spaceFound = false
    var upperCaseFound = false

    if ((flagComplexity & CheckNewPasswordComplexityLowest) != CheckNewPasswordComplexityLowest) {
        letterFound = password.toRuneArray() |> any<Rune> {i => i.isLetter()}
        upperCaseFound = password.toRuneArray() |> any<Rune> {i => i.isUpperCase()}
        numberFound = password.toRuneArray() |> any<Rune> {i => i.isNumber()}
        symbolFound = password.toRuneArray() |> any<Rune> {i => runeHasSymbol(i)}
        spaceFound = password.toRuneArray() |> any<Rune> {i => i == r" "}
    }

    if ((flagComplexity & CheckNewPasswordComplexityRequireLetter) == CheckNewPasswordComplexityRequireLetter) {
        if (!letterFound) {
            return CheckNewPasswordResultTooSimple
        }
        if (((flagComplexity & CheckNewPasswordComplexityRequireUpperCase) == CheckNewPasswordComplexityRequireUpperCase) &&
            !upperCaseFound) {
            return CheckNewPasswordResultTooSimple
        }
    }

    if (((flagComplexity & CheckNewPasswordComplexityRequireNumber) == CheckNewPasswordComplexityRequireNumber) &&
        !numberFound) {
        return CheckNewPasswordResultTooSimple
    }

    if (((flagComplexity & CheckNewPasswordComplexityRequireSymbol) == CheckNewPasswordComplexityRequireSymbol) &&
        !symbolFound) {
        return CheckNewPasswordResultTooSimple
    }

    if (((flagComplexity & CheckNewPasswordComplexityRequireSpace) == CheckNewPasswordComplexityRequireSpace) &&
        !spaceFound) {
        return CheckNewPasswordResultTooSimple
    }

    return CheckNewPasswordResultOK
}
