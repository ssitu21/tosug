// Rotate while moving
image_angle = direction;

// Check lifetime (auto-return after time)
if (lifetime-- <= 0) {
    if (instance_exists(owner)) {
        with (owner) {
            has_trident = true;
            if (instance_exists(trident)) {
                trident.image_alpha = 1;
            }
        }
    }
    instance_destroy();
    exit;
}

// Check collision with shark (SAFE VERSION)
var _shark = instance_place(x, y, obj_shark);
if (_shark != noone) {
    // Check if shark has HP system
    if (variable_instance_exists(_shark, "hp")) {
        _shark.hp -= damage; // Deal damage
       
    }
    
    // Make trident stick in shark (remove to pierce through)
    instance_destroy();
    exit;
}

// Check collision with walls
if (place_meeting(x, y, obj_blocker)) {
    // Return trident to player on wall hit
    if (instance_exists(owner)) {
        owner.has_trident = true;
        if (instance_exists(owner.trident)) {
            owner.trident.image_alpha = 1;
        }
    }
    instance_destroy();
}
