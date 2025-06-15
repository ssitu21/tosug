// Handle cooldown timer
if (oxygen_sound_cooldown > 0) {
    oxygen_sound_cooldown--;
} else {
    oxygen_contact = false; // Reset contact flag
}