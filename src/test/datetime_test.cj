package handy4cj.test

import handy4cj.*
import std.collection.*
import std.time.*
import std.unittest.*
import std.unittest.testmacro.*

public class TestDateStrCheckAgeDemo {
    let date: String
    let format: String
    let yearsAgeMin: Int
    let yearsAgeMax: Int
    let acceptEmpty: Bool
    let expectedOutput: UInt8
    public init(date: String, format: String, yearsAgeMin: Int, yearsAgeMax: Int, acceptEmpty: Bool,
        expectedOutput: UInt8) {
        this.date = date
        this.format = format
        this.yearsAgeMin = yearsAgeMin
        this.yearsAgeMax = yearsAgeMax
        this.acceptEmpty = acceptEmpty
        this.expectedOutput = expectedOutput
    }
}

public class TestDateStrCheckRangeDemo {
    let date: String
    let format: String
    let dateMin: DateTime
    let dateMax: DateTime
    let acceptEmpty: Bool
    let expectedOutput: UInt8
    public init(date: String, format: String, dateMin: DateTime, dateMax: DateTime, acceptEmpty: Bool,
        expectedOutput: UInt8) {
        this.date = date
        this.format = format
        this.dateMin = dateMin
        this.dateMax = dateMax
        this.acceptEmpty = acceptEmpty
        this.expectedOutput = expectedOutput
    }
}

