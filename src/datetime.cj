package handy4cj

import std.time.*

// dateTimeAsString 根据格式化指令将 DateTime 变量格式化为字符串
public func dateTimeAsString(dt: DateTime, format: String): String {
    return dt.format(format)
}

// nowAsString 根据格式化指令将 DateTime.now() 格式化为字符串
public func nowAsString(format: String): String {
    return DateTime.now().format(format)
}

// today 返回今天的日期，时间为零小时、零分钟、零秒等。
// 返回一个时间和一个 yyyy-MM-dd 格式的字符串
public func today(): (DateTime, String) {
    let t = DateTime.now()
    let result = DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth)
    return (result, result.format("yyyy-MM-dd"))
}

// todayf 返回今天的日期，时间为零小时、零分钟、零秒等。
// 返回一个时间和一个自定义格式的字符串
public func todayf(format: String): (DateTime, String) {
    let t = DateTime.now()
    return (DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth), t.format(format))
}

// YMD 返回今天的日期，并将其拆分为年、月和日
public func YMD(): (Int, Int, Int) {
    let t = DateTime.now()
    return (t.year, t.month.toInteger(), t.dayOfMonth)
}

// stringAsDateTime 根据格式化指令将 DateTime 变量格式化为字符串
public func stringAsDateTime(s: String, format: String): DateTime {
    return DateTime.parse(s, format)
}

// checkDate 使用给定的格式验证日期
public func checkDate(format: String, dateTime: String): Bool {
    if (format == "") {
        return false
    }
    try {
        DateTime.parse(dateTime, format)
        return true
    } catch (e: TimeParseException) {
        return false
    }
}

// checkDateYMD 如果给定的输入是有效的 yyyyMMdd 格式日期，返回 true
public func checkDateYMD(yyyyMMdd: String): Bool {
    return checkDate("yyyyMMdd", yyyyMMdd)
}

// YMDasDateUTC 将给定的 yyyyMMdd 格式输入转换为有效的 UTC 时间
public func YMDasDateUTC(yyyyMMdd: String, utc: Bool): DateTime {
    try {
        var dateTime = DateTime.parse(yyyyMMdd)
        return match (utc) {
            case false => dateTime
            case true => DateTime.of(year: dateTime.year, month: dateTime.month, dayOfMonth: dateTime.dayOfMonth,
                timeZone: TimeZone.UTC)
        }
    } catch (e: TimeParseException) {
        throw TimeParseException()
    }
}

// YMDasDate 将给定的 yyyyMMdd 格式输入转换为有效的时间
public func YMDasDate(yyyyMMdd: String): DateTime {
    return YMDasDateUTC(yyyyMMdd, false)
}

// elapsedTime 返回两个日期之间的差值，以年、月、日、小时、分钟和秒为单位
// 感谢 icza@https://stackoverflow.com/a/36531443/1301019
public func elapsedTime(dtx: DateTime, dty: DateTime): (Int, Int, Int, Int, Int, Int) {
    var dateTimeX = dtx
    var dateTimeY = dty
    if (dtx.zone != dty.zone) {
        dateTimeY = dateTimeY.inTimeZone(dtx.zone)
    }
    if (dateTimeX == dateTimeY) {
        return (0, 0, 0, 0, 0, 0)
    }
    if (dateTimeX < dateTimeY) {
        dateTimeX = dateTimeY
        dateTimeY = dtx
    }
    var year = dateTimeX.year - dateTimeY.year
    var month = dateTimeX.month.toInteger() - dateTimeY.month.toInteger()
    var day = dateTimeX.dayOfMonth - dateTimeY.dayOfMonth
    var hour = dateTimeX.hour - dateTimeY.hour
    var minute = dateTimeX.minute - dateTimeY.minute
    var second = dateTimeX.second - dateTimeY.second

    if (second < 0) {
        second += 60
        minute--
    }
    if (minute < 0) {
        minute += 60
        hour--
    }
    if (hour < 0) {
        hour += 24
        day--
    }
    if (day < 0) {
        let t = DateTime.of(year: dateTimeX.year, month: dateTimeX.month, dayOfMonth: dateTimeX.dayOfMonth)
        day += 32 - t.dayOfMonth
        month--
    }
    if (month < 0) {
        month += 12
        year--
    }
    return (year, month, day, hour, minute, second)
}

