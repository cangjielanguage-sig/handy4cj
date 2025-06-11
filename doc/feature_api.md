# handy4cj 库

## 介绍

handy4cj是一个基于仓颉的实用程序和助手，如验证器、清理器和字符串格式化程序。

## 常量
此部分列出的常量用于表示位掩码和相关错误信息
```cangjie
// CheckStrAllowEmpty 允许空字符串 ""
const checkStrAllowEmpty: UInt64 = 1

// CheckStrDenySpaces 禁止空格、制表符、换行符和回车符
const checkStrDenySpaces: UInt64 = 2

// CheckStrDenyNumbers 禁止数字
const checkStrDenyNumbers: UInt64 = 4

// CheckStrDenyLetters 禁止字母
const checkStrDenyLetters: UInt64 = 8

// CheckStrDenySymbols 禁止符号。如果它不是数字、字母或空格，就认为是符号
const checkStrDenySymbols: UInt64 = 16

// CheckStrDenyMoreThanOneWord 禁止多个单词
const checkStrDenyMoreThanOneWord: UInt64 = 32

// CheckStrDenyUpperCase 禁止大写字母
const checkStrDenyUpperCase: UInt64 = 64

// CheckStrDenyLowercase 禁止小写字母
const checkStrDenyLowerCase: UInt64 = 128

// CheckStrDenyUnicode 禁止非 ASCII 字符
const checkStrDenyUnicode: UInt64 = 256

// CheckStrRequireNumbers 要求字符串中至少包含 1 个数字
const checkStrRequireNumbers: UInt64 = 512

// CheckStrRequireLetters 要求字符串中至少包含 1 个字母
const checkStrRequireLetters: UInt64 = 1024

// CheckStrRequireSymbols 要求字符串中至少包含 1 个符号。如果它不是数字、字母或空格，就认为是符号
const checkStrRequireSymbols: UInt64 = 2048

// CheckStrRequireMoreThanOneWord 要求字符串中至少包含 2 个单词
const checkStrRequireMoreThanOneWord: UInt64 = 4096

// CheckStrRequireUpperCase 要求字符串中至少包含 1 个大写字母
const checkStrRequireUpperCase: UInt64 = 8192

// CheckStrRequireLowercase 要求字符串中至少包含 1 个小写字母
const checkStrRequireLowercase: UInt64 = 16384

// CheckStrOk 意味着“正常”
const checkStrOk: Int8 = 0

// CheckStrEmptyDenied 字符串为空时返回此值
const checkStrEmptyDenied: Int8 = -1

// CheckStrTooShort 字符串太短时返回此值
const checkStrTooShort: Int8 = -2

// CheckStrTooLong 字符串太长时返回此值
const checkStrTooLong: Int8 = -4

// CheckStrSpaceDenied 禁止空格时返回此值
const checkStrSpaceDenied: Int8 = -5

// CheckStrNumbersDenied 禁止数字时返回此值
const checkStrNumbersDenied: Int8 = -6

// CheckStrLettersDenied 禁止字母时返回此值
const checkStrLettersDenied: Int8 = -7

// CheckStrSymbolsDenied 禁止符号时返回此值
const checkStrSymbolsDenied: Int8 = -8

// CheckStrMoreThanOneWordDenied 禁止多个单词时返回此值
const checkStrMoreThanOneWordDenied: Int8 = -9

// CheckStrUpperCaseDenied 禁止大写字母时返回此值
const checkStrUpperCaseDenied: Int8 = -10

// CheckStrLowercaseDenied 禁止小写字母时返回此值
const checkStrLowerCaseDenied: Int8 = -11

// CheckStrUnicodeDenied 禁止非 ASCII 字符时返回此值
const checkStrUnicodeDenied: Int8 = -12

// CheckStrNumbersNotFound 没有找到数字时返回此值
const checkStrNumbersNotFound: Int8 = -13

// CheckStrLettersNotFound 没有找到字母时返回此值
const checkStrLettersNotFound: Int8 = -14

// CheckStrSymbolsNotFound 没有找到符号时返回此值
const checkStrSymbolsNotFound: Int8 = -15

// CheckStrMoreThanOneWordNotFound 没有找到多个单词时返回此值
const checkStrMoreThanOneWordNotFound: Int8 = -16

// CheckStrUpperCaseNotFound 没有找到大写字母时返回此值
const checkStrUpperCaseNotFound: Int8 = -17

// CheckStrLowercaseNotFound 没有找到小写字母时返回此值
const checkStrLowercaseNotFound: Int8 = -18

// dateStrCheckOk 表示结果是正确的
const dateStrCheckOk: UInt8 = 0

// dateStrCheckErrInvalid 表示日期无效
const dateStrCheckErrInvalid: UInt8 = 1

// dateStrCheckErrOutOfRange 表示日期超出了支持的范围
const dateStrCheckErrOutOfRange: UInt8 = 2

// dateStrCheckErrEmpty 表示日期字符串为空
const dateStrCheckErrEmpty: UInt8 = 3

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
```


