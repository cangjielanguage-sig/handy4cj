package handy4cj

import std.collection.*
import std.math.numeric.*

public func intToBigint(i: Any): BigInt {
    return match {
        case i is IntNative => BigInt((i as IntNative).getOrThrow())
        case i is Int8 => BigInt((i as Int8).getOrThrow())
        case i is Int16 => BigInt((i as Int16).getOrThrow())
        case i is Int32 => BigInt((i as Int32).getOrThrow())
        case i is Int64 => BigInt((i as Int64).getOrThrow())
        case i is UIntNative => BigInt((i as UIntNative).getOrThrow())
        case i is UInt8 => BigInt((i as UInt8).getOrThrow())
        case i is UInt16 => BigInt((i as UInt16).getOrThrow())
        case i is UInt32 => BigInt((i as UInt32).getOrThrow())
        case i is UInt64 => BigInt((i as UInt64).getOrThrow())
        case _ => BigInt(0)
    }
}

// InArrayIntFlex 如果 "item" 存在于 "array" 中，则返回 true
// "item" 和 "array" 可以是不同类型，因为它们都是整数类型
// array 参数应该是任何整数类型的数组（int, int8, int16, int32, int64, uint, uint8, uint16, uint32 和 uint64）
// 该函数在进行值比较之前使用 BigInt 类型转换
public func inArrayIntFlex(item: ?Any, array: ?Any): Bool {
    if (array.isNone() || item.isNone()) {
        return false
    }
    let b1 = intToBigint(item.getOrThrow())
    return match {
        case array.getOrThrow() is ArrayList<IntNative> => (array.getOrThrow() as ArrayList<IntNative>).getOrThrow() |>
            any<IntNative> {i => BigInt((i as IntNative).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<Int8> => (array.getOrThrow() as ArrayList<Int8>).getOrThrow() |>
            any<Int8> {i => BigInt((i as Int8).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<Int16> => (array.getOrThrow() as ArrayList<Int16>).getOrThrow() |>
            any<Int16> {i => BigInt((i as Int16).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<Int32> => (array.getOrThrow() as ArrayList<Int32>).getOrThrow() |>
            any<Int32> {i => BigInt((i as Int32).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<Int64> => (array.getOrThrow() as ArrayList<Int64>).getOrThrow() |>
            any<Int64> {i => BigInt((i as Int64).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<UIntNative> => (array.getOrThrow() as ArrayList<UIntNative>).getOrThrow() |>
            any<UIntNative> {i => BigInt((i as UIntNative).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<UInt8> => (array.getOrThrow() as ArrayList<UInt8>).getOrThrow() |>
            any<UInt8> {i => BigInt((i as UInt8).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<UInt16> => (array.getOrThrow() as ArrayList<UInt16>).getOrThrow() |>
            any<UInt16> {i => BigInt((i as UInt16).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<UInt32> => (array.getOrThrow() as ArrayList<UInt32>).getOrThrow() |>
            any<UInt32> {i => BigInt((i as UInt32).getOrThrow()) == b1}
        case array.getOrThrow() is ArrayList<UInt64> => (array.getOrThrow() as ArrayList<UInt64>).getOrThrow() |>
            any<UInt64> {i => BigInt((i as UInt64).getOrThrow()) == b1}
        case _ => false
    }
}

// InArray 在 "array" 中搜索 "item"，如果找到则返回 true
// 这个函数单独放在这里是因为它的代码较长。
// 包含/涵盖所有原生标量/基本类型
public func inArray(array: ?Any, item: ?Any): Bool {
    if (array.isNone() || item.isNone()) {
        return false
    }
    return match {
        case array.getOrThrow() is ArrayList<IntNative> => (array.getOrThrow() as ArrayList<IntNative>).getOrThrow() |>
            any<IntNative> {i => (item.getOrThrow() as IntNative).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Int8> => (array.getOrThrow() as ArrayList<Int8>).getOrThrow() |>
            any<Int8> {i => (item.getOrThrow() as Int8).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Int16> => (array.getOrThrow() as ArrayList<Int16>).getOrThrow() |>
            any<Int16> {i => (item.getOrThrow() as Int16).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Int32> => (array.getOrThrow() as ArrayList<Int32>).getOrThrow() |>
            any<Int32> {i => (item.getOrThrow() as Int32).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Int64> => (array.getOrThrow() as ArrayList<Int64>).getOrThrow() |>
            any<Int64> {i => (item.getOrThrow() as Int64).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<UIntNative> => (array.getOrThrow() as ArrayList<UIntNative>).getOrThrow() |>
            any<UIntNative> {i => (item.getOrThrow() as UIntNative).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<UInt8> => (array.getOrThrow() as ArrayList<UInt8>).getOrThrow() |>
            any<UInt8> {i => (item.getOrThrow() as UInt8).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<UInt16> => (array.getOrThrow() as ArrayList<UInt16>).getOrThrow() |>
            any<UInt16> {i => (item.getOrThrow() as UInt16).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<UInt32> => (array.getOrThrow() as ArrayList<UInt32>).getOrThrow() |>
            any<UInt32> {i => (item.getOrThrow() as UInt32).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<UInt64> => (array.getOrThrow() as ArrayList<UInt64>).getOrThrow() |>
            any<UInt64> {i => (item.getOrThrow() as UInt64).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Float32> => (array.getOrThrow() as ArrayList<Float32>).getOrThrow() |>
            any<Float32> {i => (item.getOrThrow() as Float32).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Float64> => (array.getOrThrow() as ArrayList<Float64>).getOrThrow() |>
            any<Float64> {i => (item.getOrThrow() as Float64).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<String> => (array.getOrThrow() as ArrayList<String>).getOrThrow() |>
            any<String> {i => (item.getOrThrow() as String).getOrThrow() == i}
        case array.getOrThrow() is ArrayList<Bool> => (array.getOrThrow() as ArrayList<Bool>).getOrThrow() |>
            any<Bool> {i => (item.getOrThrow() as Bool).getOrThrow() == i}
        case _ => false
    }
}
