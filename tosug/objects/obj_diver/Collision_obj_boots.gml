// Speed boost power-up
if (!speed_boost_active) {
    speed_boost_active = true;
    move_speed *= 1.35; // 35% faster
    speed_boost_timer = 30 * room_speed; // 60 seconds
    audio_play_sound(snd_boost, 0, false); // Play boost sound
}
instance_destroy(other); // Remove the boots