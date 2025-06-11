package handy4cj.test

import handy4cj.*
import std.collection.*
import std.math.numeric.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
public class TestInArray {
    let tenThousandOcurrences = randomIntArray(0, 100000, 10000)
    let greatestUint64: UInt64 = 18446744073709551615
    @TestCase
    public func test_intToBigInt() {
        @Assert(intToBigint(IntNative(123)), BigInt(123))
        @Assert(intToBigint(Int8(123)), BigInt(123))
        @Assert(intToBigint(Int16(123)), BigInt(123))
        @Assert(intToBigint(Int32(123)), BigInt(123))
        @Assert(intToBigint(Int64(123)), BigInt(123))
        @Assert(intToBigint(IntNative(123)), BigInt(123))
        @Assert(intToBigint(UInt8(123)), BigInt(123))
        @Assert(intToBigint(UInt16(123)), BigInt(123))
        @Assert(intToBigint(UInt32(123)), BigInt(123))
        @Assert(intToBigint(UInt64(123)), BigInt(123))
    }

    @TestCase
    public func test_inArrayIntFlex() {
        @Expect(inArrayIntFlex(None, None), false)
        @Expect(inArrayIntFlex(0, None), false)
        @Expect(inArrayIntFlex(1, None), false)
        @Expect(inArrayIntFlex(0, ArrayList<IntNative>([-1, -2, 1, 2, 3, 4, 5, 6])), false)
        @Expect(inArrayIntFlex(32767, ArrayList<Int16>([-32767, 0, 32767])), true)
        @Expect(inArrayIntFlex(0, ArrayList<String>(["-1", "-0", "7455454", "xxx", "0xAF"])), false)
        @Expect(inArrayIntFlex(-100, tenThousandOcurrences), false)
        @Expect(inArrayIntFlex(greatestUint64, ArrayList<UInt64>([1, 2, 3, 4, 5, 6])), false)
        @Expect(inArrayIntFlex(greatestUint64, ArrayList<UInt64>([0, greatestUint64])), true)
        @Expect(inArrayIntFlex(UInt8(55), ArrayList<Int>([-1, -2, 1, 2, 3, 4, 5, 6, 55])), true)
        @Expect(inArrayIntFlex(UInt64(255), ArrayList<Int8>([-1, -2, 1, 2, 3, 4, 5, 6, 126])), false)
        @Expect(inArrayIntFlex(0, ArrayList<Int32>([-1, -2, 1, 2, 3, 4, 5, 6])), false)
        @Expect(inArrayIntFlex(1, ArrayList<Int64>([])), false)
        @Expect(inArrayIntFlex(13, ArrayList<UInt>([13])), true)
        @Expect(inArrayIntFlex(greatestUint64, ArrayList<UInt8>([1, 2, 3, 4, 5, 6])), false)
        @Expect(inArrayIntFlex(5555, ArrayList<UInt16>([1, 2, 3, 4, 5, 6, 5555])), true)
        @Expect(inArrayIntFlex(-5555, ArrayList<UInt32>([0, 0, 0, 0, 0, 5, 6, 5555])), false)
    }

    @TestCase
    public func test_inArray() {
        @Assert(inArray(ArrayList<IntNative>([1, 2, 3]), IntNative(2)), true)
        @Assert(inArray(ArrayList<IntNative>([1, 2, 3]), IntNative(4)), false)
        @Assert(inArray(ArrayList<IntNative>(), IntNative(1)), false)
        @Assert(inArray(ArrayList<Int8>([1, 2, 3]), Int8(2)), true)
        @Assert(inArray(ArrayList<Int8>([1, 2, 3]), Int8(4)), false)
        @Assert(inArray(ArrayList<Int8>(), Int8(1)), false)
        @Assert(inArray(ArrayList<Int16>([1, 2, 3]), Int16(2)), true)
        @Assert(inArray(ArrayList<Int16>([1, 2, 3]), Int16(4)), false)
        @Assert(inArray(ArrayList<Int16>(), Int16(1)), false)
        @Assert(inArray(ArrayList<Int32>([1, 2, 3]), Int32(3)), true)
        @Assert(inArray(ArrayList<Int32>([1, 2, 3]), Int32(4)), false)
        @Assert(inArray(ArrayList<Int32>(), Int32(1)), false)
        @Assert(inArray(ArrayList<Int64>([1, 2, 3]), 2), true)
        @Assert(inArray(ArrayList<Int64>([1, 2, 3]), 4), false)
        @Assert(inArray(ArrayList<Int64>(), 1), false)
        @Assert(inArray(ArrayList<UIntNative>([1, 2, 3]), UIntNative(2)), true)
        @Assert(inArray(ArrayList<UIntNative>([1, 2, 3]), UIntNative(4)), false)
        @Assert(inArray(ArrayList<UIntNative>(), UIntNative(1)), false)
        @Assert(inArray(ArrayList<UInt8>([1, 2, 3]), UInt8(3)), true)
        @Assert(inArray(ArrayList<UInt8>([1, 2, 3]), UInt8(4)), false)
        @Assert(inArray(ArrayList<UInt8>(), UInt8(1)), false)
        @Assert(inArray(ArrayList<UInt16>([1, 2, 3]), UInt16(1)), true)
        @Assert(inArray(ArrayList<UInt16>([1, 2, 3]), UInt16(4)), false)
        @Assert(inArray(ArrayList<UInt16>(), UInt16(1)), false)
        @Assert(inArray(ArrayList<UInt32>([1, 2, 3]), UInt32(2)), true)
        @Assert(inArray(ArrayList<UInt32>([1, 2, 3]), UInt32(4)), false)
        @Assert(inArray(ArrayList<UInt32>(), UInt32(1)), false)
        @Assert(inArray(ArrayList<UInt64>([1, 2, 3]), UInt64(2)), true)
        @Assert(inArray(ArrayList<UInt64>([1, 2, 3]), UInt64(4)), false)
        @Assert(inArray(ArrayList<UInt64>(), UInt64(1)), false)
        @Assert(inArray(ArrayList<Float32>([1.1, 2.2, 3.3]), Float32(2.2)), true)
        @Assert(inArray(ArrayList<Float32>([1.1, 2.2, 3.3]), Float32(4.4)), false)
        @Assert(inArray(ArrayList<Float32>(), Float32(1.1)), false)
        @Assert(inArray(ArrayList<Float64>([1.1, 2.2, 3.3]), Float64(3.3)), true)
        @Assert(inArray(ArrayList<Float64>([1.1, 2.2, 3.3]), Float64(4.4)), false)
        @Assert(inArray(ArrayList<Float64>(), Float64(1.1)), false)
        @Assert(inArray(ArrayList<String>(["a", "b", "c"]), "b"), true)
        @Assert(inArray(ArrayList<String>(["a", "b", "c"]), "d"), false)
        @Assert(inArray(ArrayList<String>(), "a"), false)
        @Assert(inArray(ArrayList<Bool>([true, false]), true), true)
        @Assert(inArray(ArrayList<Bool>([true, false]), false), true)
        @Assert(inArray(ArrayList<Bool>(), true), false)
    }
}
