package handy4cj

import std.collection.*
import std.fs.*
import std.io.*
import std.log.*
import std.math.numeric.*
import std.os.*
import std.regex.*

// nvChecker 包含验证环境变量的指令
public class EnvChecker {
    let varName: String
    let defaultValue: String
    let mandatory: Bool
    let debugPrint: Bool
    public init(varName: String, defaultValue: String, mandatory: Bool, debugPrint: Bool) {
        this.varName = varName
        this.defaultValue = defaultValue
        this.mandatory = mandatory
        this.debugPrint = debugPrint
    }
}

public func debugLog(msg: String, debugPrint: Bool) {
    let logger = SimpleLogger()
    if (debugPrint) {
        logger.log(LogLevel.ALL, msg)
    }
}

// envCheck 测试环境变量
public func envCheck(varName: String, defaultValue: String, mandatory: Bool, debugPrint: Bool) {
    if (!getEnv(varName).isNone()) {
        debugLog("environment variable " + varName + " asserted", debugPrint)
        return ""
    }
    if (defaultValue != "") {
        try {
            setEnv(varName, defaultValue)
            return ""
        } catch (e: IllegalArgumentException) {
            debugLog("environment variable " + varName + "asserted with default value", debugPrint)
            throw IllegalArgumentException()
        }
    }
    if (mandatory) {
        throw Exception("required environment variable " + varName + " isn't set")
    }
    return ""
}

public func envStr(key: String, defaultValue: String): String {
    match (getEnv(key)) {
        case None => return defaultValue
        case Some(v) => 
            if(v == ""){
                return defaultValue
            }
            return v
    }
}

public func envStrs(key: String, separator: String, defaultValue: ArrayList<String>): ArrayList<String> {
    let envList = ArrayList<String>()
    match (getEnv(key)) {
        case None => return defaultValue
        case Some(v) => 
            if(v == ""){
                return defaultValue
            }
            v.split(separator, removeEmpty: false) |> forEach<String>(envList.append)
    }
    return envList
}

public func envIntNative(key: String, defaultValue: IntNative): IntNative {
    try {
        return match (getEnv(key)) {
            case None => defaultValue
            case Some(v) => Decimal(v).toIntNative()
        }
    } catch (e: IllegalArgumentException) {
        return defaultValue
    }
}

public func envInt64(key: String, defaultValue: Int64): Int64 {
    try {
        return match (getEnv(key)) {
            case None => defaultValue
            case Some(v) => Decimal(v).toInt64()
        }
    } catch (e: IllegalArgumentException) {
        return defaultValue
    }
}

public func envInts(key: String, separator: String, defaultValue: ArrayList<IntNative>): ArrayList<IntNative> {
    let envList = ArrayList<IntNative>()
    try {
        match (getEnv(key)) {
            case None =>
                if (!defaultValue.isEmpty()) {
                    return defaultValue
                }
            case Some(v) => 
                if(v == "" && !defaultValue.isEmpty()){
                    return defaultValue
                }
                v.split(separator, removeEmpty: false) |>
                    forEach<String> {i => envList.append(Decimal(i).toIntNative())}
        }
    } catch (e: IllegalArgumentException) {
        return defaultValue
    }
    return envList
}

public func envFloat64(key: String, defaultValue: Float64): Float64 {
    try {
        return match (getEnv(key)) {
            case None => defaultValue
            case Some(v) => Decimal(v).toFloat64()
        }
    } catch (e: IllegalArgumentException) {
        return defaultValue
    }
}

public func envBool(key: String, defaultValue: Bool): Bool {
    let trueList = Array<String>(["t", "T", "true", "TRUE", "1"])
    let falseList = Array<String>(["f", "F", "false", "FALSE", "0"])
    match (getEnv(key)) {
        case None => defaultValue
        case Some(v) =>
            if (trueList.contains(v)) {
                return true
            } else if (falseList.contains(v)) {
                return false
            }
    }
    return defaultValue
}

// envCheckMany 一次测试多个环境变量
public func envCheckerMany(envCheckers: ArrayList<EnvChecker>) {
    try {
        envCheckers |> forEach<EnvChecker> {i => envCheck(i.varName, i.defaultValue, i.mandatory, i.debugPrint)}
    } catch (e: Exception) {
        throw Exception("func envCheck throws exception")
    }
    return ""
}

let reEnvVarRow = Regex("^([A-Za-z][0-9A-Za-z_]*)=(\\S+)")

// envLoadFromDisk 从磁盘加载一个文件，文件中包含以 KEY=VALUE 格式编写的变量
// fileName 是带有完整路径的文件名
// mustHave 如果文件不存在，将强制报错
// overwriteValue 如果为 false，表示跳过已经定义的环境变量
public func envLoadFromDisk(fileName: String, mustHave: Bool, overwriteValues: Bool) {
    var text = ""
    try (envFile = File.openRead(fileName), content = StringReader(envFile)) {
        text = content.readToEnd().replace("\r\n", "\n")
    } catch (e: Exception) {
        if (!mustHave) {
            throw Exception()
        }
        return ""
    }
    let rows = text.split("\n", removeEmpty: false)
    for (row in rows) {
        let matcher = Matcher(reEnvVarRow, row.trimAscii())
        let matches = matcher.fullMatch()
        match (matches) {
            case None => continue
            case Some(v) =>
                if (v.groupNumber() == 0) {
                    continue
                }
                let matchResult = v.matchStr().split("=")
                let key = matchResult[0]
                let value = matchResult[1]
                if (!getEnv(key).isNone() && !overwriteValues) {
                    continue
                }
                setEnv(key, value)
        }
    }
    return ""
}
