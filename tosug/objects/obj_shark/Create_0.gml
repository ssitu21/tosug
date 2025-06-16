
// Movement
sprite_index = spr_shark_right;
move_speed = 1.7;
direction = 0; // 0=right, 180=left
change_dir_timer = 0;

// Combat
damage = 10;
attack_cooldown = 0;
attack_cooldown_time = room_speed * 1.5;
detection_range = 1000;
attack_range = 40;

// HP System
hp = 50;
max_hp = 50;
current_hp_display = hp;
show_hp_bar = false;
hp_bar_timer = 0;
hit_flash = 0;

// Visibility
visible = true;
image_alpha = 1;
depth = -y - 100; // Ensures HP bar draws above shark
// Add these new variables
is_dying = false;
death_timer = 0;
death_fade_time = 60; // 1 second fade at 60FPS