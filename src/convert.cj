package handy4cj

import std.collection.*
import std.core.*
import std.math.numeric.*

public func stringAsFloat(s: String, decimalSeparator: Rune, thousandsSeparator: Rune): Float64 {
    if (s == "") {
        return 0.0
    }

    var newS = ""
    let maxLength = 20
    match (s.size > maxLength) {
        case true => newS = s[Range<Int64>(0, maxLength - 1, 1, false, true, false)]
            .replace(decimalSeparator.toString(), ".")
            .replace(thousandsSeparator.toString(), "")
        case false => newS = s.replace(decimalSeparator.toString(), ".").replace(thousandsSeparator.toString(), "")
    }

    try {
        return Decimal(newS).toFloat64()
    } catch (e: IllegalArgumentException) {
        return 0.0
    }
}

public func stringAsInteger(s: String): Int64 {
    if (s == "") {
        return 0
    }

    try {
        return Decimal(s).toInt64()
    } catch (e: IllegalArgumentException) {
        return 0
    }
}
