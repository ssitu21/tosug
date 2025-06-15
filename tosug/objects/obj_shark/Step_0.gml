// Default patrol movement (left/right)
change_dir_timer--;
if (change_dir_timer <= 0) {
    direction = 180 - direction; // Flip direction
    change_dir_timer = room_speed * (1 + random(2)); // 1-3 seconds
}

// Apply movement
x += lengthdir_x(move_speed, direction);

// Update sprite based on direction
sprite_index = (direction == 0) ? spr_shark_right : spr_shark_left;

// Player detection and chasing
var player = instance_find(obj_diver, 0);
if (player != noone) {
    var dist = point_distance(x, y, player.x, player.y);
    
    if (dist < detection_range) {
        // Chase player
        var chase_dir = point_direction(x, y, player.x, player.y);
        x += lengthdir_x(move_speed * 1.5, chase_dir);
        y += lengthdir_y(move_speed * 1.5, chase_dir);
        
        // Update facing direction
        direction = (chase_dir > 90 && chase_dir < 270) ? 180 : 0;
        sprite_index = (direction == 0) ? spr_shark_right : spr_shark_left;
    }
}

// Handle cooldown
if (attack_cooldown > 0) attack_cooldown--;
// Update HP bar visibility
if (hp_bar_timer > 0) {
    hp_bar_timer--;
    show_hp_bar = true;
} else {
    show_hp_bar = false;
}

// Die when HP reaches 0
if (hp <= 0) {
    audio_play_sound(snd_shark_death, 0, false);
    instance_destroy();
}