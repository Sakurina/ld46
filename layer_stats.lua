StatsLayer = Layer:extend()

function StatsLayer:new(stats)
    StatsLayer.super.new(self)
    self.layer_name = "StatsLayer"
    self.box_patch = patchy.load("gfx/textbox.9.png")
    self.propagate_input_to_underlying = false
    self.stats = stats
end

function StatsLayer:draw(dt)
    local box_scale = 3
    love.graphics.push()
    love.graphics.scale(box_scale, box_scale)
    love.graphics.setColor(1, 1, 1, 1)
    local txt_x, txt_y, txt_w, txt_h = self.box_patch:draw(0, 480 / box_scale, 1280 / box_scale, 240 / box_scale) -- textbox
    love.graphics.pop()

    txt_x = txt_x * box_scale
    txt_y = txt_y * box_scale
    local bar_width = 270
    local bar_height = 60

    local bar_empty_col = constants.db16_col4
    local bar_full_col = constants.db16_col14
    local bar_label_col = constants.system_txt_color

    local col1_x = txt_x + 30 + 15
    local col2_x = col1_x + bar_width + 30
    local col3_x = col2_x + bar_width + 30
    local col4_x = col3_x + bar_width + 30
    local row1_y = txt_y + 30 + 15
    local row2_y = row1_y + bar_height + 30

    -- empty bars
    love.graphics.setColor(bar_empty_col.r, bar_empty_col.g, bar_empty_col.b, 1)
    love.graphics.rectangle("fill", col1_x, row1_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col2_x, row1_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col3_x, row1_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col4_x, row1_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col1_x, row2_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col2_x, row2_y, bar_width, bar_height)
    love.graphics.rectangle("fill", col3_x, row2_y, bar_width, bar_height)

    local str_fill_width = bar_width * (self.stats["str"] / constants.stat_caps["str"])
    local int_fill_width = bar_width * (self.stats["int"] / constants.stat_caps["int"])
    local cha_fill_width = bar_width * (self.stats["cha"] / constants.stat_caps["cha"])
    local dex_fill_width = bar_width * (self.stats["dex"] / constants.stat_caps["dex"])
    local morality_fill_width = bar_width * (self.stats["morality"] / constants.stat_caps["morality"])
    local trust_fill_width = bar_width * (self.stats["trust"] / constants.stat_caps["trust"])
    local stress_fill_width = bar_width * (self.stats["stress"] / constants.stat_caps["stress"])

    love.graphics.setColor(bar_full_col.r, bar_full_col.g, bar_full_col.b, 1)
    love.graphics.rectangle("fill", col1_x, row1_y, str_fill_width, bar_height)
    love.graphics.rectangle("fill", col2_x, row1_y, int_fill_width, bar_height)
    love.graphics.rectangle("fill", col3_x, row1_y, cha_fill_width, bar_height)
    love.graphics.rectangle("fill", col4_x, row1_y, dex_fill_width, bar_height)
    love.graphics.rectangle("fill", col1_x, row2_y, morality_fill_width, bar_height)
    love.graphics.rectangle("fill", col2_x, row2_y, trust_fill_width, bar_height)
    love.graphics.rectangle("fill", col3_x, row2_y, stress_fill_width, bar_height)

    love.graphics.setColor(bar_label_col.r, bar_label_col.g, bar_label_col.b, 1)
    love.graphics.printf("STR", col1_x, row1_y, bar_width, "center")
    love.graphics.printf("INT", col2_x, row1_y, bar_width, "center")
    love.graphics.printf("CHA", col3_x, row1_y, bar_width, "center")
    love.graphics.printf("DEX", col4_x, row1_y, bar_width, "center")
    love.graphics.printf("Morality", col1_x, row2_y, bar_width, "center")
    love.graphics.printf("Trust", col2_x, row2_y, bar_width, "center")
    love.graphics.printf("Stress", col3_x, row2_y, bar_width, "center")
    love.graphics.printf(lume.format("${1}", { self.stats["money"] }), col4_x, row2_y, bar_width, "center")
    
end

function StatsLayer:keypressed(key, scancode, isrepeat)
    if isrepeat == true then
        return
    end

    if key == layer_manager.controls["Back"] then
        layer_manager:remove_first()
    end
end

function StatsLayer:mousepressed(x, y, button, istouch, presses)
    layer_manager:remove_first()
end