
local push = table.insert
local tjoin = table.concat
local for_serialize = false
-- for trace debug
local quote_fmt = [["%s"]]
-- for serialize
if (for_serialize) then
	quote_fmt = "%q"
end

local function mulstr(s, n)
	-- local arr = {}
	-- for i=1,n do
	-- 	push(arr, s)
	-- end
	-- return tjoin(arr) or ""
	return s:rep(n)
end

local function scan_table(t, name, indent, verbose)
	name = name or "__noname__"
	indent = indent or "  "

	local arr = {}
	local tmp = {}	-- accessed table

	local function v2s(v)
		local s = tostring(v)
		if (type(v) == "number")
			or (type(v) == "boolean") then
			return s
		end
		return string.format(quote_fmt, s)
	end

	local function isemptytable(t)
		-- counts the number of elements in a table by pairs or ipairs
		return next(t) == nil
	end

	local function itor(k, v, n, path)
		path = path or k
		n = n or 0

		local tv = type(v)
		local pfx = indent:rep(n)
		local sfx = verbose and " -- "..path or ""

		if (tv == "table") then
			if (tmp[v]) then
				push(arr, pfx..k.." = {} -- "..tmp[v])
			else
				tmp[v] = path

				if (isemptytable(v)) then
					push(arr, pfx..k.." = {};"..sfx)
				else
					push(arr, pfx..k.." = {"..sfx)
					local path2
					for k2, v2 in pairs(v) do
						k2 = ("[%s]"):format(v2s(k2))
						path2 = path..k2
						itor(k2, v2, n+1, path2)
					end
					push(arr, pfx.."}")
				end
			end
		else
			push(arr, pfx..k.." = "..v2s(v)..";"..sfx)
		end

	end
	-- update arr
	itor(name, t, 0)
	return arr;
end

function tprint(t, name, indent, verbose)
	local arr = scan_table(t, name, indent, verbose)
	for i, line in ipairs(arr) do
		print(line)
	end

	-- local str = tjoin(arr, '\n')
	-- print(string.sub(str, 1, 65535))
end


-- local t = {
-- 	a = 1,
-- 	b = 2,
-- 	c = {},
-- 	d1 = {},
-- 	d2 = {
-- 		x1 = t2;
-- 		x2 = {
-- 			t2
-- 		}
-- 	},
-- 	d = {
-- 		a2 = 5,
-- 		b2 = 6,
-- 	},
-- }

-- t[1] = t.d

-- tprint(t)
-- tprint(t, nil, nil, true)

-- local arr = scan_table(t, nil, "..")
-- for i,v in ipairs(arr) do
-- 	print(v)
-- end

-- print(tjoin(arr, '\n'))


