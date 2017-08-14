require 'test_bench/activate'

def testList impl
    assert(impl.build == impl.build)
    assert(impl.build(1) == impl.build(1))
    refute(impl.build == impl.build(1))
    refute(impl.build(1) == impl.build)

    assert(impl.build <= impl.build)
    assert(impl.build(1) <= impl.build(1))
    assert(impl.build <= impl.build(1))
    refute(impl.build(1) <= impl.build)
    assert(impl.build(1) <= impl.build(2))
    refute(impl.build(2) <= impl.build(1))
    assert(impl.build(1) <= impl.build(1, 1))
    refute(impl.build(1, 1) <= impl.build(1))

    assert(impl.build.match.(1, -> (h, t) { 2 }) == 1)
    assert(
      impl.build(1, 2, 3).match.([4, impl.build(5)], -> (h, t) { [h, t] }) == [1, impl.build(2, 3)]
    )

    assert(impl.build.to_s == '[]')
    assert(impl.build(1, 2, 3).to_s == '[1, 2, 3]')

    assert(impl.build.toArray == [])
    assert(impl.build(1, 2, 3).toArray == [1, 2, 3])

    assert(impl.build(1, 2).append(impl.build(3, 4)) == impl.build(1, 2, 3, 4))

    assert(impl.build.length == 0)
    assert(impl.build(1, 2, 3).length == 3)

    assert(impl.build.all(-> a { a == 3 }))
    assert(impl.build(1, 2, 3, 4).all(-> a { a > 0 }))
    refute(impl.build(1, 2, 3, 4).all(-> a { a == 3 }))
    refute(impl.build(1, 2, 3, 4).all(-> a { a == 5 }))

    refute(impl.build.any(-> a { a == 3 }))
    assert(impl.build(1, 2, 3, 4).any(-> a { a == 2 }))
    refute(impl.build(1, 2, 3, 4).any(-> a { a == 5 }))

    assert(impl.build(1, 2).map(-> x { x + 1 }) == impl.build(2, 3))

    assert(
        impl.build(1, 2).flatMap(-> x { impl.build(x*10, x*100) }) == impl.build(10, 100, 20, 200)
    )

    assert(impl.build(impl.build).flatten == impl.build)
    assert(
        impl.build(impl.build(1, 2), impl.build(3, 4))
            .flatten == impl.build(1, 2, 3, 4)
    )

    assert(
        impl.build(1, 2, 3, 4)
            .keep(-> a { a % 2 == 0 }) == impl.build(2, 4)
    )

    assert(
        impl.build(1, 2, 3, 4)
            .discard(-> a { a % 2 == 0 }) == impl.build(1, 3)
    )

    assert(impl.build.headList == impl.build)
    assert(impl.build(1, 2, 3).headList == impl.build(1))
    assert(impl.build.headList == impl.build)
    assert(impl.build(1, 2, 3).headList == impl.build(1))

    assert(impl.build.headOrElse(4) == 4)
    assert(impl.build(1, 2, 3).headOrElse(4) == 1)

    assert(impl.build.tailList == impl.build)
    assert(impl.build(1, 2, 3).tailList == impl.build(impl.build(2, 3)))

    puts "SUCCESS: all tests pass"
end
