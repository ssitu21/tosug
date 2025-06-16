// When trident hits shark (in obj_trident_thrown or your trident object)
with (obj_shark) {
    hp -= damage_amount; // Use your actual damage value (e.g., 10)
    hp_bar_timer = room_speed * 2; // Show bar for 2 seconds
    hit_flash = 1; // White flash effect
    show_hp_bar = true;
    
    // Force visibility
    visible = true;
    image_alpha = 1;
}



// Remove trident (or keep it for piercing)
instance_destroy();