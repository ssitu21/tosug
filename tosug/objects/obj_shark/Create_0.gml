// Movement
sprite_index = spr_shark_right;
move_speed = 1;
direction = 0; // 0=right, 180=left
change_dir_timer = 0;

// Combat
damage = 10;
attack_cooldown = 0;
attack_cooldown_time = room_speed * 1.5; // 1.5 second cooldown
detection_range = 200;
attack_range = 40;
// In obj_shark Create Event
hp = 50;
max_hp = 50;
show_hp_bar = false;
hp_bar_timer = 0;