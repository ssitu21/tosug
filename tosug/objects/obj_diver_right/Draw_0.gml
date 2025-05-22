// Draw health and oxygen bars
draw_self();

// Health bar
draw_rectangle_color(x-16, y-25, x-16 + 32*(hp/max_hp), y-20, c_red, c_red, c_red, c_red, false);
draw_rectangle(x-16, y-25, x+16, y-20, false);

// Oxygen bar
draw_rectangle_color(x-16, y-30, x-16 + 32*(oxygen/max_oxygen), y-25, c_blue, c_blue, c_blue, c_blue, false);
draw_rectangle(x-16, y-30, x+16, y-25, false);