def testList(impl):

    def eq_py(a, b): return a == b

    def eq_list_py(a, b): return impl.eq(eq_py, a, b)

    def eq_list_list_py(a, b):
        return impl.eq(lambda c, d: impl.eq(eq_py, c, d), a, b)

    def is_eq(a, b): assert(eq_py(a, b))

    def is_eq_list(a, b): assert(eq_list_py(a, b))

    def is_eq_list_list(a, b): assert(eq_list_list_py(a, b))

    def is_not_eq_list(a, b): assert(not eq_list_py(a, b))

    def is_eq_tuple_py_list(a, b):
        is_eq(a[0], b[0])
        is_eq_list(a[1], b[1])

    is_eq_list(impl.new(), impl.new())
    is_eq_list(impl.new(1), impl.new(1))
    is_not_eq_list(impl.new(), impl.new(1))
    is_not_eq_list(impl.new(1), impl.new())

    is_eq(impl.match(impl.new(), 1, lambda h, t: 2), 1)
    is_eq_tuple_py_list(
        impl.match(
            impl.new(1, 2, 3),
            (4, impl.new(5)),
            lambda h, t: (h, t)),
        (1, impl.new(2, 3)))

    is_eq(impl.repr(impl.new()), '[]')
    is_eq(impl.repr(impl.new(1, 2, 3)), '[1, 2, 3]')

    is_eq(impl.toPyList(impl.new()), [])
    is_eq(impl.toPyList(impl.new(1, 2, 3)), [1, 2, 3])

    is_eq_list(
        impl.append(
            impl.new(1, 2),
            impl.new(3, 4)),
        impl.new(1, 2, 3, 4))

    is_eq(impl.length(impl.new()), 0)
    is_eq(impl.length(impl.new(1, 2, 3)), 3)

    assert(impl.all(impl.new(), lambda a: a == 3))
    assert(impl.all(impl.new(1, 2, 3, 4), lambda a: a > 0))
    assert(not impl.all(impl.new(1, 2, 3, 4), lambda a: a == 3))
    assert(not impl.all(impl.new(1, 2, 3, 4), lambda a: a == 5))

    assert(not impl.any(impl.new(), lambda a: a == 3))
    assert(impl.any(impl.new(1, 2, 3, 4), lambda a: a == 2))
    assert(not impl.any(impl.new(1, 2, 3, 4), lambda a: a == 5))

    is_eq_list(impl.map(impl.new(1, 2), lambda x: x+1), impl.new(2, 3))

    is_eq_list(
        impl.flatMap(
            impl.new(1, 2),
            lambda x: impl.new(x*10, x*100)),
        impl.new(10, 100, 20, 200))

    is_eq_list(
        impl.flatten(impl.new(impl.new())),
        impl.new())
    is_eq_list(
        impl.flatten(
            impl.new(
                impl.new(1, 2),
                impl.new(3, 4))),
        impl.new(1, 2, 3, 4))

    is_eq_list(
        impl.keep(
            impl.new(1, 2, 3, 4),
            lambda a: a % 2 == 0),
        impl.new(2, 4))

    is_eq_list(
        impl.discard(
            impl.new(1, 2, 3, 4),
            lambda a: a % 2 == 0),
        impl.new(1, 3))

    is_eq_list(impl.headList(impl.new()), impl.new())
    is_eq_list(impl.headList(impl.new(1, 2, 3)), impl.new(1))
    is_eq_list(impl.headList(impl.new()), impl.new())
    is_eq_list(impl.headList(impl.new(1, 2, 3)), impl.new(1))

    is_eq(impl.headOrElse(impl.new(), 4), 4)
    is_eq(impl.headOrElse(impl.new(1, 2, 3), 4), 1)

    is_eq_list(impl.tailList(impl.new()), impl.new())
    is_eq_list_list(impl.tailList(impl.new(1, 2, 3)), impl.new(impl.new(2, 3)))

    is_eq_list(impl.reverse(impl.new()), impl.new())
    is_eq_list(impl.reverse(impl.new(1, 2, 3)), impl.new(3, 2, 1))

    is_eq_list(
        impl.discardFirst(
            impl.new(1, 2, 3, 4),
            lambda a: a % 2 == 0),
        impl.new(1, 3, 4))

    is_eq_list(
        impl.takeWhile(
            impl.new(1, 2, 3, 4),
            lambda a: a < 3),
        impl.new(1, 2))
    is_eq_list(
        impl.takeWhile(
            impl.new(1, 2, 3, 4),
            lambda a: a > 5),
        impl.new())

    is_eq_list(
        impl.dropWhile(
            impl.new(1, 2, 3, 4),
            lambda a: a < 3),
        impl.new(3, 4))
    is_eq_list(
        impl.dropWhile(
            impl.new(1, 2, 3, 4),
            lambda a: a < 5),
        impl.new())

    is_eq_list(impl.drop(impl.new(), 0), impl.new())
    is_eq_list(impl.drop(impl.new(1, 2, 3, 4), 0), impl.new(1, 2, 3, 4))
    is_eq_list(impl.drop(impl.new(1, 2, 3, 4), 2), impl.new(3, 4))
    is_eq_list(impl.drop(impl.new(1, 2, 3, 4), 5), impl.new())

    is_eq_list(impl.take(impl.new(), 0), impl.new())
    is_eq_list(impl.take(impl.new(1, 2, 3, 4), 0), impl.new())
    is_eq_list(impl.take(impl.new(1, 2, 3, 4), 2), impl.new(1, 2))
    is_eq_list(impl.take(impl.new(1, 2, 3, 4), 5), impl.new(1, 2, 3, 4))

    is_eq_list(
        impl.zipWith(
            impl.new(1, 2, 3),
            impl.new(10, 20, 30),
            lambda a, b: a + b),
        impl.new(11, 22, 33))

    print("SUCCESS: all tests pass")
