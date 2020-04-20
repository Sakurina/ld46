lume = require "deps/lume"
lovebird = require "deps/lovebird"
Object = require "deps/classic"
json = require "deps/json"
require("deps/tesound")
patchy = require('deps/patchy')
require("helpers")
-- game logic
require("_stories/story_precondition")
require("_stories/story")
require("_stories/story_y0-0_pretitle")
require("_stories/story_y1-1_first_contact")
require("_stories/story_y1-2_city_intro")
require("_stories/story_y2-1_upgrade")
require("_stories/story_y2-2_headpats")
require("_stories/story_y3-1_help_pt1")
require("_stories/story_y3-2_midway_checkup")
require("_stories/story_y4-1_alone")
require("_stories/story_y4-2_borgar")
require("_stories/story_y5-1_sickness_health")
require("_stories/story_y5-2_help_pt2")
require("_stories/story_y6-2_goodbye")
require("_stories/story_y7-0_trueend")
require("_stories/story_y7-1_alchemistend")
require("_stories/story_y7-2_chefend")
require("_stories/story_y7-3_pirateend")
require("_stories/story_y7-3_salarymanend")
require("_stories/story_y7-4_badend")
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
require("layer_prologue")
require("layer_names")
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
    local initial_layer = PrologueLayer(PreTitleStory())
    layer_manager:prepend(initial_layer)
end

function love.draw()
    layer_manager:draw()
end

function love.update(dt)
    lovebird.update()
    layer_manager:update(dt)
    TEsound.cleanup()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "`" then
        love.graphics.captureScreenshot(os.time() .. ".png")
        return
    end
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