## 函数接口

### array

提供计算差集和对称差集的功能

```cangjie
/*
 * 计算a与b的差集(a - b)
 * 即返回所有在a中出现但不在b中出现的元素
 * 参数 a - 第一个整数数组
 * 参数 b - 第二个整数数组
 * 返回值 - 差集结果数组
 */
public func arrayDifferenceAtoB(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64>

/*
 * 计算a与b的对称差集(a Δ b)
 * 即返回所有在a或b中出现但不同时在两者中出现的元素
 * 参数 a - 第一个整数数组
 * 参数 b - 第二个整数数组
 * 返回值 - 对称差集结果数组
 */
public func arrayDifference(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64>
```
### complex_string

提供对字符串的格式进行检查的功能
```cangjie
/*
 * 判断字符串中是否有数字字符
 * 参数 s - 需要检查的字符串
 * 返回值 - 如果包含数字字符返回true，否则返回false
 */
public func hasNumber(s: String): Bool

/*
 * 判断字符串中是否有字母字符
 * 参数 s - 需要检查的字符串
 * 返回值 - 如果包含字母字符返回true，否则返回false
 */
public func hasNumber(s: String): Bool

/*
 * 判断字符串中是否有非字母数字空格字符
 * 参数 s - 需要检查的字符串
 * 返回值 - 如果包含符号字符返回true，否则返回false
 */
public func hasNumber(s: String): Bool

/*
 * 检查字符串是否符合指定规则
 * 参数 seq - 需要检查的字符串
 * 参数 minLen - 字符串最小长度要求
 * 参数 maxLen - 字符串最大长度要求(0表示不限制)
 * 参数 rules - 检查规则的位掩码组合
 * 返回值 - 检查结果，返回checkStrOk表示通过，其他值表示具体错误类型
 * 具体位掩码与错误类型信息请查看常量部分
 */
public func checkStr(seq: String, minLen: UIntNative, maxLen: UIntNative, rules: UInt64): Int8

/*
 * 判断字符串中是否包含电子邮件格式
 * 参数 seq - 需要检查的字符串
 * 返回值 - 如果包含电子邮件格式返回true，否则返回false
 */
public func strContainsEmail(seq: String): Bool
```

### convert

提供字符串向 Float64、Int64 转换的功能

```cangjie
/*
 * 将字符串转换为 Float64 类型的数据，考虑到千位分隔符和小数分隔符
 * 参数s - 需要转换的字符串
 * 参数decimalSeparator - 小数分隔符
 * 参数thousandsSeparator - 千位分隔符
 * 返回值 - 如果转换成功，返回转换后的浮动数字；如果失败，返回0.0
 */
public func stringAsFloat(s: String, decimalSeparator: Rune, thousandsSeparator: Rune): Float64

/*
 * 将字符串转换 Int64 类型的数据
 * 参数s - 需要转换的字符串
 * 返回值 - 如果转换成功，返回转换后的整数；如果失败，返回0
 */
public func stringAsInteger(s: String): Int64
```

### dateTime

提供日期与字符串之间的转化、验证日期格式与字符串格式有效性、计算两个日期之间差值的功能

