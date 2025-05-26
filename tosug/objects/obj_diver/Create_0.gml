// Player variables
hp = 100;
max_hp = 100;
oxygen = 100;
max_oxygen = 100;
oxygen_depletion_rate = 0.5; // Oxygen decreases by 0.2 per step
move_speed = 5;
facing = "right"; // Track facing direction for animations
oxygen_damage_timer = 0; // Timer for oxygen damage
// Animation control
sprite_index = spr_diver_right;
image_speed = 0.5;

// Chest interaction
chest_nearby = noone;
	
// Add these with your existing create event variables
current_hp_display = hp; // For smooth HP bar animation
hp_bar_color = c_green;  // Starting color
hit_flash = 0;           // For damage flash effect