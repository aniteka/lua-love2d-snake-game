Vector = require("Tools.Vector")
FrameLimitFunction = require("Tools.FrameLimiter")
require("Snake")

function love.load()
    WINDOW = {
        size = Vector(500,500);
        update_frame_limit = 2;
        title = "Snake Game";
        background = {1,1,1};
        params = {};
    }
    TILE = Vector(50,50)
    apple = Vector(3,3)
    apple.color = {1,0,0}


    love.window.setMode( WINDOW.size.x, WINDOW.size.y, WINDOW.params)
    love.window.setTitle(WINDOW.title)
end

function love.keypressed( _, scancode, _)
    Snake:KeyCheck(scancode)
end

function love.update(dt)
    FrameLimitFunction(WINDOW.update_frame_limit, dt, function()
        Snake:Update()
        Snake:CollisionCheck(Vector(
                WINDOW.size.x / TILE.x,
                WINDOW.size.y / TILE.y));
        Snake:EatAppleCheck(apple, Vector(
                WINDOW.size.x / TILE.x,
                WINDOW.size.y / TILE.y));

    end)
end

function love.draw()
    love.graphics.clear(WINDOW.background)

    Snake:Draw(TILE)

    val = apple * TILE
    love.graphics.setColor(apple.color)
    love.graphics.rectangle("fill", val.x, val.y, TILE.x, TILE.y)
end