```cangjie
/*
 * 根据格式化指令将 DateTime 变量格式化为字符串
 * 参数dt - 需要格式化的 DateTime 变量
 * 参数format - 格式化的字符串指令
 * 返回值 - 格式化后的字符串
 */
public func dateTimeAsString(dt: DateTime, format: String): String

/*
 * 根据格式化指令将当前时间 DateTime.now() 格式化为字符串
 * 参数format - 格式化的字符串指令
 * 返回值 - 格式化后的当前时间字符串
 */
public func nowAsString(format: String): String

/*
 * 返回今天的日期，时间为零小时、零分钟、零秒等
 * 返回值 - 一个元组，包含零时的 DateTime 和 yyyy-MM-dd 格式的日期字符串
 */
public func today(): (DateTime, String)

/*
 * 返回今天的日期，时间为零小时、零分钟、零秒等，并使用自定义格式
 * 参数format - 自定义的日期格式
 * 返回值 - 一个元组，包含零时的 DateTime 和自定义格式的日期字符串
 */
public func todayf(format: String): (DateTime, String)

/*
 * 返回今天的日期，并将其拆分为年、月、日
 * 返回值 - 一个元组，包含年、月、日
 */
public func YMD(): (Int, Int, Int)

/*
 * 根据格式化指令将字符串转换为 DateTime 变量
 * 参数s - 需要转换的日期字符串
 * 参数format - 格式化的字符串指令
 * 返回值 - 转换后的 DateTime 对象
 */
public func stringAsDateTime(s: String, format: String): DateTime

/*
 * 使用给定的格式验证日期字符串的有效性
 * 参数format - 格式化指令
 * 参数dateTime - 需要验证的日期字符串
 * 返回值 - 如果日期字符串有效，返回 true，否则返回 false
 */
public func checkDate(format: String, dateTime: String): Bool

/*
 * 验证给定的日期字符串是否为有效的 yyyyMMdd 格式
 * 参数yyyyMMdd - 需要验证的日期字符串
 * 返回值 - 如果日期字符串有效，返回 true，否则返回 false
 */
public func checkDateYMD(yyyyMMdd: String): Bool

/*
 * 将给定的 yyyyMMdd 格式输入转换为有效的 UTC 时间
 * 参数yyyyMMdd - 需要转换的日期字符串
 * 参数utc - 是否将时间转换为 UTC 时间
 * 返回值 - 转换后的 DateTime 对象（UTC 时间或本地时间）
 */
public func YMDasDateUTC(yyyyMMdd: String, utc: Bool): DateTime

/*
 * 将给定的 yyyyMMdd 格式输入转换为有效的本地时间
 * 参数yyyyMMdd - 需要转换的日期字符串
 * 返回值 - 转换后的 DateTime 对象（本地时间）
 */
public func YMDasDate(yyyyMMdd: String): DateTime 

/*
 * elapsedTime 返回两个日期之间的差值，以年、月、日、小时、分钟和秒为单位
 * 参数dtx - 第一个日期
 * 参数dty - 第二个日期
 * 返回值 - 返回一个元组，包含年、月、日、小时、分钟和秒的差值
 * 参考 icza@https://stackoverflow.com/a/36531443/1301019
 */
public func elapsedTime(dtx: DateTime, dty: DateTime): (Int, Int, Int, Int, Int, Int)

/*
 * elapsedMonths 返回两个给定日期之间的经过月数
 * 参数from - 第一个日期
 * 参数to - 第二个日期
 * 返回值 - 返回两个日期之间经过的月数
 */
public func elapsedMonths(from: DateTime, to: DateTime): Int

/*
 * elapsedYears 返回两个给定日期之间的经过年数
 * 参数from - 第一个日期
 * 参数to - 第二个日期
 * 返回值 - 返回两个日期之间经过的年数
 */
public func elapsedYears(from: DateTime, to: DateTime): Int

/*
 * yearsAge 返回自给定日期以来已经过去的年数
 * 参数birthdate - 出生日期
 * 返回值 - 返回从出生日期到当前时间经过的年数
 */
public func yearsAge(birthdate: DateTime): Int

/*
 * monthLastDay 返回一个月的最后一天，考虑到闰年对二月的影响
 * 参数year - 年份
 * 参数month - 月份（从1开始，1代表1月）
 * 返回值 - 返回该月份的最后一天
 * 如果月份是2月，年份必须有效来判断是否为闰年
 */
public func monthLastDay(year: Int, month: Int): Int

/*
 * dateReformat 将一个日期字符串从给定的 currentFormat 格式转换为新的 newFormat 格式
 * 参数dt1 - 需要转换的日期字符串
 * 参数currentFormat - 当前日期字符串的格式
 * 参数newFormat - 目标格式
 * 返回值 - 返回转换后的日期字符串
 * 如果解析失败则返回空字符串
 */
public func dateReformat(dt1: String, currentFormat: String, newFormat: String): String

/*
 * dateStrCheckAge 检查一个日期字符串，考虑最小年龄和最大年龄
 * 参数date - 需要检查的日期字符串
 * 参数format - 日期字符串的格式
 * 参数yearsAgeMin - 最小年龄
 * 参数yearsAgeMax - 最大年龄
 * 参数acceptEmpty - 是否接受空字符串
 * 返回值 - 如果日期有效且年龄符合要求，返回 dateStrCheckOk；否则返回相应的错误码
 * 具体错误与UInt8类型值的对应关系查看常量部分
 */
public func dateStrCheckAge(date: String, format: String, yearsAgeMin: Int, yearsAgeMax: Int, acceptEmpty: Bool): UInt8 
```

