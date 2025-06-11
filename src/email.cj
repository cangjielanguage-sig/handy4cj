package handy4cj

import std.regex.*

let reEmail = Regex(
    "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?){1,}$"
)

// CheckEmail 如果给定的输入是一个有效的电子邮件地址，则返回 true
// 请注意，CheckEmail 在检查之前不会修剪（去除空白）或清理字符串
// 有关电子邮件地址结构的详细信息，请参阅 https://tools.ietf.org/html/rfc2822#section-3.4.1
public func checkEmail(email: String): Bool {
    if (email == "") {
        return false
    }

    let matchEmail = Matcher(reEmail, email)
    return !matchEmail.fullMatch().isNone()
}
