// Player variables
hp = 100;
max_hp = 100;
oxygen = 100;
max_oxygen = 100;
oxygen_depletion_rate = 0.5;
move_speed = 5;
facing = "right";
oxygen_damage_timer = 0;

// Animation control
sprite_index = spr_diver_right;
image_speed = 0.5;

// Chest interaction
chest_nearby = noone;

// Visual effects
current_hp_display = hp;
hp_bar_color = c_green;
hit_flash = 0;

// Power-up system
speed_boost_active = false;
original_move_speed = move_speed; // Store original speed
speed_boost_timer = 0;

mask_boost_active = false;
global.oxygen_depletion_modifier = 1; // 1 = normal rate
mask_boost_timer = 0;