### email

提供遵循RFC 2822标准格式的电子邮件验证的功能

```cangjie
/*
 * 检查输入字符串是否为有效的电子邮件地址
 * 注意：检查前不会自动去除字符串两端的空白字符
 * 电子邮件格式规范参考：RFC 2822 Section 3.4.1
 *
 * 参数 email - 待检查的字符串
 * 返回值 - 如果符合电子邮件格式返回true，否则返回false
 * 
 * 特殊情况处理：
 * * 空字符串直接返回false
 * * 严格遵循RFC 2822标准验证格式
 */
public func checkEmail(email: String): Bool
```

### env

提供验证环境变量、从文件中加载需要设置的环境变量的功能

```cangjie
/*
 * 环境变量检查器类
 * 包含验证环境变量所需的配置参数
 * 参数 varName - 环境变量名称
 * 参数 defaultValue - 默认值（可选）
 * 参数 mandatory - 是否强制要求必须设置
 * 参数 debugPrint - 是否启用调试日志
 */
public class EnvChecker

/*
 * 调试日志输出函数
 * 参数 msg - 要记录的日志消息
 * 参数 debugPrint - 控制是否实际输出的开关
 */
public func debugLog(msg: String, debugPrint: Bool)

/*
 * 环境变量基础检查函数
 * 检查指定环境变量是否存在或设置默认值
 * 参数 varName - 要检查的环境变量名
 * 参数 defaultValue - 默认值（可选）
 * 参数 mandatory - 是否强制要求必须设置
 * 参数 debugPrint - 是否输出调试信息
 * 异常 - 当强制变量未设置时抛出IllegalArgumentException
 */
public func envCheck(varName: String, defaultValue: String, mandatory: Bool, debugPrint: Bool)

/*
 * 获取字符串类型环境变量
 * 参数 key - 环境变量名
 * 参数 defaultValue - 默认返回值
 * 返回值 - 环境变量值或默认值
 */
public func envStr(key: String, defaultValue: String): String

/*
 * 获取字符串列表类型环境变量
 * 参数 key - 环境变量名
 * 参数 separator - 分隔符
 * 参数 defaultValue - 默认返回值
 * 返回值 - 分割后的字符串列表或默认值
 */
public func envStrs(key: String, separator: String, defaultValue: ArrayList<String>): ArrayList<String>

/*
 * 获取IntNative类型环境变量
 * 参数 key - 环境变量名
 * 参数 defaultValue - 默认返回值
 * 返回值 - 解析后的整数值或默认值
 */
public func envIntNative(key: String, defaultValue: IntNative): IntNative

/*
 * 获取Int64类型环境变量
 * 参数 key - 环境变量名
 * 参数 defaultValue - 默认返回值
 * 返回值 - 解析后的64位整数值或默认值
 */
public func envInt64(key: String, defaultValue: Int64): Int64

/*
 * 获取整型列表环境变量
 * 参数 key - 环境变量名
 * 参数 separator - 分隔符
 * 参数 defaultValue - 默认返回值
 * 返回值 - 解析后的整型列表或默认值
 */
public func envInts(key: String, separator: String, defaultValue: ArrayList<IntNative>): ArrayList<IntNative>

/*
 * 获取Float64类型环境变量
 * 参数 key - 环境变量名
 * 参数 defaultValue - 默认返回值
 * 返回值 - 解析后的浮点数值或默认值
 */
public func envFloat64(key: String, defaultValue: Float64): Float64

/*
 * 获取布尔类型环境变量
 * 参数 key - 环境变量名
 * 参数 defaultValue - 默认返回值
 * 返回值 - 解析后的布尔值或默认值
 * 支持的值：t/T/true/TRUE/1表示true，f/F/false/FALSE/0表示false
 */
public func envBool(key: String, defaultValue: Bool): Bool

/*
 * 批量检查多个环境变量
 * 参数 envCheckers - EnvChecker对象列表
 * 异常 - 当任何强制变量检查失败时抛出异常
 */
public func envCheckerMany(envCheckers: ArrayList<EnvChecker>)

/*
 * 从文件加载环境变量
 * 参数 fileName - 包含完整路径的文件名
 * 参数 mustHave - 文件不存在时是否报错
 * 参数 overwriteValues - 是否覆盖已存在的变量
 * 文件格式要求：每行KEY=VALUE格式，支持#注释
 * 异常 - 当mustHave为true且文件不存在时抛出异常
 */
public func envLoadFromDisk(fileName: String, mustHave: Bool, overwriteValues: Bool)
```

