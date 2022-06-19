Vector = require("Tools.Vector")
---@type Tools.Vector[]|table
Snake = {}
Dir = {up = 1, down = 2, left = 3, right = 4}

-- Tail
Snake[#Snake + 1] = Vector(3, 0)
Snake[#Snake + 1] = Vector(2, 0)
Snake[#Snake + 1] = Vector(1, 0)

-- Colors
Snake.head_color = {0, 1, 0}
Snake.tail_color = {0, 1, 0, 0.5}

-- Dir
Snake.dir = Dir.right;

function Snake:Update()
    for i = #self, 2, -1 do
        self[i]:SetByVec( self[i - 1] )
    end

    if self.dir == Dir.right       then self[1]:Move(1, 0)
    elseif self.dir == Dir.left    then self[1]:Move(-1, 0)
    elseif self.dir == Dir.up      then self[1]:Move(0, -1)
    elseif self.dir == Dir.down    then self[1]:Move(0, 1)
    end

end

---@param TILE Tools.Vector
function Snake:Draw(TILE)
    assert(type(TILE) == "table")
    for key, val in ipairs(self) do
        if key == 1 then
            love.graphics.setColor(self.head_color)
        else
            love.graphics.setColor(self.tail_color)
        end
        val = val * TILE;
        love.graphics.rectangle("fill", val.x, val.y, TILE.x, TILE.y)
    end
end

---@param FieldSize Tools.Vector
function Snake:CollisionCheck(FieldSize)
    for i, val in ipairs(self) do
        if val.x >= FieldSize.x         then val:SetX(0)
        elseif val.x < 0                then val:SetX(FieldSize.x - 1)
        elseif val.y >= FieldSize.y     then val:SetY(0)
        elseif val.y < 0                then val:SetY(FieldSize.y - 1)
        end
    end

    for i = #self, 2, -1 do
        if self[i] == self[1] then
            while #self ~= i - 1 do
                table.remove(self)
            end
        end
    end
end

---@param key string
function Snake:KeyCheck(key)
    if      key == "d" and self.dir ~= Dir.left     then self.dir = Dir.right
    elseif  key == "a" and self.dir ~= Dir.right    then self.dir = Dir.left
    elseif  key == "w" and self.dir ~= Dir.down     then self.dir = Dir.up
    elseif  key == "s" and self.dir ~= Dir.up       then self.dir = Dir.down
    end
end


---@param apple Tools.Vector
---@param field_size Tools.Vector
function Snake:EatAppleCheck(apple, field_size)
    for i, val in ipairs(self) do
        if val == apple then
            self[#self + 1] = Vector(-1, -1)
            apple:Set(math.random(0, field_size.x - 1), math.random(0, field_size.y - 1))
        end
    end
end