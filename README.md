# themousery's 2d vector library

This library was made by me because I wasn't happy with other vector libraries. Functions largely based on the [PVector class from Processing](https://processing.org/reference/PVector.html), and the code syntax was helped by reference to [HUMP's Vector class](https://github.com/vrld/hump). **WARING: I made this last night and have not tested it yet. Use at your own risk.**

## Installation 

Put the [vector.lua](vector.lua?raw=1) file into your project and require it:

```lua
vector = require("vector")
```

## Example
```lua
vector = require("vector")
v = vector(100, 100) -- you can also use vector.new()
print(v)
```

## Functions
#### vector.new(x, y)
Returns a new `Vector` object with the given x and y values, or 0 if not given. You can also simply call `vector()`, that being whatever you've chosen to name the module.

#### vector.random()
Similar to `vector.new`, but returns a `Vector` with random values for x and y.

#### vector.fromAngle(theta)
Creates a new `Vector` from an angle in radians.

#### Vector:set(x, y)
Sets the x and y values of the used `Vector`. Either one can be `nil`, in which case, the value will not change.

#### Vector:clone()
Returns a copy of the used `Vector`.

#### Vector:getmag()
Returns the magnitude of the `Vector`.

#### Vector:magSq()
Returns the squared magnitude of the `Vector`.

#### Vector:setmag(mag)
Sets the magnitude of the `Vector` to `mag`. In reality, this normalizes the `Vector` and multiplies it by `mag`.

#### Vector:dist(v)
Returns the two-dimensional distance between vector a and vector b.

#### Vector:dot(v)
Returns the [dot product](https://en.wikipedia.org/wiki/Dot_product) of the two `Vector`s.

#### Vector:cross(v)
Returns the [cross product](https://en.wikipedia.org/wiki/Cross_product) of the two `Vector`s.

#### Vector:norm()
Normalizes the `Vector`. In other words, it sets it's magnitude to 1.

#### Vector:limit(max)
Limits the magnitude of the `Vector`. If it's current magnitude is greater than `max`, it sets the magnitude to `max`.

#### Vector:heading()
Returns the angle of rotation of the `Vector`.

#### Vector:rotate(theta)
Rotates the `Vector` by `theta`, which in radians.

### Meta Functions
You can add, subtract, multiply, divide, and compare vectors using the basic syntax.
If you don't know how meta functions work, [check this out](http://lua-users.org/wiki/MetatableEvents).

```lua
a = vector(50,25)
b = vector(25,50)
```
#### Adding:
`a + b` Would return (75,75) in this case.

#### Subtracting:
`a - b` Would return (25, -25) in this case.

#### Multiplication:
`a * b` Would return (1250, 1250) in this case.

`a * 2` Would return (100, 50) in this case.

#### Division:
`a / b` Would return (2, 0.5) in this case.

#### Comparison:
`a == b` Would return false.

`vector(107,6) == vector(107,6)` Would return true.

#### \_\_tostring:
You can also easily get a human-readable string representation of the vector.
`print(a)` Would print `"(50, 25)"`
`tostring(b)` Would return `"(25, 50)"`