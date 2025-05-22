if (attack_cooldown <= 0) {
    // Find nearest enemy
    var nearest = instance_nearest(x, y, obj_enemy);
    if (nearest != noone && point_distance(x, y, nearest.x, nearest.y) < 40) {
        nearest.hp -= attack_damage;
        attack_cooldown = 15;
    }
}