# handy4cj库设计介绍

## 描述
handy4cj是一个基于仓颉的实用程序和助手，如验证器、清理器和字符串格式化程序。
本文档详细介绍handy4cj的API设计、架构设计和使用示例

## API设计

### array
提供计算差集和对称差集的功能
#### API
```cangjie
public func arrayDifferenceAtoB(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64>
public func arrayDifference(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64>
```

### complex_string
提供对字符串的格式进行检查的功能
#### API
```cangjie
public func hasNumber(s: String): Bool
public func hasNumber(s: String): Bool
public func hasNumber(s: String): Bool
public func checkStr(seq: String, minLen: UIntNative, maxLen: UIntNative, rules: UInt64): Int8
public func strContainsEmail(seq: String): Bool
```

### convert
提供字符串向 Float64、Int64 转换的功能
#### API
```cangjie
public func stringAsFloat(s: String, decimalSeparator: Rune, thousandsSeparator: Rune): Float64
public func stringAsInteger(s: String): Int64
```

### dateTime
提供日期与字符串之间的转化、验证日期格式与字符串格式有效性、计算两个日期之间差值的功能
#### API
```cangjie
public func dateTimeAsString(dt: DateTime, format: String): String
public func nowAsString(format: String): String
public func today(): (DateTime, String)
public func todayf(format: String): (DateTime, String)
public func YMD(): (Int, Int, Int)
public func stringAsDateTime(s: String, format: String): DateTime
public func checkDate(format: String, dateTime: String): Bool
public func checkDateYMD(yyyyMMdd: String): Bool
public func YMDasDateUTC(yyyyMMdd: String, utc: Bool): DateTime
public func YMDasDate(yyyyMMdd: String): DateTime 
public func elapsedTime(dtx: DateTime, dty: DateTime): (Int, Int, Int, Int, Int, Int)
public func elapsedMonths(from: DateTime, to: DateTime): Int
public func elapsedYears(from: DateTime, to: DateTime): Int
public func yearsAge(birthdate: DateTime): Int
public func monthLastDay(year: Int, month: Int): Int
public func dateReformat(dt1: String, currentFormat: String, newFormat: String): String
public func dateStrCheckAge(date: String, format: String, yearsAgeMin: Int, yearsAgeMax: Int, acceptEmpty: Bool): UInt8 
```

### email
提供遵循RFC 2822标准格式的电子邮件验证的功能
#### API
```cangjie
public func checkEmail(email: String): Bool
```

### env
提供验证环境变量变量、从文件中加载需要设置的环境变量的功能
#### API
```cangjie
public class EnvChecker {
    let varName: String
    let defaultValue: String
    let mandatory: Bool
    let debugPrint: Bool
}
public func debugLog(msg: String, debugPrint: Bool)
public func envCheck(varName: String, defaultValue: String, mandatory: Bool, debugPrint: Bool)
public func envStr(key: String, defaultValue: String): String
public func envStrs(key: String, separator: String, defaultValue: ArrayList<String>): ArrayList<String>
public func envIntNative(key: String, defaultValue: IntNative): IntNative
public func envInt64(key: String, defaultValue: Int64): Int64
public func envInts(key: String, separator: String, defaultValue: ArrayList<IntNative>): ArrayList<IntNative>
public func envFloat64(key: String, defaultValue: Float64): Float64
public func envBool(key: String, defaultValue: Bool): Bool
public func envCheckerMany(envCheckers: ArrayList<EnvChecker>)
public func envLoadFromDisk(fileName: String, mustHave: Bool, overwriteValues: Bool)
```

### filter
提供处理空白字符、提取特殊字符的功能
#### API
```cangjie
public func dedupSpaces(s: String): String
public func cleanSpaces(s: String): String
public func onlyLetters(sequence: String): String
public func onlyDigits(sequence: String): String
public func onlyLettersAndNumbers(sequence: String): String
public func removeDigits(sequeue: String): String
```

