///// POWER-UP SYSTEM /////
// Handle speed boost timer
if (move_speed_boost_timer > 0) {
    move_speed_boost_timer--;
    if (move_speed_boost_timer <= 0) {
        move_speed_boost = 0;
        // Remove boots from attachments
        var index = array_index_of(attachments, "boots");
        if (index != -1) array_delete(attachments, index, 1);
    }
}

// Handle oxygen efficiency timer
if (oxygen_efficiency_timer > 0) {
    oxygen_efficiency_timer--;
    if (oxygen_efficiency_timer <= 0) {
        oxygen_efficiency = 1.0;
        // Remove mask from attachments
        var index = array_index_of(attachments, "mask");
        if (index != -1) array_delete(attachments, index, 1);
    }
}

// Calculate current speed
move_speed = move_speed_base + move_speed_boost;

///// OXYGEN SYSTEM /////
oxygen -= oxygen_depletion_rate * 0.2 * oxygen_efficiency;
oxygen = clamp(oxygen, 0, max_oxygen);

// Oxygen damage
if (oxygen <= 0) {
    oxygen_damage_timer++;
    if (!audio_is_playing(snd_drowning)) {
        audio_play_sound(snd_drowning, 0, true);
    }
    if (oxygen_damage_timer >= 60) {
        hp -= 5;
        oxygen_damage_timer = 0;
        hit_flash = 1;
    }
} else {
    if (audio_is_playing(snd_drowning)) audio_stop_sound(snd_drowning);
    oxygen_damage_timer = 0;
}

///// HEALTH SYSTEM /////
// Smooth HP bar
current_hp_display = lerp(current_hp_display, hp, 0.2);

// Update HP color based on percentageAdd commentMore actions
var hp_percent = hp/max_hp;
if (hp_percent > 0.6) {
    hp_bar_color = c_green;
} else if (hp_percent > 0.3) {
    hp_bar_color = c_yellow;
} else {
    hp_bar_color = c_red;
}
// Flash effect
if (hit_flash > 0) hit_flash -= 0.1;

// Death check
if (hp <= 0) game_restart();

///// MOVEMENT SYSTEM /////
var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Swim sound and animation
if (move_x != 0 || move_y != 0) {
    if (!audio_is_playing(snd_swim)) audio_play_sound(snd_swim, 0, false);
    
    if (move_x > 0) {
        sprite_index = spr_diver_right;
        facing = "right";
    } else if (move_x < 0) {
        sprite_index = spr_diver_left;
        facing = "left";
    }  
} else {
    if (audio_is_playing(snd_swim)) audio_stop_sound(snd_swim);
    sprite_index = (facing == "right") ? spr_diver_right : spr_diver_left;
}

// Apply movement
x += move_x * move_speed;
y += move_y * move_speed;

///// CHEST INTERACTION /////
chest_nearby = noone;
var _player = instance_find(obj_diver, 0);
if (_player != noone) {
    with (obj_chest) {
        if (point_distance(x, y, _player.x, _player.y) < 64) {
            _player.chest_nearby = id;
        }
    }
}

if (keyboard_check_pressed(ord("F")) && chest_nearby != noone) {
    with (chest_nearby) event_user(0);
}