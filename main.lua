lume = require "deps/lume"
lovebird = require "deps/lovebird"
Object = require "deps/classic"
json = require "deps/json"
anim8 = require "deps/anim8"
require("deps/tesound")
require('deps/camera')
require("helpers")
require("layer")
require("layermanager")
require("layer_transition")
require("layer_controls_overlay")
require("layer_controls")
require("layer_menu")
require("constants")

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.keyboard.setKeyRepeat(true)
    layer_manager = LayerManager()
    layer_manager:reload_controls()
    local initial_layer = MenuLayer()
    layer_manager:prepend(initial_layer)
end

function love.draw()
    layer_manager:draw()
end

function love.update(dt)
    lovebird.update()
    layer_manager:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    layer_manager:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    layer_manager:keyreleased(key, scancode)
end