### handy
提供一些基础的验证器、处理器操作，供其他函数使用
#### API
```cangjie
public func runeHasSymbol(ru: Rune): Bool
public func stringHash(s: String): String
public func checkPhone(phone: String, acceptEmpty: Bool): Bool
public func between(n: Int64, low: Int64, high: Int64): Bool
public func tif(condition: Bool, tifThen: Any, tifElse: Any): Any
public func truncate(s: String, maxLen: Int64, trim: Bool): String
public func matchesAny(search: Any, items: Array<Any>): Bool
public func hasOnlyNumbers(sequence: String): Bool
public func hasOnlyLetters(sequence: String): Bool
public func trimLen(text: String): Int64
public func checkMinLen(value: String, minLength: Int64): Bool
public func isNumericType(x: Any): Bool
public func bit(x: Any): UInt8
public func boolean(x: Any): Bool
public func reverseString(s: String): String
public func stringReplaceAll(original: String, replacementPairs: Array<String>): String
public func positiveOrZero(n: Int64): Int64
```

### inarray
提供将任意类型整数转换为BigInt类型、通过BigInt进行跨类型检查的功能
#### API
```cangjie
public func intToBigint(i: Any): BigInt
public func inArrayIntFlex(item: ?Any, array: ?Any): Bool
public func inArray(array: ?Any, item: ?Any): Bool
```

### name
提供对人名进行验证以及一些常规操作的功能
#### API
```cangjie
public func dedupSpaces(s: String): String
public func cleanSpaces(s: String): String
public func onlyLetters(sequence: String): String
public func onlyDigits(sequence: String): String
public func onlyLettersAndNumbers(sequence: String): String
public func removeDigits(sequeue: String): String
```

### filter
提供处理空白字符、提取特殊字符的功能
#### API
```cangjie
public func checkPersonName(name: String, acceptEmpty: Bool): UInt8
public func nameFirstAndLast(name: String, transformFlags: UInt): String
public func nameFirst(name: String, transformFlags: UInt): String
public func nameInitials(name: String, transformFlags: UInt): String
```

### password
提供对密码进行合规性检查的功能
#### API
```cangjie
public func checkNewPassword(password: String, passwordConfirmation: String, minimumLength: UInt, flagComplexity: UInt8): UInt8
```

### random_numeric_string
提供随机生成数字字符串的功能
#### API
```cangjie
public func randomNumericString(forbiddenDigits: ArrayList<Int>, lengthMin: Int, lengthMax: Int): String
```

### random_string
提供根据指定格式随机生成字符串的功能
#### API
```cangjie
public func isSymbol(r: Rune): Bool
public func randomString(minLen: Int, maxLen: Int, allowUnicode: Bool, allowNumbers: Bool, allowSymbols: Bool,
    allowSpaces: Bool): String
```

### random
提供初始化随机数生成器与生成指定范围的随机数的功能
#### API
```cangjie
public func initRandom(): Random
public func randomInt(min: Int, max: Int): Int
public func randomIntArray(min: Int, max: Int, howMany: Int): ArrayList<Int>
public func randomReseed(min: Int, max: Int): Int
```

### reshape
提供使用占位符格式化字符串的功能
#### API
```cangjie
public func reshapePH(placeHolder: Rune, format: String, sequence: String): String
public func reshape(format: String, sequence: String): String
public func transformSerially(s: String, maxLen: Int, transformFlags: Array<UInt>): String
```

### transform
提供根据各种规则对字符串进行转换的功能
#### API
```cangjie
public func title(s: String): String
public func transform(s: String, maxLen: Int64, transformFlags: UInt): String

```

## 架构图

### 依赖关系

- **'handy'**
    - **功能**：提供一部分处理器和验证器的功能
    - **作用**：完成处理器和验证器的基础操作，其他使用这些基础操作的函数依赖它
- **'transform'** 
    - **功能**: 提供根据各种规则对字符串进行转换的功能
    - **作用**：完成对字符串格式化的基础功能，其他对于字符串进行格式化的函数依赖它
- **'random'**
    - **功能**：提供初始化随机数生成器与生成指定范围的随机数的功能
    - **作用**：完成随机生成的基础功能，其他用于随机生成字符串、生成随机数的函数依赖它
