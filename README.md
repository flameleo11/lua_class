# lua_class
lua implement different class styles by various features of lua

simple basic style

```lua

local Point = Class()

Point.init = function (this, x, y)
	this.x = x
	this.y = y
end

Point.add = function (this, bPoint)
	this.x = this.x + bPoint.x
	this.y = this.y + bPoint.y
	return this
end

```

test

```lua
-- obj = setmetatable({}, mt) --MyClass()
local a = Point(1,2)
local b = Point(3,4)

tprint{
	Point;
	a;
	b;
	a.init;
	b.add;
}

tprint{
	a.add(b);
}
```json
output:
__noname__ = {
  [1] = {
    ["_methods"] = {
      ["add"] = "function: 0x55d12059fc70";
      ["init"] = "function: 0x55d12059fc10";
    }
    ["_static"] = {};
  }
  [2] = {
    ["x"] = 1;
    ["y"] = 2;
  }
  [3] = {
    ["x"] = 3;
    ["y"] = 4;
  }
  [4] = "function: 0x55d1205a00e0";
  [5] = "function: 0x55d1205a0120";
}
__noname__ = {
  [1] = {
    ["x"] = 4;
    ["y"] = 6;
  }
}
[Finished in 0.0s]

```

beta style 1 (similar normal c/c++ or java style)

```lua

class [[MyClass]] : aaa {
	static [[x=1]];
	x = 1;
	y = 2;
}

```

beta test output

```json

222	x=1
111	MyClass
555	table: 0x55c04bf569f0
__noname__ = {
  [1] = "function: 0x55c04bf568c0";
}
111	MyClass
222	x=1
555	table: 0x55c04bf546e0	table: 0x55c04bf54750
[Finished in 0.0s]

```