### filter

提供处理空白字符、提取特殊字符的功能

```cangjie
/*
 * 移除重复的空白字符
 * 将连续的空白符（空格、制表符、换行符等）替换为单个空格
 * 参数 s - 待处理的字符串
 * 返回值 - 处理后的字符串
 * 特殊情况 - 空字符串直接返回空字符串
 */
public func dedupSpaces(s: String): String

/*
 * 清理字符串中的空白字符
 * 先移除重复空白字符，再去除首尾空白
 * 参数 s - 待处理的字符串
 * 返回值 - 处理后的字符串
 * 特殊情况 - 空字符串直接返回空字符串
 */
public func cleanSpaces(s: String): String

/*
 * 提取字符串中的字母字符
 * 移除所有非字母字符（数字、空格、符号等）
 * 参数 sequence - 原始字符串
 * 返回值 - 仅包含字母的新字符串
 * 特殊情况 - 空字符串直接返回空字符串
 */
public func onlyLetters(sequence: String): String

/*
 * 提取字符串中的数字字符
 * 移除所有非数字字符（字母、空格、符号等）
 * 参数 sequence - 原始字符串
 * 返回值 - 仅包含数字的新字符串
 * 特殊情况 - 空字符串直接返回空字符串
 */
public func onlyDigits(sequence: String): String

/*
 * 提取字母和数字字符
 * 移除所有非字母数字字符（空格、符号等）
 * 参数 sequence - 原始字符串
 * 返回值 - 仅包含字母数字的新字符串
 * 特殊情况 - 空字符串直接返回空字符串
 */
public func onlyLettersAndNumbers(sequence: String): String

/*
 * 移除字符串中的数字字符
 * 保留所有非数字字符
 * 参数 sequeue - 原始字符串
 * 返回值 - 不包含数字的新字符串
 * 特殊情况 - 空字符串直接返回空字符串
 * 注意 - 参数名拼写为sequeue（非常规拼写）
 */
public func removeDigits(sequeue: String): String
```

### handy

提供一些基础的验证器、处理器操作，供其他函数使用

