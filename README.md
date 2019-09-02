# themousery's 2D vector library

This library was made by me because I wasn't happy with other vector libraries for Lua. Functions largely based on the [PVector class from Processing](https://processing.org/reference/PVector.html), and the code syntax was helped by reference to [HUMP's Vector class](https://github.com/vrld/hump). 

_If you encounter any issues or bugs, raise an issue on Github or even make a pull request if you're a real trooper._

## Installation 

Put the [vector.lua](vector.lua?raw=1) file into your project and require it:

```lua
local vector = require("vector")
```

## Example
```lua
local vector = require("vector")
v = vector(100, 100) -- you can also use vector.new()
print(v) -- will print "(100, 100)"

-- do some cool stuff with vectors!
```

## Functions
#### vector.new(x, y)
Returns a new `Vector` object with the given x and y values, or 0 if not given. You can also simply call `vector()`, that being whatever you've chosen to name the module.

#### vector.random()
Similar to `vector.new`, but returns a `Vector` which is pointing in a random direction.

#### vector.fromAngle(theta)
Creates a new `Vector` from an angle in radians. _Note: the y value of the vector is flipped from normal, since this library is specifically geared toward game development. Feel free to remove the `-` in `fromAngle` if you need to._

#### Vector:set(x, y)
Sets the x and y values of the used `Vector`. Either one can be `nil`, in which case, the value will not change.

#### Vector:replace(v)
Replaces the `x` and `y` values of the current vector to the `x` and `y` values of the given vector. Mostly used in other functions but I'm sure someone can find a use for it.

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

#### Vector:norm()
Normalizes the `Vector`. In other words, it sets it's magnitude to 1.

#### Vector:limit(max)
Limits the magnitude of the `Vector`. If it's current magnitude is greater than `max`, it sets the magnitude to `max`.

#### Vector:heading()
Returns the angle of rotation of the `Vector`.

#### Vector:rotate(theta)
Rotates the `Vector` by `theta`, which is in radians.

#### Vector:array()
Returns an array version of the vector. For example, `vector(50, 60):unpack()` would return `{50, 60}`

#### Vector:unpack()
Returns both the x and y values unpacked. Useful for function arguments. For example, `vector(50,60):unpack()` would return `50, 60`

### Meta Functions
You can add, subtract, multiply, divide, and compare vectors using the basic syntax.
If you don't know how meta functions work, [check this out](http://lua-users.org/wiki/MetatableEvents).

```lua
a = vector(50, 25)
b = vector(25, 50)
```
#### Negative:
`-a` Would return (-50, -25) in this case.

#### Adding:
`a + b` Would return (75, 75) in this case.

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