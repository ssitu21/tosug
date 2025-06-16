draw_self();
if (hp > 0) {
    var bar_width = 40;
    var bar_height = 5;
    var hp_ratio = hp / max_hp;

    var x1 = x - bar_width / 2;
    var y1 = y - sprite_height / 2 - 10;

    draw_set_color(c_red);
    draw_rectangle(x1, y1, x1 + bar_width, y1 + bar_height, false);

    draw_set_color(c_green);
    draw_rectangle(x1, y1, x1 + bar_width * hp_ratio, y1 + bar_height, false);
}