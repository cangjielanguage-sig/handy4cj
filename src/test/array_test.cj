package handy4cj.test

import handy4cj.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
public class ArrayDifferenceTest {
    @TestCase
    public func test_arrayDifferenceAtoB() {
        var testA = ArrayList<Int64>([1, 2, 3, 4])
        var testB = ArrayList<Int64>([1, 2, 3, 4])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>())

        testB = ArrayList<Int64>([3, 4, 5, 6])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>([1,2]))

        testB = ArrayList<Int64>([5, 6, 7, 8])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>([1,2,3,4]))

        testB = ArrayList<Int64>([1, 2, 3])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>([4]))

        testB = ArrayList<Int64>([1, 2, 3, 4, 5])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>())

        testB = ArrayList<Int64>([])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>([1,2,3,4]))

        testA = ArrayList<Int64>([])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>())

        testB = ArrayList<Int64>([1, 2, 3, 4])
        @Expect(arrayDifferenceAtoB(testA, testB),ArrayList<Int64>())
    }

    @TestCase
    public func test_ArrayDifference() {
        var testA = ArrayList<Int64>([1, 2, 3, 4])
        var testB = ArrayList<Int64>([1, 2, 3, 4])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>())

        testB = ArrayList<Int64>([3, 4, 5, 6])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([5,6,1,2]))

        testB = ArrayList<Int64>([5, 6, 7, 8])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([5,6,7,8,1,2,3,4]))

        testB = ArrayList<Int64>([1, 2, 3])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([4]))

        testB = ArrayList<Int64>([1, 2, 3, 4, 5])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([5]))

        testB = ArrayList<Int64>([])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([1,2,3,4]))

        testA = ArrayList<Int64>([])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>())

        testB = ArrayList<Int64>([1, 2, 3, 4])
        @Expect(arrayDifference(testA, testB),ArrayList<Int64>([1,2,3,4]))
    }
}
