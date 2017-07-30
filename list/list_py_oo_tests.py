def testList(impl):

    assert(impl.new() == impl.new())
    assert(impl.new(1) == impl.new(1))
    assert(not impl.new() == impl.new(1))
    assert(not impl.new(1) == impl.new())

    assert(impl.new() <= impl.new())
    assert(impl.new(1) <= impl.new(1))
    assert(impl.new() <= impl.new(1))
    assert(not impl.new(1) <= impl.new())
    assert(impl.new(1) <= impl.new(2))
    assert(not impl.new(2) <= impl.new(1))
    assert(impl.new(1) <= impl.new(1, 1))
    assert(not impl.new(1, 1) <= impl.new(1))

    assert(impl.new().match(1, lambda h, t: 2) == 1)
    assert(
        impl.new(1, 2, 3)
            .match((4, impl.new(5)), lambda h, t: (h, t))
        == (1, impl.new(2, 3)))

    assert(repr(impl.new()) == '[]')
    assert(repr(impl.new(1, 2, 3)) == '[1, 2, 3]')

    assert(impl.new().toPyList() == [])
    assert(impl.new(1, 2, 3).toPyList() == [1, 2, 3])

    assert(impl.new(1, 2).append(impl.new(3, 4)) == impl.new(1, 2, 3, 4))

    assert(impl.new().length() == 0)
    assert(impl.new(1, 2, 3).length() == 3)

    assert(impl.new().all(lambda a: a == 3))
    assert(impl.new(1, 2, 3, 4).all(lambda a: a > 0))
    assert(not impl.new(1, 2, 3, 4).all(lambda a: a == 3))
    assert(not impl.new(1, 2, 3, 4).all(lambda a: a == 5))

    assert(not impl.new().any(lambda a: a == 3))
    assert(impl.new(1, 2, 3, 4).any(lambda a: a == 2))
    assert(not impl.new(1, 2, 3, 4).any(lambda a: a == 5))

    assert(impl.new(1, 2).map(lambda x: x+1) == impl.new(2, 3))

    assert(
        impl.new(1, 2)
            .flatMap(lambda x: impl.new(x*10, x*100))
        == impl.new(10, 100, 20, 200))

    assert(impl.new(impl.new()).flatten() == impl.new())
    assert(
        impl.new(impl.new(1, 2), impl.new(3, 4))
            .flatten()
        == impl.new(1, 2, 3, 4))

    assert(
        impl.new(1, 2, 3, 4)
            .keep(lambda a: a % 2 == 0)
        == impl.new(2, 4))

    assert(
        impl.new(1, 2, 3, 4)
            .discard(lambda a: a % 2 == 0)
        == impl.new(1, 3))

    assert(impl.new().headList() == impl.new())
    assert(impl.new(1, 2, 3).headList() == impl.new(1))
    assert(impl.new().headList() == impl.new())
    assert(impl.new(1, 2, 3).headList() == impl.new(1))

    assert(impl.new().headOrElse(4) == 4)
    assert(impl.new(1, 2, 3).headOrElse(4) == 1)

    assert(impl.new().tailList() == impl.new())
    assert(impl.new(1, 2, 3).tailList() == impl.new(impl.new(2, 3)))

    assert(impl.new().reverse() == impl.new())
    assert(impl.new(1, 2, 3).reverse() == impl.new(3, 2, 1))

    assert(
        impl.new(1, 2, 3, 4)
            .discardFirst(lambda a: a % 2 == 0)
        == impl.new(1, 3, 4))

    assert(
        impl.new(1, 2, 3, 4)
            .takeWhile(lambda a: a < 3)
        == impl.new(1, 2))
    assert(
        impl.new(1, 2, 3, 4)
            .takeWhile(lambda a: a > 5)
        == impl.new())

    assert(
        impl.new(1, 2, 3, 4)
            .dropWhile(lambda a: a < 3)
        == impl.new(3, 4))
    assert(
        impl.new(1, 2, 3, 4)
            .dropWhile(lambda a: a < 5)
        == impl.new())

    assert(impl.new().drop(0) == impl.new())
    assert(impl.new(1, 2, 3, 4).drop(0) == impl.new(1, 2, 3, 4))
    assert(impl.new(1, 2, 3, 4).drop(2) == impl.new(3, 4))
    assert(impl.new(1, 2, 3, 4).drop(5) == impl.new())

    assert(impl.new().take(0) == impl.new())
    assert(impl.new(1, 2, 3, 4).take(0) == impl.new())
    assert(impl.new(1, 2, 3, 4).take(2) == impl.new(1, 2))
    assert(impl.new(1, 2, 3, 4).take(5) == impl.new(1, 2, 3, 4))

    assert(
        impl.new(1, 2, 3)
            .zipWith(impl.new(10, 20, 30), lambda a, b: a + b)
        == impl.new(11, 22, 33))

    print("SUCCESS: all tests pass")
