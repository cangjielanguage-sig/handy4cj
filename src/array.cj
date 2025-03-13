package handy4cj

import std.collection.*


//计算a与b的差集
public func arrayDifferenceAtoB(a:ArrayList<Int64>, b : ArrayList<Int64>) :ArrayList<Int64>{
    let m = HashMap<Int64,Bool>()
    for (i in a) { 
        m[i] = false 
    }
    for (i in b) { 
        m[i] = true  
    }
    let diff:ArrayList<Int64> = ArrayList<Int64>()
    for (i in a where !m[i]){
        diff.append(i)
    }
        return diff
}

//计算a与b之间对称差集，集合中的任一元素在其中一个集合但不在另一个集合中
public func arrayDifference(a: ArrayList<Int64>, b: ArrayList<Int64>) :ArrayList<Int64>{
    let diffA = arrayDifferenceAtoB(a, b)
    let diffB = arrayDifferenceAtoB(b, a)
    for (item in diffA){
        diffB.append(item)
    }
    return  diffB
}


