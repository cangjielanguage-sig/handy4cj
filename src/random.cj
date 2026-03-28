package handy4cj

import std.collection.*
import std.random.*
import std.time.*

public func initRandom(): Random {
    let random = Random(UInt64(DateTime.nowUTC().toUnixTimeStamp().toNanoseconds()))
    return random
}

public func randomInt(min: Int, max: Int): Int {
    let random = initRandom()
    return random.nextInt64(max - min) + min
}

public func randomIntArray(min: Int, max: Int, howMany: Int): ArrayList<Int> {
    let result = ArrayList<Int>()
    while (result.size < howMany) {
        result.add(randomInt(min, max))
    }
    return result
}

@OverflowWrapping
public func randomReseed(min: Int, max: Int): Int {
    let random = initRandom()
    let reseededRandom = Random(random.seed + random.nextUInt64())
    return reseededRandom.nextInt64(max - min) + min
}