- **其他工具**
    - **功能**：完成相应功能，无依赖关系

### 架构图设计描述

- **'array'**: 提供计算差集和对称差集的功能
- **'complex_string'**: 提供对字符串的格式进行检查的功能  
- **'convert'**: 提供字符串向Float64、Int64转换的功能
- **'dateTime'**: 提供日期与字符串转换及日期计算功能
- **'email'**: 提供RFC 2822标准电子的邮件验证功能
- **'env'**: 提供环境变量验证操作和文件加载功能
- **'filter'**: 提供字符串空白处理和字符提取功能
- **'handy'**: 提供基础验证器和处理器功能
- **'inarray'**: 提供整型转换和跨类型检查功能
- **'name'**: 提供人名验证和格式化功能
- **'password'**: 提供密码合规性检查功能
- **'random_numeric_string'**: 提供随机数字串生成功能
- **'random_string'**: 提供格式随机字符串生成功能
- **'random'**: 提供随机数生成功能
- **'reshape'**: 提供占位符字符串格式化功能
- **'transform'**: 提供字符串规则转换功能

## 展示示例

### 示例1：计算差集和对称差集
```cangjie
import handy4cj.*
import std.collection.*

main(): Int64 {
    // 计算差集
    println(arrayDifference(ArrayList<Int64>([1, 2, 3, 4]), ArrayList<Int64>([3, 4, 5, 6])))
    // 计算对称差集
    println(arrayDifferenceAtoB(ArrayList<Int64>([1, 2, 3, 4]), ArrayList<Int64>([3, 4, 5, 6])))

    return 0
}
```
执行结果如下：
```shell
[5, 6, 1, 2]
[1, 2]
```

### 示例2：对字符串的格式进行检查
```cangjie
import handy4cj.*
import std.collection.*

main(): Int64{
    // 更多位掩码与错误信息详见feature_api.md的常量部分,此处仅为部分示例
    // 0表示无限制规则，1允许空字符串，2表示禁止空白字符，4表示禁止数字，8表示禁止字母
    println(checkStr("ЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏ АБВГДЕЖЗИЙКЛМНОП РСТУФХЦЧШЩЪЫ ЬЭЮЯ абвгдежзийкл мнопрстуфхцчшщ ъыьэюяѐёђѓєѕіїј љњћќѝўџѠѡѢѣѤѥѦѧѨѩѪѬѭѮѯ", 0, 118, 0))
    println(checkStr("", 0, 1000, 1))
    println(checkStr("two words", 0, 100, 2))
    println(checkStr("this is a number: 9", 0, 100, 4))
    println(checkStr("o123456789", 0, 100, 8))

    return 0
}
```
执行结果如下：
（0表示字符串通过验证，-5表示禁止空白字符却出现空白字符，-6表示禁止数字却出现数字，-7表示禁止字母却出现字母）
```shell
0
0
-5
-6
-7
```

### 示例3：对日期的格式转化与验证示例
```cangjie
import handy4cj.*
import std.time.*

main(): Int64 {
    // 日期与字符串之间相互转化
    println(dateTimeAsString(DateTime.of(year: 2018, month: 10, dayOfMonth: 31, hour: 1, minute: 2, second: 2, nanosecond: 651387237), "yyyyMMdd"))
    println(nowAsString("yyyyMMdd"))
    println(stringAsDateTime("2025-04-09", "yyyy-MM-dd"))
    // 验证日期是否满足相应格式
    println(checkDate("yyyyMMdd","20250409"))
    println(checkDate("yyyyMMdd", "2025-04-09"))
    // 重新格式化日期
    println(dateReformat("20250409", "yyyyMMdd", "yyyy-MM-dd"))
    // 计算两个日期之间相差的年或月
    println(elapsedMonths(DateTime.of(year: 2025, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 6, dayOfMonth: 20)))
    println(elapsedYears(DateTime.of(year: 2024, month: 4, dayOfMonth: 25), DateTime.of(year: 2025, month: 4, dayOfMonth: 25)))
    
    return 0
}
```
执行结果如下（执行的时间为北京时间2025年4月9日）
```shell
20181031
20250409
2025-04-09T00:00:00+08:00
true
false
2025-04-09
1
1
```

