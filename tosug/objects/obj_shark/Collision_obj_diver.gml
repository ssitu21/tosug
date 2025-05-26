if (attack_cooldown <= 0) {
    // Damage player using proper reference
    with (other) {
        hp -= other.damage; // Fixed: Access shark's damage through proper scope
        hit_flash = 1;
        
        // Knockback effect (pushes player away from shark)
        var kb_dir = point_direction(x, y, other.x, other.y);
        x += lengthdir_x(15, kb_dir);
        y += lengthdir_y(15, kb_dir);
    }
    
    // Start cooldown
    attack_cooldown = attack_cooldown_time;
}