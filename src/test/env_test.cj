package handy4cj.test

import handy4cj.*
import std.collection.*
import std.env.*
import std.fs.*
import std.unittest.*
import std.unittest.testmacro.*
internal import stdx.serialization.serialization.*
internal import std.fs.Path as LocalPath
internal import cangjie_toml.cangjie_toml.*

public class TestEnvCheckDemo {
    let title: String
    let defaultValue: String
    let define: String
    let mandatory: Bool
    let debugLog: Bool
    public init(title: String, defaultValue: String, define: String, mandatory: Bool, debugLog: Bool) {
        this.title = title
        this.defaultValue = defaultValue
        this.define = define
        this.mandatory = mandatory
        this.debugLog = debugLog
    }
}

public class TestEnvStrDemo {
    let envVar: String
    let value: String
    let defaultValue: String
    let assertion: String
    public init(envVar: String, value: String, defaultValue: String, assertion: String) {
        this.envVar = envVar
        this.value = value
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvStrsDemo {
    let envVar: String
    let value: String
    let separator: String
    let defaultValue: ArrayList<String>
    let assertion: ArrayList<String>
    public init(envVar: String, value: String, separator: String, defaultValue: ArrayList<String>,
        assertion: ArrayList<String>) {
        this.envVar = envVar
        this.value = value
        this.separator = separator
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvIntNativeDemo {
    let envVar: String
    let value: String
    let defaultValue: IntNative
    let assertion: IntNative
    public init(envVar: String, value: String, defaultValue: IntNative, assertion: IntNative) {
        this.envVar = envVar
        this.value = value
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvInt64Demo {
    let envVar: String
    let value: String
    let defaultValue: Int64
    let assertion: Int64
    public init(envVar: String, value: String, defaultValue: Int64, assertion: Int64) {
        this.envVar = envVar
        this.value = value
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvIntsDemo {
    let envVar: String
    let value: String
    let separator: String
    let defaultValue: ArrayList<IntNative>
    let assertion: ArrayList<IntNative>
    public init(envVar: String, value: String, separator: String, defaultValue: ArrayList<IntNative>,
        assertion: ArrayList<IntNative>) {
        this.envVar = envVar
        this.value = value
        this.separator = separator
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvFloat64Demo {
    let envVar: String
    let value: String
    let defaultValue: Float64
    let assertion: Float64
    public init(envVar: String, value: String, defaultValue: Float64, assertion: Float64) {
        this.envVar = envVar
        this.value = value
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvBoolDemo {
    let envVar: String
    let value: String
    let defaultValue: Bool
    let assertion: Bool
    public init(envVar: String, value: String, defaultValue: Bool, assertion: Bool) {
        this.envVar = envVar
        this.value = value
        this.defaultValue = defaultValue
        this.assertion = assertion
    }
}

public class TestEnvCheckerManyDemo {
    let title: String
    let envCheckers: ArrayList<EnvChecker>
    public init(title: String, envCheckers: ArrayList<EnvChecker>) {
        this.title = title
        this.envCheckers = envCheckers
    }
}

public class TestEnvLoadFromDiskDemo {
    let envVar: String
    let assertion: String
    public init(envVar: String, assertion: String) {
        this.envVar = envVar
        this.assertion = assertion
    }
}

public func getRootPath(path: String, module!: String = ""): LocalPath {
    if (module == "") {
        return LocalPath(path)
    }

    try {
        return getCjpmPath(module, path)
    } catch (_: Exception) {
        return LocalPath(path)
    }
}

func getCjpmPath(module: String, path: String): LocalPath {
    let cjpmLock = DataModel.fromTomlFile("cjpm.lock") |> CjpmLock.deserialize
    let commitId = cjpmLock.requires[module].commitId
    return getHomeDirectory()
        .join(".cjpm")
        .join("git")
        .join(module)
        .join(commitId)
        .join(path)
}

class CjpmLock <: Serializable<CjpmLock> {
    public CjpmLock(
        public var version: Int64,
        public var requires: HashMap<String, Require>
    ) {}

    public func serialize(): DataModel {
        return DataModelStruct().add(field("version", version)).add(field("requires", requires))
    }

    public static func deserialize(dm: DataModel): CjpmLock {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        return CjpmLock(
            Int64.deserialize(dms.get("version")),
            HashMap<String, Require>.deserialize(dms.get("requires"))
        )
    }
}

class Require <: Serializable<Require> {
    public Require(
        public var commitId: String,
        public var git: String
    ) {}

    public func serialize(): DataModel {
        return DataModelStruct().add(field<String>("commitId", commitId)).add(field<String>("git", git))
    }

    public static func deserialize(dm: DataModel): Require {
        let dms = match (dm) {
            case d: DataModelStruct => d
            case _ => throw Exception("this data is not DataModelStruct")
        }
        return Require(
            String.deserialize(dms.get("commitId")),
            String.deserialize(dms.get("git"))
        )
    }
}

@Test
public class TestEnv {
    @TestCase
    public func test_envCheck() {
        let testList = [
            TestEnvCheckDemo("ENVALRIGHT", "X", "xyz", true, false),
            TestEnvCheckDemo("ENVDOESNTEXIST", "X", "", false, true),
            TestEnvCheckDemo("ENVEMPTYOPTIONAL", "", "xyz", false, true),
            TestEnvCheckDemo("ENVMANDATORYWITHDEFAULT", "xyz", " ", true, true)
        ]
        testList |>
            forEach<TestEnvCheckDemo> {i => @Assert(envCheck(i.title, i.defaultValue, i.mandatory, i.debugLog), "")}
        @AssertThrows[Exception](envCheck("ENVEMPTYMANDATORY", "", true, true))

        setVariable("TESTSETDONE", "done")
        @Assert(envCheck("TESTSETDONE", "", true, true), "")
        setVariable("TESTSETEMPTYDONE", "")
        @AssertThrows[Exception](envCheck("TESTSETEMPTYDONE", "", true, true))
    }

    @TestCase
    public func test_envStr() {
        let testList = [
            TestEnvStrDemo("ENV_XYZ", "xyz", "", "xyz"),
            TestEnvStrDemo("ENV_EMPTY", "", "", ""),
            TestEnvStrDemo("ENV_EMPTYDEFAULT", "", "xyz", "xyz")
        ]
        testList |> forEach<TestEnvStrDemo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvStrDemo> {i => @Assert(envStr(i.envVar, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envStrs() {
        let testList = [
            TestEnvStrsDemo("ENV_ABC", "a,b,c", ",", ArrayList<String>(), ArrayList<String>(["a", "b", "c"])),
            TestEnvStrsDemo("ENV_VALUEEMPTY", "", ",", ArrayList<String>(["a", "b", "c"]),
                ArrayList<String>(["a", "b", "c"])),
            TestEnvStrsDemo("ENV_DEFAULTEMPTY", "", ",", ArrayList<String>(), ArrayList<String>())
        ]
        testList |> forEach<TestEnvStrsDemo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvStrsDemo> {i => @Assert(envStrs(i.envVar, i.separator, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envIntNative() {
        let testList = [
            TestEnvIntNativeDemo("ENV_111", "111", 0, 111),
            TestEnvIntNativeDemo("ENV_EMPTY", "", 0, 0),
            TestEnvIntNativeDemo("ENV_ZERO", "0", 0, 0),
            TestEnvIntNativeDemo("ENV_ZERODEFAULT", "", 0, 0),
            TestEnvIntNativeDemo("ENV_555", "", 555, 555),
            TestEnvIntNativeDemo("ENV_INVALID", "abc", 123, 123),
            TestEnvIntNativeDemo("ENV_NEGATIVE", "-999", 0, -999),
            TestEnvIntNativeDemo("ENV_LARGEVALUE", "9223372036854775807", 0, 9223372036854775807)
        ]
        testList |> forEach<TestEnvIntNativeDemo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvIntNativeDemo> {i => @Assert(envIntNative(i.envVar, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envInt64() {
        let testList = [
            TestEnvInt64Demo("ENV_111", "111", 0, 111),
            TestEnvInt64Demo("ENV_EMPTY", "", 0, 0),
            TestEnvInt64Demo("ENV_ZERO", "0", 0, 0),
            TestEnvInt64Demo("ENV_ZERODEFAULT", "", 0, 0),
            TestEnvInt64Demo("ENV_555", "", 555, 555),
            TestEnvInt64Demo("ENV_INVALID", "abc", 123, 123),
            TestEnvInt64Demo("ENV_NEGATIVE", "-999", 0, -999),
            TestEnvInt64Demo("ENV_LARGEVALUE", "9223372036854775807", 0, 9223372036854775807)
        ]
        testList |> forEach<TestEnvInt64Demo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvInt64Demo> {i => @Assert(envInt64(i.envVar, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envInts() {
        let testList = [
            TestEnvIntsDemo("MY_VAR_1234", "1,2,3,4", ",", ArrayList<IntNative>(), ArrayList<IntNative>([1, 2, 3,
                4])),
            TestEnvIntsDemo("MY_VAR_EMPTY_567", "", ",", ArrayList<IntNative>([1, 2, 3]),
                ArrayList<IntNative>([1, 2, 3])),
            TestEnvIntsDemo("MY_VAR_EMPTY_103020", "", ",", ArrayList<IntNative>([1, 2, 3]),
                ArrayList<IntNative>([1, 2, 3])),
            TestEnvIntsDemo("MY_VAR_INVALID_1abc34", "1,abc,3,4", ",", ArrayList<IntNative>(),
                ArrayList<IntNative>()),
            TestEnvIntsDemo("MY_VAR_42", "42", ",", ArrayList<IntNative>(), ArrayList<IntNative>([42])),
            TestEnvIntsDemo("MY_VAR_1minus2_3minus4", "1,-2,3,-4", ",", ArrayList<IntNative>(),
                ArrayList<IntNative>([1, -2, 3, -4])),
            TestEnvIntsDemo("MY_VAR_EMPTY_DEFAULT", "", ",", ArrayList<IntNative>(), ArrayList<IntNative>())
        ]
        testList |> forEach<TestEnvIntsDemo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvIntsDemo> {i => @Assert(envInts(i.envVar, i.separator, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envFloat64() {
        let testList = [
            TestEnvFloat64Demo("ENV_3_14", "3.14", 0.0, 3.14),
            TestEnvFloat64Demo("ENV_EMPTY", "", 0.0, 0.0),
            TestEnvFloat64Demo("ENV_ZERO", "0.0", 0.0, 0.0),
            TestEnvFloat64Demo("ENV_ZERODEFAULT", "", 1.0, 1.0),
            TestEnvFloat64Demo("ENV_NEGATIVE", "-5.5", 0.0, -5.5),
            TestEnvFloat64Demo("ENV_INVALID", "abc", 10.0, 10.0)
        ]
        testList |> forEach<TestEnvFloat64Demo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvFloat64Demo> {i => @Assert(envFloat64(i.envVar, i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envBool() {
        let testList = [
            TestEnvBoolDemo("ENV_TRUE", "true", false, true),
            TestEnvBoolDemo("ENV_FALSE", "false", true, false),
            TestEnvBoolDemo("ENV_1", "1", false, true),
            TestEnvBoolDemo("ENV_0", "0", true, false),
            TestEnvBoolDemo("ENV_1", "TRUE", false, true),
            TestEnvBoolDemo("ENV_0", "FALSE", true, false),
            TestEnvBoolDemo("ENV_1", "t", false, true),
            TestEnvBoolDemo("ENV_0", "f", true, false),
            TestEnvBoolDemo("ENV_1", "T", false, true),
            TestEnvBoolDemo("ENV_0", "F", true, false),
            TestEnvBoolDemo("ENV_INVALID", "notabool", true, true),
            TestEnvBoolDemo("ENV_EMPTY", "", false, false),
            TestEnvBoolDemo("ENV_SETDEFAULT", "", true, true)
        ]
        testList |> forEach<TestEnvBoolDemo> {i => setVariable(i.envVar, i.value)}
        testList |> forEach<TestEnvBoolDemo> {i => @Assert(envBool(i.envVar,i.defaultValue), i.assertion)}
    }

    @TestCase
    public func test_envCheckerMany() {
        let testList = [
            TestEnvCheckerManyDemo(
                "TwoValid",
                ArrayList<EnvChecker>([EnvChecker("ENVALRIGHT1", "X", true, false),
                    EnvChecker("ENVALRIGHT2", "Y", false, true)])
            ),
            TestEnvCheckerManyDemo(
                "EOneValidOneInvalid",
                ArrayList<EnvChecker>([EnvChecker("ENVALRIGHT1", "X", true, false),
                    EnvChecker("ENVEMPTYMANDATORY1", "", true, true)])
            ),
            TestEnvCheckerManyDemo(
                "TwoInvalid",
                ArrayList<EnvChecker>([EnvChecker("ENVEMPTYMANDATORY1", "", true, true),
                    EnvChecker("ENVMANDATORYWITHDEFAULT2", "", true, false)])
            ),
            TestEnvCheckerManyDemo(
                "ThreeValid",
                ArrayList<EnvChecker>([
                    EnvChecker("ENVALRIGHT1", "X", true, false),
                    EnvChecker("ENVEMPTYOPTIONAL1", "", false, true),
                    EnvChecker("ENVMANDATORYWITHDEFAULT1", "default1", true, true)
                ])
            )
        ]

        @Assert(envCheckerMany(testList[0].envCheckers).toString(), "")
        @Assert(envCheckerMany(testList[3].envCheckers).toString(), "")
        @AssertThrows[Exception](envCheckerMany(testList[1].envCheckers))
        @AssertThrows[Exception](envCheckerMany(testList[2].envCheckers))
    }

    @TestCase
    public func test_envLoadFromDisk() {
        let testList = [
            TestEnvLoadFromDiskDemo("#THISIS", ""),
            TestEnvLoadFromDiskDemo("STARTWITH", "SPACE"),
            TestEnvLoadFromDiskDemo("_INVALIDXX1", ""),
            TestEnvLoadFromDiskDemo("VALIDXX1", "NORMAL"),
            TestEnvLoadFromDiskDemo("lowercase", "111"),
            TestEnvLoadFromDiskDemo("10INVALIDXX11", ""),
            TestEnvLoadFromDiskDemo("INVALIDXX2", "")
        ]
        envLoadFromDisk(getRootPath("env_test.txt").toString(), true, true)
        for (i in testList) {
            match (getVariable(i.envVar)) {
                case None => @Expect("", i.assertion)
                case Some(v) => @Expect(v, i.assertion)
            }
        }
    }
}
