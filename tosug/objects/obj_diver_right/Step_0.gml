// Handle movement
var h_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var v_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));

hspeed = lerp(hspeed, h_input * move_speed, 0.2);
vspeed = lerp(vspeed, v_input * move_speed, 0.2);

// Limit speed
var spd = point_distance(0, 0, hspeed, vspeed);
if (spd > max_speed) {
    hspeed = (hspeed / spd) * max_speed;
    vspeed = (vspeed / spd) * max_speed;
}

// Oxygen depletion
oxygen -= oxygen_depletion_rate;
if (oxygen <= 0) {
    hp -= 1;
}

// Attack cooldown
if (attack_cooldown > 0) attack_cooldown--;