```cangjie
/*
 * 判断字符是否为符号字符
 * 参数 ru - 要检查的字符
 * 返回值 - 如果是符号字符返回true，否则返回false
 * 符号定义 - 包含常见标点符号和特殊字符
 */
public func runeHasSymbol(ru: Rune): Bool

/*
 * 生成字符串的SHA256哈希值
 * 参数 s - 要哈希的字符串
 * 返回值 - 哈希值的十六进制字符串表示，出错时返回空字符串
 * 注意 - 使用标准SHA256算法
 */
public func stringHash(s: String): String

/*
 * 检查电话号码格式是否有效
 * 参数 phone - 要检查的电话号码字符串
 * 参数 acceptEmpty - 是否接受空字符串
 * 返回值 - 符合9-14位数字要求返回true
 * 处理逻辑 - 先移除所有非数字字符再检查长度
 */
public func checkPhone(phone: String, acceptEmpty: Bool): Bool

/*
 * 检查数值是否在指定范围内
 * 参数 n - 要检查的数值
 * 参数 low - 范围下限(包含)
 * 参数 high - 范围上限(包含)
 * 返回值 - 在范围内返回true
 */
public func between(n: Int64, low: Int64, high: Int64): Bool

/*
 * 三元条件运算符实现
 * 参数 condition - 条件表达式
 * 参数 tifThen - 条件为真时返回的值
 * 参数 tifElse - 条件为假时返回的值
 * 返回值 - 根据条件返回对应值
 * 注意 - 返回值类型为Any，需自行处理类型转换
 */
public func tif(condition: Bool, tifThen: Any, tifElse: Any): Any

/*
 * 截断字符串到指定长度
 * 参数 s - 原始字符串
 * 参数 maxLen - 最大长度限制
 * 参数 trim - 是否在截断后去除首尾空格
 * 返回值 - 处理后的字符串
 * 特殊情况 - 空字符串直接返回
 */
public func truncate(s: String, maxLen: Int64, trim: Bool): String

/*
 * 检查目标值是否匹配数组中的任一元素
 * 参数 search - 要搜索的值
 * 参数 items - 要匹配的数组
 * 返回值 - 找到匹配项返回true
 * 注意 - 使用字符串形式进行比较
 */
public func matchesAny(search: Any, items: Array<Any>): Bool

/*
 * 检查字符串是否只包含数字
 * 参数 sequence - 要检查的字符串
 * 返回值 - 全为数字返回true
 * 特殊情况 - 空字符串返回false
 */
public func hasOnlyNumbers(sequence: String): Bool

/*
 * 检查字符串是否只包含字母
 * 参数 sequence - 要检查的字符串
 * 返回值 - 全为字母返回true
 * 特殊情况 - 空字符串返回false
 */
public func hasOnlyLetters(sequence: String): Bool

/*
 * 获取去除首尾空格后的字符串长度
 * 参数 text - 要处理的字符串
 * 返回值 - 修剪后的字符数量
 */
public func trimLen(text: String): Int64

/*
 * 检查字符串长度是否满足最小要求
 * 参数 value - 要检查的字符串
 * 参数 minLength - 最小长度要求
 * 返回值 - 满足长度要求返回true
 * 处理逻辑 - 先去除首尾空格再比较长度
 */
public func checkMinLen(value: String, minLength: Int64): Bool

/*
 * 检查变量是否为数值类型
 * 参数 x - 要检查的变量
 * 返回值 - 是数值类型返回true
 * 支持类型 - 所有整型和浮点型
 */
public func isNumericType(x: Any): Bool

/*
 * 将任意值转换为二进制位(0或1)
 * 参数 x - 输入值
 * 返回值 - 数值非零返回1，否则返回0
 * 注意 - 非数值类型统一返回0
 */
public func bit(x: Any): UInt8

/*
 * 将任意值转换为布尔值
 * 参数 x - 输入值
 * 返回值 - 转换后的布尔值
 * 转换规则:
 * * 数值: 非零为true
 * * 字符串: "1"/"t"/"true"(不区分大小写)为true
 * * 其他: false
 */
public func boolean(x: Any): Bool

/*
 * 反转字符串
 * 参数 s - 要反转的字符串
 * 返回值 - 反转后的新字符串
 * 特殊情况 - 长度小于2直接返回原字符串
 */
public func reverseString(s: String): String

/*
 * 批量替换字符串内容
 * 参数 original - 原始字符串
 * 参数 replacementPairs - 替换对数组[old1,new1,old2,new2...]
 * 返回值 - 替换后的字符串
 * 异常 - 当替换对数量为奇数时抛出异常
 */
public func stringReplaceAll(original: String, replacementPairs: Array<String>): String

/*
 * 确保数值非负
 * 参数 n - 输入数值
 * 返回值 - 正数返回原值，负数返回0
 */
public func positiveOrZero(n: Int64): Int64
```

### inarray

提供将任意类型整数转换为BigInt类型、通过BigInt进行跨类型检查的功能

```cangjie
/*
 * 将任意整数类型转换为BigInt类型
 * 当输入不是整数类型时会返回0
 * 参数i-需要转换的整数值，支持所有整型变体
 * 返回值-转换后的BigInt值，转换失败返回0
 */
public func intToBigint(i: Any): BigInt

/*
 * 跨整型数组的包含检查（类型灵活版）
 * 使用BigInt进行跨整型比较
 * 参数item-要查找的整型元素，支持任意整型
 * 参数array-目标整型数组，支持任意整型数组
 * 返回值-存在返回true，不存在返回false
 */
public func inArrayIntFlex(item: ?Any, array: ?Any): Bool

/*
 * 类型严格版数组包含检查
 * 要求元素类型必须完全匹配
 * 参数array-目标数组，支持原生标量类型
 * 参数item-要查找的元素
 * 返回值-存在返回true，不存在返回false
 */
public func inArray(array: ?Any, item: ?Any): Bool
```

### name

提供对人名进行验证以及一些常规操作的功能

