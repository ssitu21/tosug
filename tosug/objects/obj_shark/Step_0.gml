// Movement
change_dir_timer--;
if (change_dir_timer <= 0) {
    direction = 180 - direction;
    change_dir_timer = room_speed * (1 + random(2));
}

x += lengthdir_x(move_speed, direction);
sprite_index = (direction == 0) ? spr_shark_right : spr_shark_left;

// Chase player
var player = instance_find(obj_diver, 0);
if (player != noone) {
    var dist = point_distance(x, y, player.x, player.y);
    if (dist < detection_range) {
        var chase_dir = point_direction(x, y, player.x, player.y);
        x += lengthdir_x(move_speed * 1.5, chase_dir);
        y += lengthdir_y(move_speed * 1.5, chase_dir);
        direction = (chase_dir > 90 && chase_dir < 270) ? 180 : 0;
        sprite_index = (direction == 0) ? spr_shark_right : spr_shark_left;
    }
}

// Combat
if (attack_cooldown > 0) attack_cooldown--;

// HP Bar System
current_hp_display = lerp(current_hp_display, hp, 0.2);

if (hp_bar_timer > 0) {
    hp_bar_timer--;
    show_hp_bar = true;
} else {
    show_hp_bar = false;
}

if (hit_flash > 0) hit_flash -= 0.1;

// Death handling
if (hp <= 0 && !is_dying) {
    is_dying = true;
    death_timer = death_fade_time;
    audio_play_sound(snd_shark_death, 0, false);
    
    // Disable collisions and movement
    speed = 0;
    image_speed = 0; // Freeze animation
}

// Handle death fade
if (is_dying) {
    death_timer--;
    image_alpha = death_timer/death_fade_time; // Gradually fade out

    // Destroy when fade complete
    if (death_timer <= 0) {
        instance_destroy();
    }
}