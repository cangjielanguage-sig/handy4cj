package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
public class TestRandom {
    @TestCase
    public func test_randomInt() {
        @Assert(between(randomInt(10, 20), 10, 20))
        @Assert(between(randomInt(10, 1000), 10, 1000))
        @Assert(between(randomInt(-10, 20), -10, 20))
    }

    @TestCase
    public func test_randomIntArray() {
        @Assert(randomIntArray(10, 20, 3) |> all{ i => between(i, 10, 20)})
        @Assert(randomIntArray(10, 1000, 3) |> all{ i => between(i, 10, 1000)})
        @Assert(randomIntArray(-10, 20, 3) |> all{ i => between(i, -10, 20)})
        @Assert(randomIntArray(1, 10, 1) |> all{ i => between(i, 1, 10)})
    }

    @TestCase
    public func test_randomReseed() {
        @Assert(between(randomReseed(10, 20), 10, 20))
        @Assert(between(randomReseed(10, 1000), 10, 1000))
        @Assert(between(randomReseed(-10, 20), -10, 20))
    }
}
