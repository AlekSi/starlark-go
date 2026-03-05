load("assert.star", "assert")

# option:pipe

def add1(x):
    return x + 1

def add(x, y):
    return x + y

obj = struct(f = add1)

assert.eq(1 |> add1, 2)
assert.eq(1 |> add1 |> add1, 3)
assert.eq(1 |> add(2), 3)
assert.eq(1 |> obj.f, 2)
assert.eq(1 |> obj.f(), 2)

# `|>` has the same precedence as `or` and is left-associative.
assert.eq((0 or 1) |> add1, 2)
assert.eq((1 |> add1) or 0, 2)

events = []

def lhs():
    events.append("lhs")
    return 3

def arg():
    events.append("arg")
    return 4

def add_logged(x, y):
    events.append("call")
    return x + y

def getobj():
    events.append("callee")
    return struct(f = add_logged)

assert.eq(lhs() |> getobj().f(arg()), 7)
assert.eq(events, ["lhs", "callee", "arg", "call"])
