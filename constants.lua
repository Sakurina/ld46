constants = {
    big_font = love.graphics.newFont("deps/m5x7.ttf", 72),

    db16_col1 = { r = 20/255, g = 12/255, b = 28/255 },
    db16_col2 = { r = 68/255, g = 36/255, b = 52/255 },
    db16_col3 = { r = 48/255, g = 52/255, b = 109/255 },
    db16_col4 = { r = 78/255, g = 74/255, b = 78/255 },
    db16_col5 = { r = 133/255, g = 76/255, b = 48/255 },
    db16_col6 = { r = 52/255, g = 101/255, b = 36/255 },
    db16_col7 = { r = 208/255, g = 70/255, b = 72/255 },
    db16_col8 = { r = 117/255, g = 113/255, b = 97/255 },
    db16_col9 = { r = 89/255, g = 125/255, b = 206/255 },
    db16_col10 = { r = 210/255, g = 125/255, b = 44/255 },
    db16_col11 = { r = 133/255, g = 149/255, b = 161/255 },
    db16_col12 = { r = 109/255, g = 170/255, b = 44/255 },
    db16_col13 = { r = 210/255, g = 170/255, b = 153/255 },
    db16_col14 = { r = 109/255, g = 194/255, b = 202/255 },
    db16_col15 = { r = 218/255, g = 212/255, b = 94/255 },
    db16_col16 = { r = 222/255, g = 238/255, b = 214/255 },

    unit_menu_height_per_item = 56,

    default_luck_value = 0.1,
    default_buffed_luck_delta = 0.4,
    
    stat_caps = {
        money = 10000,

        str = 350,
        int = 350,
        cha = 350,
        dex = 350,
        morality = 350,
        trust = 350,
        stress = 100,

        business = 350,
        combat = 350,
        research = 350,
        cooking = 350,
        alchemy = 350
    },

    -- JOBS

    black_event = {
        income_per_day_regular = 15,
        income_per_day_lucky = 30,
        morality_delta = -5,
        stress_delta = 5,
        combat_delta = 5
    },

    delivery_event = {
        income_per_day_regular = 7,
        income_per_day_lucky = 9,
        stress_delta = 4,
        dex_delta = 5
    },

    lab_event = {
        income_per_day_regular = 9,
        income_per_day_lucky = 13,
        int_delta = 5,
        research_delta = 5
    },

    -- ACTIVITIES

    gym_event = {
        cost_per_day = -3,
        combat_delta_regular = 5,
        combat_delta_lucky = 7,
        str_delta_regular = 5,
        str_delta_lucky = 7
    },

    karaoke_event = {
        cost_per_day = -3,
        cha_delta_regular = 5,
        cha_delta_lucky = 7
    },

    library_event = {
        cost_per_day = -1,
        morality_delta_regular = 5,
        morality_delta_lucky = 7
    },

    study_event = {
        cost_per_day = -5,
        int_delta_regular = 5,
        int_delta_lucky = 7
    },

    cook_event = {
        dex_delta_regular = 3,
        dex_delta_lucky = 5,
        cooking_delta_regular = 3,
        cooking_delta_lucky = 5
    },

    -- REST

    nap_event = {
        stress_delta_regular = -3,
        stress_delta_lucky = -5
    },
    
    vacation_event = {
        cost_per_day = -9,
        stress_delta_regular = -5,
        stress_delta_lucky = -7
    }
}

constants.system_txt_color = constants.db16_col16
constants.light_bg_color = constants.db16_col16
constants.dark_bg_color = constants.db16_col1
constants.emphasis_color = constants.db16_col15
constants.deemphasis_color = constants.db16_col11