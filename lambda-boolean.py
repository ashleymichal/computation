trueL = lambda a: lambda b: a
falseL = lambda a: lambda b: b

py2l = lambda value: trueL if value else falseL
l2py = lambda l: l(True)(False)

notL = lambda x: x(falseL)(trueL)
assert(not l2py(notL(trueL)))
assert(l2py(notL(falseL)))

equalsL = lambda a: lambda b: a(b(trueL)(falseL))(b(falseL)(trueL))
assert(l2py(equalsL(trueL)(trueL)))
assert(not l2py(equalsL(trueL)(falseL)))
assert(l2py(equalsL(falseL)(falseL)))
assert(not l2py(equalsL(falseL)(trueL)))

andL = lambda a: lambda b: a(b(trueL)(falseL))(falseL)

assert(l2py(andL(trueL)(trueL)))
assert(not l2py(andL(trueL)(falseL)))
assert(not l2py(andL(falseL)(trueL)))
assert(not l2py(andL(falseL)(falseL)))

orL = lambda a: lambda b: a(trueL)(b(trueL)(falseL))

assert(l2py(orL(trueL)(trueL)))
assert(l2py(orL(trueL)(falseL)))
assert(l2py(orL(falseL)(trueL)))
assert(not l2py(orL(falseL)(falseL)))

print("Success!")
