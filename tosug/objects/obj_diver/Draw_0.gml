// Draw the player
draw_self();

// HP Bar setup
var bar_width = 100;
var bar_height = 10;
var bar_x = x - bar_width/2;
var bar_y = y - sprite_height/2 - 10;

// 1. Draw gray background (empty HP)
draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);

// 2. Determine HP color based on percentage
var hp_percent = current_hp_display/max_hp;
var hp_color = c_green; // Default to green
if (hp_percent <= 0.5) hp_color = c_yellow;
if (hp_percent <= 0.25) hp_color = c_red;

// 3. Draw colored HP filling
draw_set_color(hp_color);
var hp_fill_width = hp_percent * bar_width;
draw_rectangle(bar_x, bar_y, bar_x + hp_fill_width, bar_y + bar_height, true);

// 4. Damage flash effect
if (hit_flash > 0) {
    draw_set_color(c_white);
    draw_set_alpha(hit_flash);
    draw_rectangle(bar_x, bar_y, bar_x + hp_fill_width, bar_y + bar_height, true);
    draw_set_alpha(1);
}

// Draw player sprite first
draw_self();

/* ----------------------------
   WORLD-SPACE ELEMENTS (follow player)
   ---------------------------- */


/* ----------------------------
   SCREEN-SPACE UI (fixed position)
   ---------------------------- */
// Get view coordinates
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);

// Oxygen display (top-left)
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_text(cam_x + 10, cam_y + 10, "OXYGEN: " + string(floor(oxygen)) + "%");

// Depth tracker
draw_text(cam_x + 10, cam_y + 30, "DEPTH: " + string(floor(global.player_depth)) + "m");
draw_text(cam_x + 10, cam_y + 50, "MAX: " + string(floor(global.max_depth)) + "m");

// Active power-ups
draw_set_color(c_yellow);
draw_text(cam_x + 10, cam_y + 70, "ACTIVE BOOSTS:");

if (speed_boost_active) {
    draw_text(cam_x + 15, cam_y + 90, "» SPEED: " + string_format(speed_boost_timer/room_speed, 1, 1) + "s");
}

if (mask_boost_active) {
    draw_text(cam_x + 15, cam_y + 110, "» AIR: " + string_format(mask_boost_timer/room_speed, 1, 1) + "s");
}

// Reset draw settings
draw_set_color(c_white);
draw_set_alpha(1);
// Draw throw cooldown indicator
if (!can_throw) {
    var cooldown_percent = 1 - (throw_cooldown/throw_delay);
    draw_set_color(c_white);
    draw_rectangle(x-20, y-40, x+20, y-35, false);
    draw_set_color(c_blue);
    draw_rectangle(x-19, y-39, x-19+(38*cooldown_percent), y-36, true);
}