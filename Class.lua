require "tprint"

------------------------------------------------------------
-- func
------------------------------------------------------------

function Class(static)
	local self = static or {}
	local _methods = {}

	local cls = {
		_static  = self;
		_methods = _methods;
	}

	local meta_cls = {
		__index = self;
		__newindex = _methods;
		__call = function (cls, ...)
			local obj = {}
			local meta_obj = {
				__index = function (t, k)
					local value = _methods[k]
					local t_value = type(value)
					if (t_value == "function") then
						return function (...)
							return value(obj, ...)
						end
					end
				end
			}
			setmetatable(obj, meta_obj)
			assert(obj.init, "Must implement constructor: Class.init")
			obj.init(...)
			return obj
		end
	}
	return setmetatable(cls, meta_cls)
end

------------------------------------------------------------
-- TEST def
------------------------------------------------------------

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

------------------------------------------------------------
-- test run
------------------------------------------------------------

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
