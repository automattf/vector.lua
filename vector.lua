
---@class vector.lua
---@overload fun(x: number?, y: number): Vector.lua
local module = {
  _version = "vector.lua v2019.14.12",
  _description = "a simple vector library for Lua based on the PVector class from processing",
  _url = "https://github.com/themousery/vector.lua",
  _license = [[
    Copyright (c) 2018 themousery

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
  ]]
}

-- create the module
---@class Vector.lua
---@operator add: Vector.lua
---@operator sub: Vector.lua
---@operator mul: Vector.lua
---@operator div: Vector.lua
---@operator unm: Vector.lua
local vector = {}
vector.__index = vector

-- get a random function from Love2d or base lua, in that order.
local rand = math.random
if love and love.math then rand = love.math.random end

--- makes a new vector
---@param x number?
---@param y number?
---@return Vector.lua
local function new(x,y)
  return setmetatable({x=x or 0, y=y or 0}, vector)
end

--- makes a new vector from an angle
---@param theta number
---@return Vector.lua
local function fromAngle(theta)
  return new(math.cos(theta), -math.sin(theta))
end

--- makes a vector with a random direction
---@return Vector.lua
local function random()
  return fromAngle(rand() * math.pi*2)
end

--- check if an object is a vector
---@param t any
---@return boolean
local function isvector(t)
  return getmetatable(t) == vector
end

--- set the values of the vector to something new
---@param x number
---@param y number
---@overload fun(self: Vector.lua, vec: Vector.lua): self
---@return self
function vector:set(x,y)
---@diagnostic disable-next-line: undefined-field
  if isvector(x) then self.x, self.y = x.x, x.y; return self end
  self.x, self.y = x or self.x, y or self.y
  return self
end

--- replace the values of a vector with the values of another vector
---@param v Vector.lua
---@return self
function vector:replace(v)
  assert(isvector(v), "replace: wrong argument type: (expected <vector>, got "..type(v)..")")
  self.x, self.y = v.x, v.y
  return self
end

--- returns a copy of a vector
---@return Vector.lua
function vector:clone()
  return new(self.x, self.y)
end

--- get the magnitude of a vector
---@return number
function vector:getmag()
  return math.sqrt(self.x^2 + self.y^2)
end

--- get the magnitude squared of a vector
---@return number
function vector:magSq()
  return self.x^2 + self.y^2
end

--- set the magnitude of a vector
---@return self
function vector:setmag(mag)
  assert(self:getmag() ~= 0, "Cannot set magnitude when direction is ambiguous")
  self:norm()
  local v = self * mag
  self:replace(v)
  return self
end

--- meta function to make vectors negative
--- ex: (negative) -vector(5,6) is the same as vector(-5,-6)
---@param v Vector.lua
---@return Vector.lua
function vector.__unm(v)
  return new(-v.x, -v.y)
end

--- meta function to add vectors together
--- ex: (vector(5,6) + vector(6,5)) is the same as vector(11,11)
---@param a Vector.lua
---@param b Vector.lua
---@return Vector.lua
function vector.__add(a,b)
  assert(isvector(a) and isvector(b), "add: wrong argument types: (expected <vector> and <vector>)")
  return new(a.x+b.x, a.y+b.y)
end

--- meta function to subtract vectors
---@param a Vector.lua
---@param b Vector.lua
---@return Vector.lua
function vector.__sub(a,b)
  assert(isvector(a) and isvector(b), "sub: wrong argument types: (expected <vector> and <vector>)")
  return new(a.x-b.x, a.y-b.y)
end

--- meta function to multiply vectors
---@param a Vector.lua | number
---@param b Vector.lua | number
---@return Vector.lua
function vector.__mul(a,b)
  if type(a) == 'number' then
    return new(a * b.x, a * b.y)
  elseif type(b) == 'number' then
    return new(a.x * b, a.y * b)
  else
    assert(isvector(a) and isvector(b),  "mul: wrong argument types: (expected <vector> or <number>)")
    return new(a.x*b.x, a.y*b.y)
  end
end

--- meta function to divide vectors
---@param a Vector.lua | number
---@param b Vector.lua | number
---@return Vector.lua
function vector.__div(a,b)
  assert(isvector(a) and type(b) == "number", "div: wrong argument types (expected <vector> and <number>)")
  return new(a.x/b, a.y/b)
end

--- meta function to check if vectors have the same values
---@param a Vector.lua
---@param b Vector.lua
---@return boolean
function vector.__eq(a,b)
  assert(isvector(a) and isvector(b), "eq: wrong argument types (expected <vector> and <vector>)")
  return a.x==b.x and a.y==b.y
end

--- meta function to change how vectors appear as string
--- ex: print(vector(2,8)) - this prints '(2,8)'
---@return string
function vector:__tostring()
  return "("..self.x..", "..self.y..")"
end

--- get the distance between two vectors
---@param a Vector.lua
---@param b Vector.lua
---@return number
function vector.dist(a,b)
  assert(isvector(a) and isvector(b), "dist: wrong argument types (expected <vector> and <vector>)")
  return math.sqrt((a.x-b.x)^2 + (a.y-b.y)^2)
end

--- return the dot product of the vector
---@param v Vector.lua
---@return number
function vector:dot(v)
  assert(isvector(v), "dot: wrong argument type (expected <vector>)")
  return self.x * v.x + self.y * v.y
end

--- normalize the vector (give it a magnitude of 1)
---@return Vector.lua
function vector:norm()
  local m = self:getmag()
  if m~=0 then
    self:replace(self / m)
  end
  return self
end

--- limit the vector to a certain amount
---@param max number
---@return Vector.lua
function vector:limit(max)
  assert(type(max) == 'number', "limit: wrong argument type (expected <number>)")
  local mSq = self:magSq()
  if mSq > max^2 then
    self:setmag(max)
  end
  return self
end

--- Clamp each axis between max and min's corresponding axis
---@param min Vector.lua
---@param max Vector.lua
---@return Vector.lua
function vector:clamp(min, max)
  assert(isvector(min) and isvector(max), "clamp: wrong argument type (expected <vector>) and <vector>")
  local x = math.min( math.max( self.x, min.x ), max.x )
  local y = math.min( math.max( self.y, min.y ), max.y )
  self:set(x,y)
  return self
end

--- get the heading (direction) of a vector
---@return number
function vector:heading()
  return -math.atan2(self.y, self.x)
end

--- rotate a vector clockwise by a certain number of radians
---@param theta number
---@return Vector.lua
function vector:rotate(theta)
  local s = math.sin(theta)
  local c = math.cos(theta)
  local v = new(
                (c * self.x) + (s * self.y),
                -(s * self.x) + (c * self.y))
  self:replace(v)
  return self
end

--- return x and y of vector as a regular array
---@return { [1]: number, [2]: number }
function vector:array()
  return {self.x, self.y}
end

-- return x and y of vector, unpacked from table
---@return number, number
function vector:unpack()
  return self.x, self.y
end


-- pack up and return module
module.new = new
module.random = random
module.fromAngle = fromAngle
module.isvector = isvector
return setmetatable(module --[[@as table]], {__call = function(_,...) return new(...) end}) --[[@as vector.lua]]