// elapsedMonths 返回两个给定日期之间的经过月数
public func elapsedMonths(from: DateTime, to: DateTime): Int {
    if (to < from || (from.year == to.year && from.month == to.month)) {
        return 0
    }
    return elapsedTime(from, to)[1]
}

// elapsedYears 返回两个给定日期之间的经过年数
public func elapsedYears(from: DateTime, to: DateTime): Int {
    if (to < from || from.year == to.year) {
        return 0
    }
    return elapsedTime(from, to)[0]
}

// yearsAge 返回自给定日期以来已经过去的年数
public func yearsAge(birthdate: DateTime): Int {
    return elapsedYears(birthdate, DateTime.now())
}

// monthLastDay 返回一个月的最后一天，考虑到闰年对二月的影响
// 月份是从 1 开始的，因此 1 月 = 1
// 如果月份不是 2（即二月），则年份可以忽略
// 如果月份是二月，年份必须有效
public func monthLastDay(year: Int, month: Int): Int {
    if (month < 1 || month > 12 || year < 0) {
        return 0
    }
    let lastDayArrayZeroBased = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if (month != 2) {
        return lastDayArrayZeroBased[month - 1]
    }

    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        return 29
    }
    return 28
}

// dateReformat 将一个日期字符串从给定的 currentFormat 格式转换为新的 newFormat 格式
public func dateReformat(dt1: String, currentFormat: String, newFormat: String): String {
    try {
        let dx = stringAsDateTime(dt1, currentFormat)
        return match (dx == DateTime.UnixEpoch) {
            case false => dateTimeAsString(dx, newFormat)
            case true => ""
        }
    } catch (e: TimeParseException) {
        return ""
    }
}

// dateStrCheckOk 表示结果是正确的
const dateStrCheckOk: UInt8 = 0
// dateStrCheckErrInvalid 表示日期无效
const dateStrCheckErrInvalid: UInt8 = 1
// dateStrCheckErrOutOfRange 表示日期超出了支持的范围
const dateStrCheckErrOutOfRange: UInt8 = 2
// dateStrCheckErrEmpty 表示日期字符串为空
const dateStrCheckErrEmpty: UInt8 = 3

// dateStrCheckAge 检查一个日期字符串，考虑最小年龄和最大年龄
public func dateStrCheckAge(date: String, format: String, yearsAgeMin: Int, yearsAgeMax: Int, acceptEmpty: Bool): UInt8 {
    if (date == "") {
        return match (acceptEmpty) {
            case true => dateStrCheckOk
            case false => dateStrCheckErrEmpty
        }
    }

    try {
        let dt = stringAsDateTime(date, format)
        if (dt == DateTime.UnixEpoch) {
            return dateStrCheckErrInvalid
        }
        if (!between(yearsAge(dt), yearsAgeMin, yearsAgeMax)) {
            return dateStrCheckErrOutOfRange
        }
    } catch (e: TimeParseException) {
        return dateStrCheckErrInvalid
    }

    return dateStrCheckOk
}

// dateStrCheckAge 检查一个日期字符串是否符合最小和最大年龄要求
public func dateStrCheckRange(date: String, format: String, dateMin: DateTime, dateMax: DateTime, acceptEmpty: Bool): UInt8 {
    if (date == "") {
        return match (acceptEmpty) {
            case true => dateStrCheckOk
            case false => dateStrCheckErrEmpty
        }
    }

    try {
        let dt = stringAsDateTime(date, format)
        if (dt == DateTime.UnixEpoch) {
            return dateStrCheckErrInvalid
        }
        if ((dateMin != DateTime.UnixEpoch && dt < dateMin) || (dateMax != DateTime.UnixEpoch && dt > dateMax)) {
            return dateStrCheckErrOutOfRange
        }
    } catch (e: TimeParseException) {
        return dateStrCheckErrInvalid
    }
    return dateStrCheckOk
}
