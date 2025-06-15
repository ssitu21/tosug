if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Only update if being held
if (owner.has_trident) {
    // Follow player with offset
    var _offset = 20;
    x = owner.x + lengthdir_x(_offset, owner.facing == "right" ? 0 : 180);
    y = owner.y;
    
    // Point toward mouse
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    
    // Only visible when not moving (optional)
    image_alpha = (owner.move_x == 0 && owner.move_y == 0) ? 1 : 0.5;
}