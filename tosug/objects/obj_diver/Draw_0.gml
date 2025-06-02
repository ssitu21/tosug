// Draw the player character
draw_self();

// Get camera/viewport dimensions once for efficiency
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

//// HEALTH BAR (Above Player) ////
var bar_width = 100;
var bar_height = 8;
var bar_x = x - bar_width/2;
var bar_y = y - sprite_height/2 - 15;

// Background
draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);
draw_rectangle(bar_x + 1, bar_y + 1, bar_x + bar_width - 1, bar_y + bar_height - 1, true);

// Health fill (smoothed)
var hp_fill = clamp(current_hp_display/max_hp, 0, 1) * (bar_width - 2);
draw_set_color(hp_bar_color);
draw_rectangle(bar_x + 1, bar_y + 1, bar_x + 1 + hp_fill, bar_y + bar_height - 1, true);

// Damage flash
if (hit_flash > 0) {
    draw_set_color(c_white);
    draw_set_alpha(hit_flash * 0.6);
    draw_rectangle(bar_x + 1, bar_y + 1, bar_x + 1 + hp_fill, bar_y + bar_height - 1, true);
    draw_set_alpha(1);
}

//// OXYGEN UI (Top-Left Corner) ////
var oxy_x = cam_x + 10;
var oxy_y = cam_y + 10;
var oxy_width = 120;
var oxy_height = 20;

// Background
draw_set_color(make_color_rgb(30, 30, 50));
draw_rectangle(oxy_x, oxy_y, oxy_x + oxy_width, oxy_y + oxy_height, true);

// Oxygen level
var oxy_fill = (oxygen/max_oxygen) * (oxy_width - 4);
draw_set_color(make_color_rgb(50, 180, 255));
draw_rectangle(oxy_x + 2, oxy_y + 2, oxy_x + 2 + oxy_fill, oxy_y + oxy_height - 2, true);

// Text
draw_set_color(c_white);
draw_set_font(-1); // Default font
draw_set_halign(fa_left);
draw_text(oxy_x + 5, oxy_y + 4, "OXYGEN: " + string(floor(oxygen)) + "%");

//// ATTACHMENTS UI (Top-Right Corner) ////
if (array_length(attachments) > 0) {
    var attach_x = cam_x + cam_w - 10;
    var attach_y = cam_y + 10;
    var icon_size = 24;
    var icon_pad = 5;
    
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_text(attach_x, attach_y - 18, "EQUIPMENT:");
    
    for (var i = array_length(attachments) - 1; i >= 0; i--) {
        var icon_x = attach_x - ((array_length(attachments) - 1 - i) * (icon_size + icon_pad));
        
        // Draw icon
        if (attachments[i] == "boots") {
            draw_sprite_ext(spr_boots_icon, 0, icon_x, attach_y, 0.8, 0.8, 0, c_white, 1);
            
            // Timer bar
            if (move_speed_boost_timer > 0) {
                var timer_pct = move_speed_boost_timer/powerup_duration;
                draw_set_color(make_color_rgb(100, 255, 100));
                draw_rectangle(icon_x - icon_size/2, attach_y + icon_size/2 + 2, 
                              icon_x - icon_size/2 + icon_size * timer_pct, 
                              attach_y + icon_size/2 + 4, true);
            }
        }
        else if (attachments[i] == "mask") {
            draw_sprite_ext(spr_mask_icon, 0, icon_x, attach_y, 0.8, 0.8, 0, c_white, 1);
            
            // Timer bar
            if (oxygen_efficiency_timer > 0) {
                var timer_pct = oxygen_efficiency_timer/powerup_duration;
                draw_set_color(make_color_rgb(100, 200, 255));
                draw_rectangle(icon_x - icon_size/2, attach_y + icon_size/2 + 2, 
                              icon_x - icon_size/2 + icon_size * timer_pct, 
                              attach_y + icon_size/2 + 4, true);
            }
        }
    }
}

//// CHEST PROMPT ////
if (chest_nearby != noone) {
    var prompt_x = cam_x + cam_w/2;
    var prompt_y = cam_y + cam_h - 40;
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(prompt_x, prompt_y, "Press F to open chest");
    draw_set_halign(fa_left); // Reset alignment
}

// Reset drawing defaults
draw_set_color(c_white);
draw_set_alpha(1);