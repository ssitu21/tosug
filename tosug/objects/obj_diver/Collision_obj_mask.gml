if (!instance_exists(other)) exit;

// Add to attachments if space available
if (array_length(attachments) < max_attachments) {
    array_push(attachments, "mask");
}

// Apply oxygen efficiency
oxygen_efficiency = 0.5; // Oxygen depletes at half rate
oxygen_efficiency_timer = powerup_duration; // 60 seconds

// Clean up
audio_play_sound(snd_powerup, 0, false);
instance_destroy(other);