### 示例4：验证环境变量示例
```cangjie
import handy4cj.*
import std.fs.*
import std.os.*

main(): Int64 {
    // 验证环境变量
    setEnv("test1", "testEnv")
    println(envCheck("test1", "testEnv", true, true) == "")
    println(envStr("test1", "defaultValue"))
    setEnv("test2", "111")
    println(envInt64("test2", 0))
    println(envBool("test2", false))
    println(envFloat64("test2", 0.0))
    return 0
}
```
执行结果如下：
```shell
true
testEnv
111
false
111.000000
```

### 示例5：随机数、随机数组、随机字符串、随机数字字符串生成示例
```cangjie
import handy4cj.*
import std.collection.*

main(): Int64 {
    println(randomInt(2, 6))
    println(randomIntArray(2, 6, 3))
    println(randomNumericString(ArrayList<Int64>(1,2,3), 2, 6))
    println(randomString(2, 5, false, true, true, true))
    return 0
}
```
第一次执行结果如下：
```shell
5
[3, 5, 2]
00
j4
```
第二次执行结果如下：
```shell
4
[5, 2, 4]
6670
Q?
```

### 示例6：占位符字符串格式化示例
```cangjie
import handy4cj.*

main(): Int64 {
    println(reshape("###-###-###", "123456789"))
    println(reshape("##*#-#=##", "abcdef"))
    println(reshapePH(r'@', "@@@_@@@_@@@", "123456789"))
    return 0
}
```
执行结果如下：
```shell
123-456-789
ab*c-d=ef
123_456_789
```

### 示例7：字符串转化示例
```cangjie
import handy4cj.*

main(): Int64 {
    // 根据给定的参数对字符串进行格式化，位掩码查看feature_api.md的常量部分
    println(transform("cangjie", 4, 1))
    println(transformSerially("cangjie", 4, 1, 2))

    // 只保留数字、字母、数字和字母以及移除数字字符串
    println(onlyDigits("cangjie"))
    println(onlyLetters("cangjie"))
    println(onlyLettersAndNumbers("cangjie"))
    println(removeDigits("abc123"))
    
    // 检查字符中是否是常用的特殊符号
    println(runeHasSymbol(r'!'))
    
    // 生成字符串的 SHA256 哈希值
    println(stringHash("abc"))
    
    // 限制字符串长度
    println(truncate("cangjie", 4, true))
    
    // 匹配
    println(matchesAny(1, 1, 2, 3))
    
    // 字符串只包含数字或字母
    println(hasOnlyLetters("cangjie"))
    println(hasOnlyNumbers("12345789"))
    
    // 查看字符串去除两边空白字符后的长度
    println(trimLen("cangjie"))
    
    // 检查最小长度
    println(checkMinLen("cangjie", 5))
    
    //替换字符串
    println(stringReplaceAll("cangjie", "cang", "仓", "jie", "颉"))
    
    // 反转字符串
    println(reverseString("仓颉"))

    return 0
}
```
执行结果如下：
```shell
cang
cang

cangjie
cangjie
abc
true
ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
cang
true
true
true
7
true
仓颉
颉仓
```

### 示例8：名字和密码相关验证和提取操作示例
```cangjie
import handy4cj.*

main(): Int64 {
    // 名字和密码的验证操作, 位掩码和错误信息查看feature_api.md的常量部分
    println(checkPersonName("cangjie", true))
    println(checkNewPassword("cangjie123", "cangjie123", 1, 1))
    // 对名字的第一个单词，最后一个单词，首字母的提取操作
    println(nameFirst("cang jie", 0))
    println(nameFirstAndLast("cang jie", 0))
    println(nameInitials("cang jie", 0))

    return 0
}
```
执行结果如下：
```shell
2
0
cang
cang jie
c j
```