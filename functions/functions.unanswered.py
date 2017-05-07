#!/usr/bin/env python


# This exercise is to get used to using simple first-class functions
# (lambdas).  Replace the "TODO" strings until all tests pass.

identity = "TODO"

assert(identity("foo") == "foo")

const = "TODO"

assert(const(True)("ignored"))

# Here's a normal Python lambda, but it takes two arguments at once.  This
# form of taking multiple arguments is called "uncurried."

addUncurriedPy = \
    lambda a, b: str("(") + str(a) + str(" + ") + str(b) + str(")")

# We can write a version of it that is in a "curried" form, meaning we create
# a cascade of one-argument functions, each returning another until we have
# our final answer:

addCurried = lambda a: lambda b: addUncurriedPy(a, b)

# You can read a little bit about the history of currying on Wikipedia:
# https://en.wikipedia.org/wiki/Currying#History

# Writing a function in different forms for every function is tedious, so it
# would be nice to have functions to help us generically.  Try to implement
# them.

curryPy = "TODO"

assert(curryPy(addUncurriedPy)(1)(2) == "(1 + 2)")

# Notice how a curried function can be "partially applied" by passing some of
# the arguments, but not all

add1 = curryPy(addUncurriedPy)(1)

# And we can use this partially applied function repeatedly with different
# remaining arguments:

assert(add1(2) == "TODO")
assert(add1(3) == "TODO")

# Just as we can curry an uncurried function, we can uncurry a curried one:

uncurryPy = "TODO"

assert(uncurryPy(addCurried)(1, 2) == "(1 + 2)")

# Currying and uncurrying are inverse operations:

assert(uncurryPy(curryPy(addUncurriedPy))(1, 2) == addUncurriedPy(1, 2))
assert(curryPy(uncurryPy(addCurried))(1)(2) == addCurried(1)(2))

# Python has multiple-argument functions and lambdas, but the original
# lambda-calculus only has single-argument functions.  We can get a similar
# effect by passing into the single argument a tuple:

addUncurriedTuple = lambda t: addUncurriedPy(t[0], t[1])

# See if you can curry this tuple-accepting function:

curryTuple = "TODO"

assert(curryTuple(addUncurriedTuple)(1)(2) == "(1 + 2)")

# You should be able to uncurry it too:

uncurryTuple = "TODO"

assert(uncurryTuple(addCurried)((1, 2)) == "(1 + 2)")

# Currying and uncurrying should still be inverse operations:

assert(uncurryTuple(curryTuple(addUncurriedTuple))((1, 2)) == "(1 + 2)")
assert(curryTuple(uncurryTuple(addCurried))(1)(2) == "(1 + 2)")

# We could implement a "swap" function:

swap = "TODO"

assert(swap(addUncurriedPy)(1, 2) == "(2 + 1)")

# But swap only works on exactly 2-argument functions.  With currying, we can
# write a similar function called "flip":

flip = "TODO"

assert(flip(addCurried)("1")("2") == "(2 + 1)")

# Notice how currying makes flip work, even when remaining arguments are
# needed:

moreArgs = lambda a: lambda b: lambda c: lambda d: \
    "{} {} {} {}".format(a, b, c, d)

assert(flip(moreArgs)("a")("b")("c")("d") == "TODO")

# We can make a function to compose two functions together:

compose = "TODO"

assert(compose(addCurried("a"))(addCurried("b"))("c") == "(a + (b + c))")

# See if you can predict what the following return:

assert(compose(flip(addCurried)("a"))(flip(addCurried)("b"))("c") == "TODO")
assert(compose(flip(addCurried)("a"))((addCurried)("b"))("c") == "TODO")
assert(compose((addCurried)("a"))(flip(addCurried)("b"))("c") == "TODO")

# We can write a similar function "andThen" to compose that takes arguments in
# the reverse order.  See if you can write it in terms of "flip" and
# "compose":

andThen = "TODO"

assert(andThen(addCurried("a"))(addCurried("b"))("c") == "(b + (a + c))")

# See if you can predict what the following return:

assert(andThen(flip(addCurried)("a"))(flip(addCurried)("b"))("c") == "TODO")
assert(andThen(flip(addCurried)("a"))((addCurried)("b"))("c") == "TODO")
assert(andThen((addCurried)("a"))(flip(addCurried)("b"))("c") == "TODO")

# That's all for now.  If you successfully replaced all the "TODO" strings,
# you should be able to run this script and see the following message:

print("Success!")
