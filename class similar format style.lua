
require "tprint"
function test( ... )
	print(555, ...)
end

function test2( ... )
	print(222, ...)
	return
end


function class( ... )
	print(111, ...)
	return {aaa=test}
end

function static( ... )
	print(222, ...)
	return test2
end

x = "s"

tprint{
static [[x=1]];
class [[MyClass]] : aaa ()
}

class [[MyClass]] : aaa {
	static [[x=1]];
	x = 1;
	y = 2;
}
