package handy4cj

import std.collection.*
import std.random.*
import std.time.*

public func initRandom(): Random {
    let random = Random()
    random.seed = UInt64(DateTime.nowUTC().toUnixTimeStamp().toNanoseconds())
    return random
}

public func randomInt(min: Int, max: Int): Int {
    let random = initRandom()
    return random.nextInt64(max - min) + min
}

public func randomIntArray(min: Int, max: Int, howMany: Int): ArrayList<Int> {
    let result = ArrayList<Int>([])
    var i = 0
    while (i < howMany) {
        result.append(randomInt(min, max))
        i++
    }
    return result
}

public func randomReseed(min: Int, max: Int): Int {
    let random = initRandom()
    random.seed = random.seed + random.nextUInt64(random.seed)
    return random.nextInt64(max - min) + min
}
