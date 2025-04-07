package handy4cj

import std.collection.*

// RandomNumericString 返回一个长度介于给定的 lengthMin 和 lengthMax 之间的字符串
// forbiddenDigits 参数中的任何数字将被忽略
public func randomNumericString(forbiddenDogits: ArrayList<Int>, lengthMin: Int, lengthMax: Int): String {
    if (lengthMax < 0 || lengthMin < 0) {
        return ""
    }
    var length = 0
    match {
        case lengthMax < lengthMin => return ""
        case lengthMax == lengthMin => length = lengthMax
        case _ => length = randomInt(lengthMin, lengthMax)
    }

    if (length == 0) {
        return ""
    }

    let allowedDigits = HashMap<Int, Bool>(
        [(0, true), (1, true), (2, true), (3, true), (4, true), (5, true), (6, true), (7, true), (8, true), (9, true)])

    if (forbiddenDogits.size > 0) {
        forbiddenDogits |> forEach<Int> {i => allowedDigits[i] = false}
        let remainingAllowed = ArrayList<Int>([])
        allowedDigits |> filter {p => p[1]} |> forEach{p => remainingAllowed.append(p[0])}  
        if (remainingAllowed.size == 0) {
            return ""
        } else if (remainingAllowed.size == 1) {
            return remainingAllowed[0].toString() * length
        }
    }

    let s = ArrayList<String>([])
    while (s.size < length) {
        let x = randomInt(0, 9)
        if (allowedDigits[x]) {
            s.append(x.toString())
        }
    }
    return String.join(s.toArray())
}
