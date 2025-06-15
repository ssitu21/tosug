// Only play sound when first making contact
if (!oxygen_contact) {
    audio_play_sound(snd_bubble, 0, false);
    oxygen_contact = true;
    
}

// Reset contact flag after a small delay
oxygen_sound_cooldown = 3; // 3 frames cooldown