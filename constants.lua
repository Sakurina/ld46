constants = {
    big_font = love.graphics.newFont("deps/m5x7.ttf", 72),
    smol_font = love.graphics.newFont("deps/m5x7.ttf", 36),
    
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

        str = 610,
        int = 860,
        cha = 610,
        dex = 860,
        morality = 610,
        trust = 350, -- ????
        stress = 100,

        business = 555,
        combat = 860,
        research = 555,
        cooking = 860,
        alchemy = 350 -- ????
    },

    -- JOBS

    black_event = {
        id = "Black Market",
        icon = "gfx/icon_blackmarket.png",
        income_per_day_regular = 15,
        income_per_day_lucky = 30,
        morality_delta = -3,
        stress_delta = 5,
        combat_delta = 1
    },

    delivery_event = {
        id = "Delivery",
        icon = "gfx/icon_delivery.png",
        income_per_day_regular = 5,
        income_per_day_lucky = 7,
        stress_delta = 4,
        dex_delta = 1
    },

    lab_event = {
        id = "Lab Work",
        icon = "gfx/icon_lab.png",
        income_per_day_regular = 9,
        income_per_day_lucky = 14,
        int_delta = 1,
        research_delta = 1
    },

    acct_event = {
        id = "Accounting",
        icon = "gfx/icon_accounting.png",
        income_per_day_regular = 8,
        income_per_day_lucky = 12,
        business_delta = 1,
        stress_delta = 3,
        int_delta = -1
    },

    resto_event = {
        id = "Restaurant",
        icon = "gfx/icon_restaurant.png",
        income_per_day_regular = 5,
        income_per_day_lucky = 0,
        cooking_delta = 1,
        stress_delta = 5
    },

    -- ACTIVITIES

    gym_event = {
        id = "Gym",
        icon = "gfx/icon_gym.png",
        cost_per_day = -3,
        combat_delta_regular = 2,
        combat_delta_lucky = 3,
        str_delta_regular = 1,
        str_delta_lucky = 2
    },

    karaoke_event = {
        id = "Karaoke",
        icon = "gfx/icon_karaoke.png",
        cost_per_day = -2,
        cha_delta_regular = 1,
        cha_delta_lucky = 2
    },

    library_event = {
        id = "Philosophy",
        icon = "gfx/icon_philosophy.png",
        cost_per_day = -1,
        morality_delta_regular = 1,
        morality_delta_lucky = 2
    },

    study_event = {
        id = "Study",
        icon = "gfx/icon_study.png",
        cost_per_day = -1,
        int_delta_regular = 2,
        int_delta_lucky = 3
    },

    cook_event = {
        id = "Culinary Training",
        icon = "gfx/icon_culinary.png",
        dex_delta_regular = 2,
        dex_delta_lucky = 3,
        cooking_delta_regular = 2,
        cooking_delta_lucky = 3
    },

    -- REST

    nap_event = {
        id = "Short Rest",
        icon = "gfx/icon_shortrest.png",
        stress_delta_regular = -3,
        stress_delta_lucky = -4
    },
    
    vacation_event = {
        id = "Vacation",
        icon = "gfx/icon_vacation.png",
        cost_per_day = -13,
        stress_delta_regular = -4,
        stress_delta_lucky = -5
    }
}

constants.system_txt_color = constants.db16_col16
constants.light_bg_color = constants.db16_col16
constants.dark_bg_color = constants.db16_col1
constants.emphasis_color = constants.db16_col15
constants.deemphasis_color = constants.db16_col11