```cangjie
/*
 * 验证人名格式是否符合规范
 * 参数 name - 待验证的人名字符串
 * 参数 acceptEmpty - 是否接受空字符串
 * 返回值 - 返回CheckPersonNameResultXXX状态码
 * 验证规则：
 * * 仅允许字母、单引号和空格
 * * 至少包含2个单词
 * * 总字符数≥6
 * * 需包含≥3字符和≥2字符的单词各一个
 * 具体验证规则和状态码查看常量部分
 */
public func checkPersonName(name: String, acceptEmpty: Bool): UInt8

/*
 * 提取人名中的首尾单词
 * 参数 name - 原始人名字符串
 * 参数 transformFlags - 文本转换标志位
 * 返回值 - 格式化的"首单词+尾单词"字符串
 */
public func nameFirstAndLast(name: String, transformFlags: UInt): String

/*
 * 提取人名中的首个单词
 * 参数 name - 原始人名字符串
 * 参数 transformFlags - 文本转换标志位
 * 返回值 - 格式化的首单词字符串
 */
public func nameFirst(name: String, transformFlags: UInt): String

/*
 * 生成人名首字母缩写
 * 参数 name - 原始人名字符串
 * 参数 transformFlags - 文本转换标志位
 * 返回值 - 各单词首字母组成的字符串
 */
public func nameInitials(name: String, transformFlags: UInt): String
```

### password

提供对密码进行合规性检查的功能

```cangjie
/*
 * 执行新密码合规性检查
 * 参数 password - 待检查的密码字符串
 * 参数 passwordConfirmation - 密码确认字符串
 * 参数 minimumLength - 要求的最小密码长度（默认不低于4）
 * 参数 flagComplexity - 复杂度规则标志位组合
 * 返回值 - 返回CheckNewPasswordResultXXX状态码
 * 检查流程：
 * 1. 验证密码长度是否达标
 * 2. 验证密码与确认密码是否一致
 * 3. 根据复杂度标志验证密码组成
 * 特殊说明：
 * * ComplexityLowest标志会跳过其他复杂度检查
 * * 各复杂度规则可通过位或(|)组合使用
 * 具体复杂度规则与状态码查看常量部分
 */
public func checkNewPassword(password: String, passwordConfirmation: String, minimumLength: UInt, flagComplexity: UInt8): UInt8
```

### random_numeric_string

提供随机生成数字字符串的功能

```cangjie
/*
 * 生成随机数字字符串
 * 参数 forbiddenDigits - 需要排除的数字列表
 * 参数 lengthMin - 生成字符串的最小长度
 * 参数 lengthMax - 生成字符串的最大长度
 * 返回值 - 生成的随机数字字符串
 * 生成规则：
 * * 长度在[lengthMin, lengthMax]范围内随机
 * * 排除forbiddenDigits指定的数字
 * * 当没有可用数字时返回空字符串
 * 特殊情况处理：
 * * lengthMin/lengthMax为负值时返回空字符串
 * * lengthMax小于lengthMin时返回空字符串
 * * 所有数字都被排除时返回空字符串
 */
public func randomNumericString(forbiddenDigits: ArrayList<Int>, lengthMin: Int, lengthMax: Int): String
```

### random_string

提供根据指定格式随机生成字符串的功能

```cangjie
/*
 * 判断字符是否为符号字符
 * 参数 r - 需要判断的Unicode字符
 * 返回值 - 是符号字符返回true，否则返回false
 * 符号范围定义：
 * * 货币符号：U+20A0到U+20CF
 * * 数学运算符：U+2200到U+22FF
 * * 技术符号：U+2300到U+23FF
 * * 星星符号：U+2B50到U+2B59
 * * 箭头符号：U+2980到U+29FF
 * * 其他符号：U+2B00到U+2BFF
 * * 标点补充：U+2E00到U+2E7F
 * * 通用标点：U+2000到U+206F
 */
public func isSymbol(r: Rune): Bool

/*
 * 生成随机字符串
 * 参数 minLen - 生成字符串的最小长度
 * 参数 maxLen - 生成字符串的最大长度
 * 参数 allowUnicode - 是否允许Unicode字符
 * 参数 allowNumbers - 是否允许数字字符
 * 参数 allowSymbols - 是否允许符号字符
 * 参数 allowSpaces - 是否允许空格字符
 * 返回值 - 生成的随机字符串
 * 生成规则：
 * * 长度在[minLen, maxLen]范围内随机
 * * 根据参数控制字符类型包含
 * * 空格不允许出现在首尾位置
 * 特殊情况处理：
 * * minLen/maxLen为负值时返回空字符串
 * * maxLen为0时返回空字符串
 * * minLen大于maxLen时返回空字符串
 * 字符生成范围：
 * * 禁用Unicode时使用ASCII可打印字符(32-126)
 * * 启用Unicode时使用可打印字符范围(32-1114111)
 */
public func randomString(minLen: Int, maxLen: Int, allowUnicode: Bool, allowNumbers: Bool, allowSymbols: Bool,
    allowSpaces: Bool): String
```