@Test
public class TestDateTime {
    @TestCase
    public func test_dateTimeAsString() {
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "yyyyMMdd"), "20181031")
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "yyyy-MM-dd"), "2018-10-31")
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "dd/MM/YYYY"), "31/10/2018")
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "yyyy-MM-dd hh:mm:ss OO"), "2018-10-31 01:02:02 +08:00")
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "yyyy-MM-dd hh:mm:ss"), "2018-10-31 01:02:02")
        @Assert(dateTimeAsString(
                DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237),
                "yyyy-MM-dd hh:mm:ss.SSS"), "2018-10-31 01:02:02.651387237")
    }

    @TestCase
    public func test_nowAsString() {
        let t = DateTime.now()
        @Assert(nowAsString("yyyy-MM-dd hh:mm:ss OO"), t.toString("yyyy-MM-dd hh:mm:ss OO"))
    }

    @TestCase
    public func test_today() {
        let t = DateTime.now()
        @Assert(today()[0], DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth))
        @Assert(today()[1], DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth).toString("yyyy-MM-dd"))
        @Assert(today()[1] != t.toString("yyyy-MM-dd HH-mm-ss"))
    }

    @TestCase
    public func test_todayf() {
        let t = DateTime.now()
        @Assert(todayf("yyyy-MM-dd")[0], DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth))
        @Assert(todayf("yyyy-MM-dd")[1], DateTime.of(year: t.year, month: t.month, dayOfMonth: t.dayOfMonth).toString("yyyy-MM-dd"))
        @Assert(todayf("yyyy-MM-dd")[1] != t.toString("yyyy-MM-dd HH-mm-ss"))
    }

    @TestCase
    public func test_YMD() {
        let t = DateTime.now()
        @Assert(YMD()[0], t.year)
        @Assert(YMD()[1], t.monthValue)
        @Assert(YMD()[2], t.dayOfMonth)
    }

    @TestCase
    public func test_stringAsDateTime() {
        @Assert(stringAsDateTime("2025-04-02", "yyyy-MM-dd"), DateTime.of(year: 2025, month: 4, dayOfMonth: 2))
        @Assert(stringAsDateTime("02/04/2025", "dd/MM/yyyy"), DateTime.of(year: 2025, month: 4, dayOfMonth: 2))
        @Assert(stringAsDateTime("2025-04-02 21:20:20", "yyyy-MM-dd HH:mm:ss"), DateTime.of(year: 2025, month: 4, dayOfMonth: 2,
                hour: 21, minute: 20, second: 20))
        @AssertThrows[TimeParseException](stringAsDateTime("20250402", "yyyy-MM-dd"))
        @AssertThrows[TimeParseException](stringAsDateTime("", "yyyyMMdd"))
    }

    @TestCase
    public func test_checkDate() {
        @Assert(checkDate("yyyyMMdd", "20250402"))
        @Assert(checkDate("yyyy/MM/dd", "2025/04/02"))
        @Assert(checkDate("yyyy-MM-dd HH:mm:ss OO", "2025-04-02 21:30:50 +08:00"))
        @Assert(checkDate("", "20250402"), false)
        @Assert(checkDate("yyyyMMdd",""), false)
        @Assert(checkDate("yyyyMMdd", "2025-04-02"),false)
        @Assert(checkDate("yyyy-MM-dd HH:mm:ss OO", "2025-04-02 21:30:50"), false)
        @Assert(checkDate("yyyy-MM-dd hh:mm:ss", "2025-04-02 21:30:50"), false)
    }

    @TestCase
    public func test_checkDateYMD() {
        @Assert(checkDateYMD("20250402"))
        @Assert(checkDateYMD("99999999"), false)
        @Assert(checkDateYMD("2025-04-02"), false)
        @Assert(checkDateYMD("20250402 21:30:00"), false)
    }

    @TestCase
    public func test_YMDasDateUTC() {
        @Assert(YMDasDateUTC("2025-04-02T21:50:00+08:00", false), DateTime.of(year: 2025, month: 4, dayOfMonth: 2, hour: 21, minute: 50, second: 0))
        @Assert(YMDasDateUTC("2025-04-02T21:50:00+08:00", true), DateTime.of(year: 2025, month: 4, dayOfMonth: 2, timeZone: TimeZone.UTC))
        @AssertThrows[TimeParseException](YMDasDateUTC("2025-04-0221:50:00+08:00", true))
    }

    @TestCase
    public func test_YMDasDate() {
        @Assert(YMDasDate("2025-04-02T21:50:00+08:00"), DateTime.of(year: 2025, month: 4, dayOfMonth: 2, hour: 21, minute: 50, second: 0))
        @AssertThrows[TimeParseException](YMDasDate("2025-04-0221:50:00+08:00"))
    }

    @TestCase
    public func test_elapsedTime() {
        @Assert(elapsedTime(DateTime.now(), DateTime.now()) == (0, 0, 0, 0, 0, 0))
        @Assert(elapsedTime(DateTime.of(year: 2024, month: 12, dayOfMonth: 31, hour: 23, minute: 59, second: 59),
            DateTime.of(year: 2025, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 1)) == (0, 0, 0, 0, 0, 2))
        @Assert(elapsedTime(DateTime.of(year: 2024, month: 12, dayOfMonth: 31, hour: 23, minute: 59, second: 59),
            DateTime.of(year: 2025, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 1)) == (0, 0, 0, 0, 0, 2))
        @Assert(elapsedTime(DateTime.of(year: 2024, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 1),
            DateTime.of(year: 2025, month: 1, dayOfMonth: 1, hour: 0, minute: 0, second: 1)) == (1, 0, 0, 0, 0, 0))
        @Assert(elapsedTime(DateTime.of(year: 2024, month: 12, dayOfMonth: 31, hour: 23, minute: 0, second: 0),
            DateTime.of(year: 2025, month: 1, dayOfMonth: 1, hour: 1, minute: 30, second: 0)) == (0, 0, 0, 2, 30, 0))
        @Assert(elapsedTime(DateTime.of(year: 2024, month: 4, dayOfMonth: 5, hour: 13, minute: 40, second: 50),
            DateTime.of(year: 2025, month: 5, dayOfMonth: 6, hour: 14, minute: 41, second: 51)) == (1, 1, 1, 1, 1, 1))
        @Assert(elapsedTime(DateTime.of(year: 2025, month: 5, dayOfMonth: 6, hour: 14, minute: 41, second: 51),
            DateTime.of(year: 2024, month: 4, dayOfMonth: 5, hour: 13, minute: 40, second: 50)) == (1, 1, 1, 1, 1, 1))
    }

    @TestCase
    public func test_elapsedMonths() {
        @Assert(elapsedMonths(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 4, dayOfMonth: 20)), 0)
        @Assert(elapsedMonths(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2024, month: 4, dayOfMonth: 20)), 0)
        @Assert(elapsedMonths(DateTime.of(year: 2024, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 4, dayOfMonth: 20)), 11)
        @Assert(elapsedMonths(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 6, dayOfMonth: 20)), 1)
        @Assert(elapsedMonths(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 6, dayOfMonth: 26)), 2)
    }

    @TestCase
    public func test_elapsedYears() {
        @Assert(elapsedYears(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 12, dayOfMonth: 20)), 0)
        @Assert(elapsedYears(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2024, month: 1, dayOfMonth: 20)), 0)
        @Assert(elapsedYears(DateTime.of(year: 2024, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 4, dayOfMonth: 20)), 0)
        @Assert(elapsedYears(DateTime.of(year: 2024, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 4, dayOfMonth: 25)), 1)
        @Assert(elapsedYears(DateTime.of(year: 2020, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 6, dayOfMonth: 26)), 5)
    }

    @TestCase
    public func test_yearsAge() {
        let today = DateTime.now()
        let yesterday = DateTime.now()
        let lessThanOneYear = DateTime.now().addDays(-11)
        let oneYearAgo = DateTime.now().addYears(-1)
        let almostTwoYears = DateTime.now().addYears(-1).addMonths(-11).addDays(-15)
        let twoYears = DateTime.now().addYears(-2)
        let moreThanTwoYears = DateTime.now().addYears(-2).addMonths(-11)
        let tenYears = DateTime.now().addYears(-10)
        let hundredYears = DateTime.now().addYears(-100)
        let bornOnFuture = DateTime.now().addYears(1)
        @Assert(yearsAge(today), 0)
        @Assert(yearsAge(yesterday), 0)
        @Assert(yearsAge(lessThanOneYear), 0)
        @Assert(yearsAge(oneYearAgo), 1)
        @Assert(yearsAge(almostTwoYears), 1)
        @Assert(yearsAge(twoYears), 2)
        @Assert(yearsAge(moreThanTwoYears), 2)
        @Assert(yearsAge(tenYears), 10)
        @Assert(yearsAge(hundredYears), 100)
        @Assert(yearsAge(bornOnFuture), 0)
    }

    @TestCase
    public func test_monthLastDay() {
        @Assert(monthLastDay(-1, 6), 0)
        @Assert(monthLastDay(0, 6), 30)
        @Assert(monthLastDay(0, 2), 29)
        @Assert(monthLastDay(2019, -6), 0)
        @Assert(monthLastDay(2019, 0), 0)
        @Assert(monthLastDay(2019, 13), 0)
        @Assert(monthLastDay(2019, 1), 31)
        @Assert(monthLastDay(2019, 2), 28)
        @Assert(monthLastDay(2020, 2), 29)
        @Assert(monthLastDay(2020, 3), 31)
        @Assert(monthLastDay(2020, 4), 30)
        @Assert(monthLastDay(2020, 5), 31)
        @Assert(monthLastDay(2020, 6), 30)
        @Assert(monthLastDay(2020, 7), 31)
        @Assert(monthLastDay(2020, 8), 31)
        @Assert(monthLastDay(2020, 9), 30)
        @Assert(monthLastDay(2020, 10), 31)
        @Assert(monthLastDay(2020, 11), 30)
        @Assert(monthLastDay(2020, 12), 31)
    }

    @TestCase
    public func test_dateReFormat() {
        @Assert(dateReformat("20250405", "yyyyMMdd", "yyyy-MM-dd"), "2025-04-05")
        @Assert(dateReformat("2025-04-05 15:10:00", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd hh:mm:ss"), "2025-04-05 03:10:00")
        @Assert(dateReformat("", "yyyyMMdd", "yyyy-MM-dd"), "")
        @Assert(dateReformat("20250405", "", "yyyy-MM-dd"), "")
        @Assert(dateReformat("20250405", "yyyyMMdd", ""), "")
        @Assert(dateReformat(DateTime.UnixEpoch.toString(),"yyyyMMdd","yyyy-MM-dd"), "")
    }

    @TestCase
    public func test_dateStrCheckAge() {
        let testList = Array<TestDateStrCheckAgeDemo>(
            [
                TestDateStrCheckAgeDemo("2000-04-05", "yyyy-MM-dd", 20, 30, false, 0),
                TestDateStrCheckAgeDemo("1990-04-05", "yyyy-MM-dd", 20, 30, false, 2),
                TestDateStrCheckAgeDemo(DateTime.UnixEpoch.toString(), "yyyy-MM-dd", 20, 30, false, 1),
                TestDateStrCheckAgeDemo("", "yyyy-MM-dd", 20, 30, false, 3),
                TestDateStrCheckAgeDemo("", "yyyy-MM-dd", 20, 30, true, 0),
                TestDateStrCheckAgeDemo("1995-04-05", "yyyy-MM-dd", 20, 30, true, 0)
            ]
        )
        testList |>
            forEach<TestDateStrCheckAgeDemo> {
            i => @Expect(dateStrCheckAge(i.date, i.format, i.yearsAgeMin, i.yearsAgeMax, i.acceptEmpty), i.expectedOutput)
        }
    }

    @TestCase
    public func test_dateStrCheckRange() {
        let testList = Array<TestDateStrCheckRangeDemo>(
            [
                TestDateStrCheckRangeDemo("2020-04-05", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), false, 0),
                TestDateStrCheckRangeDemo("2000-04-05", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), false, 2),
                TestDateStrCheckRangeDemo("2026-04-05", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), false, 2),
                TestDateStrCheckRangeDemo("", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), false, 3),
                TestDateStrCheckRangeDemo("", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), true, 0),
                TestDateStrCheckRangeDemo("invalid-date", "yyyy-MM-dd", DateTime.of(year: 2010, month: 1, dayOfMonth: 1),
                    DateTime.of(year: 2025, month: 1, dayOfMonth: 1), false, 1)
            ]
        )
        testList |>
            forEach<TestDateStrCheckRangeDemo> {
            i => @Expect(dateStrCheckRange(i.date, i.format, i.dateMin, i.dateMax, i.acceptEmpty), i.expectedOutput)
        }
    }
}
