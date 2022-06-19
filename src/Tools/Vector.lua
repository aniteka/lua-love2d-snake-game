---@module Tools.Vector
local Vector = {
    x = 0;
    y = 0;
}
local VectorLocalMetaTable = {
    ---@param x number
    ---@param y number
    __call = function(self, x, y)
        return Vector.New(x, y);
    end
}
Vector.MT = {
    __index = Vector;
    __metatable = "Vector MetaTable";
    __add = function(self, obj)
        return Vector.New(self.x + obj.x, self.y + obj.y);
    end;
    __mul = function(self, obj)
        return Vector.New(self.x * obj.x, self.y * obj.y);
    end;
    __tostring = function(self)
        return "["..self.x..";"..self.y.."]";
    end;
    __eq = function(self, obj)
        return self.x == obj.x and self.y == obj.y
    end;
}
setmetatable(Vector, VectorLocalMetaTable);


---@param x number
---@param y number
function Vector.New(x, y)
    local obj = {}
    setmetatable(obj, Vector.MT);
    obj.x = x;
    obj.y = y;
    return obj;
end


---@param x number
---@param y number
function Vector:Set(x, y)
    assert(type(x) == "number")
    assert(type(y) == "number")
    self.x = x;
    self.y = y;
    return self;
end
---@param vec Tools.Vector
function Vector:SetByVec(vec)
    assert(type(vec) == "table")
    self.x = vec.x;
    self.y = vec.y;
    return self;
end
---@param x number
function Vector:SetX(x)
    return Vector.Set(self, x, self.y);
end
---@param y number
function Vector:SetY(y)
    return Vector.Set(self, self.x, y);
end



---@param dx number
---@param dy number
function Vector:Move(dx, dy)
    assert(type(dx) == "number")
    assert(type(dy) == "number")
    self.x = self.x + dx;
    self.y = self.y + dy;
    return self;
end



return Vector;