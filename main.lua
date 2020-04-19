lume = require "deps/lume"
lovebird = require "deps/lovebird"
Object = require "deps/classic"
json = require "deps/json"
anim8 = require "deps/anim8"
require("deps/tesound")
require('deps/camera')
patchy = require('deps/patchy')
require("helpers")
-- game logic
require("_stories/story_precondition")
require("_stories/story")
require("_stories/story_always_test")
require("_stories/story_precon_test")
require("_choices/lifestyle_choice")
require("_choices/lifestyle_choice_option")
require("_choices/test_choice")
require("_events/daily_event")
require("_events/black_event")
require("_events/cook_event")
require("_events/delivery_event")
require("_events/gym_event")
require("_events/karaoke_event")
require("_events/lab_event")
require("_events/library_event")
require("_events/nap_event")
require("_events/study_event")
require("_events/vacation_event")
require("_events/acct_event")
require("_events/resto_event")
require("game_state")
require("stat_growth")
require("calendar_day")
require("calendar")
-- layers
require("layer")
require("layermanager")
require("layer_transition")
require("layer_controls_overlay")
require("layer_controls")
require("layer_menu")
require("layer_lifestyle")
require("layer_schedule")
require("layer_stats")
require("layer_main")
require("constants")

function love.load()
    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()
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

function love.mousepressed(x, y, button, istouch, presses)
    layer_manager:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    layer_manager:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    layer_manager:mousemoved(x, y, dx, dy, istouch)
end