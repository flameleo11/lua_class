require "tprint"


-- mt = {
-- 	__call = function (base, ...)
-- 		local mt = {
-- 			__index = base
-- 		}
-- 		return setmetatable({}, mt)
-- 	end
-- }

-- Event = setmetatable({}, mt)

-- create lua clase by select chraret



function CreateObject(classTable)
	local static = data or {}
	print(111, static, data)
	local cls_meta = {
		__index = static;
		__call = function (self, ...)
			print(333, self, ...)


			return {}
		end
	}
	local cls_mem = {}
	print(222, cls_mem)
	return setmetatable(cls_mem, cls_meta)
end


		-- __index = function (t, k)
		-- 	return function (this, ...)
		-- 		_methods[k]()
		-- 	end
		-- end

-- class _C
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
			print("111obj", obj, cls, _methods, ...)
			local meta_obj = {
				__index = function (t, k)
					print("aa11", t, k)
					local value = _methods[k]
					local t_value = type(value)
					print("aa1122", value, t_value, _methods)
					if (t_value == "function") then
						print("aa11333", value, t_value, _methods)
						return function (...)
							return value(obj, ...)
						end
					end
					print("aa11444", value, t_value, _methods) return value
				end
			}
			setmetatable(obj, meta_obj)
			assert(obj.init, "must have create function")
			-- create stucture funtion
			print("obj.init", obj.init)
			obj.init(...)

			print(333, cls, ...)
			print(444, cls)

			return obj
		end
	}
	print(222, cls)
	return setmetatable(cls, meta_cls)
end

-- local mt = {
-- 		__call = function test(xxx)
-- 			-- body
-- 		end

-- 	}


local MyClass = CreateClass{
	count = 123;
	name = "xxxx MyClass"
}

MyClass.init = function (this, x, y, z)
	print(111, this, x, y, z)
	this.x = x
	this.y = y
	this.z = z
end


print("MyClass.init", MyClass._methods.init)

MyClass.add = function (this, x, y, z)
	this.x = this.x + x
	this.y = this.y + y
	this.z = this.z + z
end




mt = {
	__index = MyClass
}




-- obj = setmetatable({}, mt) --MyClass()
obj = MyClass(1,2,3)

tprint{
	obj;
	MyClass;
	MyClass.name;
	obj.init;
	obj.add;

	-- MyClass.add(1,2,3)  -- todo static call
}

obj.add(1,2,3)

tprint{
	obj;
	obj.name;
	obj.add;
}
