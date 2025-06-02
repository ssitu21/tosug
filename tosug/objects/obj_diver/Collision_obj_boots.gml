if (!instance_exists(other)) exit;

// Add to attachments if space available
if (array_length(attachments) < max_attachments) {
    array_push(attachments, "boots");
}

// Apply speed boost
move_speed_boost = 2; // Add +2 to movement speed
move_speed_boost_timer = powerup_duration; // 60 seconds

// Clean up
audio_play_sound(snd_powerup, 0, false);
instance_destroy(other);