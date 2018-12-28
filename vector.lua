local module = {
  _version = "vector.lua v0.0.1",
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

local vector = {}
vector.__index = vector

local rand = math.random
if love and love.math then rand = love.math.random end

local function new(x,y)
  return setmetatable({x=x or 0, y=y or 0}, vector)
end


local function fromAngle(theta)
  return new(math.cos(theta), -math.sin(theta))
end

local function random()
  return fromAngle(rand() * math.pi*2)
end

local function isvector(t)
  return getmetatable(t) == vector
end

function vector:set(x,y)
  if isvector(x) then self.x, self.y = x.x, x.y;return end
  self.x, self.y = x or self.x, y or self.y
  return self
end

function vector:replace(v)
  assert(isvector(v), "replace: wrong argument type: (expected <vector>, got "..type(v)..")")
  self.x, self.y = v.x, v.y
  return self
end

function vector:clone()
  return new(self.x, self.y)
end

function vector:getmag()
  return math.sqrt(self.x^2 + self.y^2)
end

function vector:magSq()
  return self.x^2 + self.y^2
end

function vector:setmag(mag)
  self:norm()
  local v = self * mag
  self:replace(v)
  return self
end

function vector.__unm(v)
  return new(-v.x, -v.y)
end

function vector.__add(a,b)
  assert(isvector(a) and isvector(b), "add: wrong argument types: (expected <vector> and <vector>)")
  return new(a.x+b.x, a.y+b.y)
end

function vector.__sub(a,b)
  assert(isvector(a) and isvector(b), "sub: wrong argument types: (expected <vector> and <vector>)")
  return new(a.x-b.x, a.y-b.y)
end

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

function vector.__div(a,b)
  assert(isvector(a) and type(b) == "number", "div: wrong argument types (expected <vector> and <number>)")
  return new(a.x/b, a.y/b)
end

function vector.__eq(a,b)
  assert(isvector(a) and isvector(b), "eq: wrong argument types (expected <vector> and <vector>)")
  return a.x==b.x and a.y==b.y
end

function vector:__tostring()
  return "("..self.x..", "..self.y..")"
end

function vector.dist(a,b)
  assert(isvector(a) and isvector(b), "dist: wrong argument types (expected <vector> and <vector>)")
  return math.sqrt((a.x-b.x)^2 + (a.y-b.y)^2)
end

function vector:dot(v)
  assert(isvector(v), "dot: wrong argument type (expected <vector>)")
  return self.x * v.x + self.y * v.y
end

function vector:norm()
  local m = self:getmag()
  if m~=0 then
    self:replace(self / m)
  end
  return self
end

function vector:limit(max)
  assert(type(max) == 'number', "limit: wrong argument type (expected <number>)")
  local mSq = self:magSq()
  if mSq > max^2 then
    self:setmag(max)
  end
  return self
end

function vector:heading()
  return -math.atan2(self.y, self.x)
end

function vector:rotate(theta)
  local m = self:getmag()
  self:replace(fromAngle(self:heading() + theta))
  self:setmag(m)
  return self
end

function vector:array()
  return {self.x, self.y}
end

function vector:unpack()
  return self.x, self.y
end


module.new = new
module.random = random
module.fromAngle = fromAngle
module.isvector = isvector
return setmetatable(module, {__call = function(_,...) return new(...) end})