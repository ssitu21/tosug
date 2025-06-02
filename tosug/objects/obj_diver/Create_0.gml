// Player stats
hp = 100;
max_hp = 100;
oxygen = 100;
max_oxygen = 100;
oxygen_depletion_rate = 0.5; // Base depletion rate

// Movement system
move_speed_base = 3;
move_speed_boost = 0;
move_speed = move_speed_base;
facing = "right"; 

// Visual effects
current_hp_display = hp;
hp_bar_color = c_green;
hit_flash = 0;
oxygen_damage_timer = 0;

// Animation
sprite_index = spr_diver_right;
image_speed = 0.5;

// Attachment system
attachments = [];
max_attachments = 4;
powerup_duration = 60 * 60; // 60 seconds

// Oxygen modifiers
oxygen_efficiency = 1.0;
oxygen_efficiency_timer = 0;

// Interaction
chest_nearby = noone;