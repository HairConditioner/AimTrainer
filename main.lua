local target = {}

local score

local font

local background

local sound = love.audio.newSource("assets/pop.wav", "stream")

local music

local shouldShow = false;

love.window.setTitle("Aim Trainer - Conditioner")
love.window.setIcon(love.image.newImageData("assets/icon.png"))

function love.load()
    target.x = 300
    target.y = 300
    target.radius = 50
    score = 0
    font = love.graphics.newFont(40)
    background = love.graphics.newImage("assets/background.png")
    music = love.audio.newSource("assets/music.mp3", "stream")
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    
    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    love.graphics.setColor(0, 1, 0)
    love.graphics.setFont(font)
    love.graphics.print(score, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", 0, 485, 300, 110)

    love.graphics.setColor(1, 0, 0)
    love.graphics.print("Playing:", 0, 490)

    love.graphics.setColor(1, 1, 1)
    if music:isPlaying() then
        shouldShow = true
    end
    if shouldShow then
        love.graphics.print("music.mp3", 0, 550)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local mouseToTarget = distance(x, y, target.x, target.y)

        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
            sound:setVolume(0.3)
            if sound:isPlaying() then
                sound:stop()
                sound:play()
            else
                sound:play()
            end
        end
        music:play()
    end
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end