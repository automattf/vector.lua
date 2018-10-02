local vector = {}
vector.__index = vector

local function new(x,y)
  return setmetatable({x=x or 0, y=y or 0}, vector)
end

local function random()
  return new(math.random(), math.random())
end

local function fromAngle(theta)
  return new(math.cos(theta), math.sin(theta))
end

local function isvector(t)
  return getmetatable(t) == vector
end

function vector:set(x,y)
  self.x, self.y = x or self.x, y or self.y
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
  self:set(v.x,v.y)
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
  return math.sqrt((v.x-self.x)^2 + (v.y-self.y)^2)
end

function vector:dot(v)
  assert(isvector(v), "dot: wrong argument type (expected <vector>)")
  return self.x * v.x + self.y * v.y
end

function vector:cross()
  
end

function vector:norm()
  local m = self:getMag()
  if m~=0 then
    self:div(m)
  end
end

function vector:limit(max)
  assert(type(max) == 'number', "limit: wrong argument type (expected <number>)")
  local mSq = self:magSq()
  if mSq > max^2 then
    self:setmag(max)
  end
end

function vector:heading()
  return math.atan2(self.y, self.x)
end

function vector:rotate(theta)
  return fromAngle(self:heading() + theta)
end

function vector:array()
  return {self.x, self.y}
end

return setmetatable({
  new = new,
  random = random,
  fromAngle = fromAngle,
  isvector = isvector
},
{
  __call = function(_,...) return new(...) end
})