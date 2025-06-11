<div align="center">
<h1>handy4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.0.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.18-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/state-孵化-brightgreen" style="display: inline-block;" />
</p>

## 介绍

handy4cj是一个基于仓颉的实用程序和助手，如验证器、清理器和字符串格式化程序。

项目参考自 https://github.com/miguelpragier/handy

### 项目特性

- 支持对于字符串的多种格式验证与类型转换

- 支持时间与字符串的转换以及时间的验证

- 支持生成随机数字、随机数组、随机字符串、随机数字字符串

- 支持环境变量的验证

## 项目架构

### 源码目录

```shell
.
├── README.md                                   #整体介绍
├── CHANGELOG.md  
├── README.OpenSource
├── LICENSE
├── cjpm.toml
├── env_test.txt
│ 
├── doc                                         #文档目录，包括设计文档，API接口文档等
│   ├── design.md                               #设计文档
│   └── feature_api.md                          #特性接口文档
└── src                                         #源码目录
    ├── array.cj                                #提供计算差集和对称差集的功能
    ├── complex_string.cj                       #提供对字符串的格式进行检查的功能
    ├── convert.cj                              #提供字符串向 Float64、Int64 转换的功能
    ├── dateTime.cj                             #提供日期与字符串之间的转化、验证日期格式与字符串格式有效性、计算两个日期之间差值的功能
    ├── email.cj                                #提供遵循RFC 2822标准格式的电子邮件验证的功能
    ├── env.cj                                  #提供验证环境变量、从文件中加载需要设置的环境变量的功能
    ├── filters.cj                              #提供处理空白字符、提取特殊字符的功能
    ├── handy.cj                                #提供一些基础的验证器、处理器操作，供其他函数使用
    ├── inarray.cj                              #提供将任意类型整数转换为BigInt类型、通过BigInt进行跨类型检查的功能
    ├── name.cj                                 #提供对人名进行验证以及一些常规操作的功能
    ├── password.cj                             #提供对密码进行合规性检查的功能
    ├── random_numeric_string.cj                #提供随机生成数字字符串的功能
    ├── random_string.cj                        #提供根据指定格式随机生成字符串的功能
    ├── random.cj                               #提供初始化随机数生成器与生成指定范围的随机数的功能
    ├── reshape.cj                              #提供使用占位符格式化字符串的功能
    ├── transform.cj                            #提供根据各种规则对字符串进行转换的功能
    └── test                                    #测试代码目录
        ├── array_test.cj                       #array单元测试
        ├── complex_string_test.cj              #complex_string单元测试
        ├── convert_test.cj                     #convert单元测试
        ├── dateTime_test.cj                    #dateTime单元测试
        ├── email_test.cj                       #email单元测试
        ├── env_test.cj                         #email单元测试
        ├── filters_test.cj                     #filters单元测试
        ├── handy_test.cj                       #handy单元测试
        ├── inarray_test.cj                     #inarray单元测试
        ├── name_test.cj                        #name单元测试
        ├── password_test.cj                    #password单元测试
        ├── random_numeric_string_test.cj       #random_numeric_string单元测试
        ├── random_string_test.cj               #random_string单元测试
        ├── random_test.cj                      #ranodm单元测试
        ├── reshape_test.cj                     #reshape单元测试
        └── transform_test.cj                   #transfomr单元测试
```

### 接口说明

主要类和函数接口说明，详见 [API](./doc/feature_api.md)

## 使用说明
### 依赖引入

```shell
[dependencies]
    handy4cj = { git = "https://gitcode.com/Bayonet/handy4cj.git" }
```

### 编译构建

```shell
cjpm update
cjpm build
```

### 示例1：计算差集和对称差集
功能描述：本实例展示如何调用array的函数计算差集和对称差集
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
功能描述：本示例展示如何调用 checkStr 函数对字符串的格式进行验证
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
功能描述：本示例展示了如何进行日期与字符串之间的转化、如何验证日期的格式以及重新格式化日期、如何计算两个日期之间相差的时间
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
功能描述：本示例展示了如何对环境变量进行检查，envXXX中XXX可以是整数类型、浮点数类型、布尔类型、字符串类型
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
功能描述：本示例展示了如何随机生成数字、数组、字符串和数字字符串
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
功能描述：本示例展示了如何使用占位符来对字符串进行格式化
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
功能描述：本示例展示了本项目实现的对字符串的一些基础操作，比如按规则格式化、反转等
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
功能描述：本示例展示了如何对名字和密码进行格式化以及对名字进行提取的操作
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

## 约束与限制

依赖项目：https://gitcode.com/PermissionDog/cangjie_toml

在下述版本验证通过：

    Cangjie Version: 0.53.18

## 开源协议
本项目基于MIT License

## 参与贡献

本项目由 [SIGCANGJIE / 仓颉兴趣组](https://gitcode.com/SIGCANGJIE) 实现并维护。技术支持和意见反馈请提Issue。

欢迎给我们提交PR，欢迎参与任何形式的贡献。

本项目committer：[@Bayonet](https://gitcode.com/Bayonet)

This project is supervised by [@zhangyin_gitcode](https://gitcode.com/zhangyin_gitcode) (HUAWEI Developer Advocate).

![](https://raw.gitcode.com/SIGCANGJIE/homepage/attachment/uploads/9b648c07-efc2-4eb3-b02f-eab18c77beea/devadvocate.png)