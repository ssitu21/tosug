// Oxygen efficiency power-up
if (!mask_boost_active) {
    mask_boost_active = true;
    global.oxygen_depletion_modifier = 0.5; // 50% slower depletion
    mask_boost_timer = 30 * room_speed; // 60 seconds
    audio_play_sound(snd_boost, 0, false); // Play boost sound
}
instance_destroy(other); // Remove the mask