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

if (hp_percent <= 0.5) hp_color = c_yellow; // Below 50% -> yellow
if (hp_percent <= 0.25) hp_color = c_red;   // Below 25% -> red

// 3. Draw colored HP filling
draw_set_color(hp_color);
var hp_fill_width = hp_percent * bar_width;
draw_rectangle(bar_x, bar_y, bar_x + hp_fill_width, bar_y + bar_height, true);

// 4. Damage flash effect (white overlay)
if (hit_flash > 0) {
    draw_set_color(c_white);
    draw_set_alpha(hit_flash);
    draw_rectangle(bar_x, bar_y, bar_x + hp_fill_width, bar_y + bar_height, true);
    draw_set_alpha(1);
}

// Oxygen counter
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
draw_set_color(c_white);
draw_set_font(-1);
draw_text(cam_x + 10, cam_y + 10, "Oxygen: " + string(floor(oxygen)));