package handy4cj

import std.collection.*

// 计算a与b的差集
public func arrayDifferenceAtoB(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64> {
    let m = HashMap<Int64, Bool>()
    a |> forEach<Int64> {i => m[i] = false}
    b |> forEach<Int64> {i => m[i] = true}
    let diff: ArrayList<Int64> = ArrayList<Int64>()
    a |> filter {i => !m[i]} |> forEach<Int64> {i => diff.add(i)}
    return diff
}

// 计算a与b之间对称差集，集合中的任一元素在其中一个集合但不在另一个集合中
public func arrayDifference(a: ArrayList<Int64>, b: ArrayList<Int64>): ArrayList<Int64> {
    let diffA = arrayDifferenceAtoB(a, b)
    let diffB = arrayDifferenceAtoB(b, a)
    diffA |> forEach<Int64> {i => diffB.add(i)}
    return diffB
}
