// Modified oxygen system - more forgiving
oxygen -= oxygen_depletion_rate * 0.2; // Slower depletion rate (changed from original)

// Oxygen damage system - more forgiving (replaces your original oxygen <= 0 check)
if (oxygen <= 0) {
    // Start a timer when oxygen runs out
    oxygen_damage_timer += 1;
    
    // Only take damage every 60 steps (1 second if room speed is 60)
    if (oxygen_damage_timer >= 60) {
        hp -= 5; // Smaller damage amount (changed from 10)
        oxygen_damage_timer = 0; // Reset timer
        hit_flash = 1; // Flash effect
    }
} else {
    oxygen_damage_timer = 0; // Reset timer when oxygen is available
}

// Clamp oxygen to not go below 0 (new line)
oxygen = clamp(oxygen, 0, max_oxygen);

// Rest of your existing code continues unchanged...
// Smooth HP bar animation
current_hp_display = lerp(current_hp_display, hp, 0.2);

// Update HP color based on percentage
var hp_percent = hp/max_hp;
if (hp_percent > 0.6) {
    hp_bar_color = c_green;
} else if (hp_percent > 0.3) {
    hp_bar_color = c_yellow;
} else {
    hp_bar_color = c_red;
}

// Flash timer
if (hit_flash > 0) hit_flash -= 0.1;

// Die if HP reaches 0
if (hp <= 0) {
    game_restart();
}

// Movement and animation control
var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Set facing direction and animation
if (move_x != 0 || move_y != 0) {
    if (move_x > 0) {
        sprite_index = spr_diver_right;
        facing = "right";
    } else if (move_x < 0) {
        sprite_index = spr_diver_left;
        facing = "left";
    }  
} else {
    if (facing == "right") sprite_index = spr_diver_right;
    else if (facing == "left") sprite_index = spr_diver_left;
}

// Apply movement
x += move_x * move_speed;
y += move_y * move_speed;

// Check for nearby chests
var _player = instance_find(obj_diver, 0);
chest_nearby = noone;

if (_player != noone) {
    with (obj_chest) {
        if (point_distance(x, y, _player.x, _player.y) < 64) {
            _player.chest_nearby = id;
        }
    }
}

// Open chest with F key
if (keyboard_check_pressed(ord("F")) && chest_nearby != noone) {
    with (chest_nearby) {
        event_user(0);
    }
}