### random

提供初始化随机数生成器与生成指定范围的随机数的功能

```cangjie
/*
 * 初始化随机数生成器
 * 使用当前UTC时间的纳秒时间戳作为种子
 * 返回值 - 初始化完成的Random对象
 */
public func initRandom(): Random

/*
 * 生成指定范围内的随机整数
 * 参数 min - 范围下限（包含）
 * 参数 max - 范围上限（不包含）
 * 返回值 - [min, max)区间内的随机整数
 * 注意 - 使用系统时间作为随机种子
 */
public func randomInt(min: Int, max: Int): Int

/*
 * 生成随机整数数组
 * 参数 min - 随机数下限（包含）
 * 参数 max - 随机数上限（不包含）
 * 参数 howMany - 需要生成的随机数数量
 * 返回值 - 包含指定数量随机整数的数组
 */
public func randomIntArray(min: Int, max: Int, howMany: Int): ArrayList<Int>

/*
 * 重新播种并生成随机数
 * 参数 min - 范围下限（包含）
 * 参数 max - 范围上限（不包含）
 * 返回值 - [min, max)区间内的随机整数
 * 特殊处理：
 * * 会修改随机数生成器的种子值
 * * 使用当前种子值参与新种子的生成
 */
public func randomReseed(min: Int, max: Int): Int
```

### reshape

提供使用占位符格式化字符串的功能

```cangjie
/*
 * 使用占位符格式化字符串
 * 参数 placeHolder - 用作占位符的字符
 * 参数 format - 格式化模板字符串
 * 参数 sequence - 要格式化的源字符串
 * 返回值 - 格式化后的字符串
 * 处理规则：
 * * 将format中的占位符替换为sequence中的字符
 * * 如果sequence比占位符数量多，剩余字符追加到末尾
 * * 如果placeHolder为空或format/sequence为空，返回原sequence
 */
public func reshapePH(placeHolder: Rune, format: String, sequence: String): String

/*
 * 使用默认占位符(#)格式化字符串
 * 参数 format - 格式化模板字符串
 * 参数 sequence - 要格式化的源字符串
 * 返回值 - 格式化后的字符串
 * 注意 - 内部调用reshapePH函数，使用默认占位符#
 */
public func reshape(format: String, sequence: String): String
```

### transform

提供根据各种规则对字符串进行转换的功能

```cangjie
/*
 * 将字符串转换为标题格式
 * 参数 s - 需要转换的原始字符串
 * 返回值 - 标题化后的字符串
 * 转换规则：
 * * 每个单词的首字母大写
 * * 其他字母保持原样
 * * 单词边界由空白字符确定
 */
public func title(s: String): String

/*
 * 字符串转换函数（并行处理模式）
 * 参数 s - 需要转换的原始字符串
 * 参数 maxLen - 结果字符串最大长度（0表示不限制）
 * 参数 transformFlags - 转换标志位组合
 * 返回值 - 转换后的字符串
 * 特性说明：
 * * 各转换操作并行执行，顺序不确定
 * * 最终会执行长度截断和修剪
 * 注意事项：
 * * 空字符串直接返回
 * * 转换顺序可能导致意外结果
 */
public func transform(s: String, maxLen: Int64, transformFlags: UInt): String

/*
 * 字符串转换函数（顺序处理模式）
 * 参数 s - 需要转换的原始字符串
 * 参数 maxLen - 结果字符串最大长度（0表示不限制）
 * 参数 transformFlags - 转换标志位数组（按顺序执行）
 * 返回值 - 转换后的字符串
 * 特性说明：
 * * 严格按照数组顺序执行转换
 * * 最后执行长度截断
 * 注意事项：
 * * 空字符串直接返回
 * * 保证转换顺序可预测
 */
public func transformSerially(s: String, maxLen: Int, transformFlags: Array<UInt>): String
```