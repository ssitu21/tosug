// Handle oxygen depletion (with mask power-up effect)
oxygen -= oxygen_depletion_rate * 0.15 * global.oxygen_depletion_modifier;
oxygen = clamp(oxygen, 0, max_oxygen);

// Oxygen damage system
if (oxygen <= 0) {
    oxygen_damage_timer += 1;
    
    if (!audio_is_playing(snd_drowning)) {
        audio_play_sound(snd_drowning, 0, true);
    }
    
    if (oxygen_damage_timer >= 60) {
        hp -= 5;
        oxygen_damage_timer = 0;
        hit_flash = 1;
    }
} else {
    if (audio_is_playing(snd_drowning)) {
        audio_stop_sound(snd_drowning);
    }
    oxygen_damage_timer = 0;
}

// Handle power-up timers
if (speed_boost_active) {
    speed_boost_timer--;
    if (speed_boost_timer <= 0) {
        speed_boost_active = false;
        move_speed = original_move_speed;
    }
}

if (mask_boost_active) {
    mask_boost_timer--;
    if (mask_boost_timer <= 0) {
        mask_boost_active = false;
        global.oxygen_depletion_modifier = 1;
    }
}

// Smooth HP bar animation
current_hp_display = lerp(current_hp_display, hp, 0.2);

// Update HP color
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

if (move_x != 0 || move_y != 0) {
    if (!audio_is_playing(snd_swim)) {
        audio_play_sound(snd_swim, 0, false);
    }
    
    if (move_x > 0) {
        sprite_index = spr_diver_right;
        facing = "right";
    } else if (move_x < 0) {
        sprite_index = spr_diver_left;
        facing = "left";
    }  
} else {
    if (audio_is_playing(snd_swim)) {
        audio_stop_sound(snd_swim);
    }
    
    if (facing == "right") sprite_index = spr_diver_right;
    else if (facing == "left") sprite_index = spr_diver_left;
}

// Apply movement (with speed boost effect)
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
// Handle throw cooldown
if (throw_cooldown > 0) {
    throw_cooldown--;
} else {
    can_throw = true;
}

// Throw trident on mouse click
if (mouse_check_button_pressed(mb_left) && can_throw) {
    // Create new trident instance (will fly infinitely)
    var _trident = instance_create_layer(x, y, "Player", obj_trident_thrown);
    with (_trident) {
        direction = point_direction(other.x, other.y, mouse_x, mouse_y);
        speed = 15; // Adjust speed as needed
        owner = other.id;
    }
    
    // Play throw sound
    audio_play_sound(snd_throw, 0, false);
    
    // Start cooldown
    can_throw = false;
    throw_cooldown = throw_delay;
}