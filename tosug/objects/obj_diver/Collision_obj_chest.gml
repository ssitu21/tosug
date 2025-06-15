// Check for nearby chests and handle collision
var _player = instance_find(obj_diver, 0);
chest_nearby = noone;

if (_player != noone) {
    with (obj_chest) {
        if (point_distance(x, y, _player.x, _player.y) < 64) {
            _player.chest_nearby = id;
            
            // Automatic healing when touching chest
            if (place_meeting(x, y, obj_diver)) {
                // Heal 25% of max HP
                _player.hp = min(_player.max_hp, _player.hp + (_player.max_hp * 0.25));
                
                // Optional: Add healing effect
                _player.hit_flash = 0.5; // Positive flash instead of damage flash
                audio_play_sound(snd_heal, 0, false); // Add healing sound
                
                instance_destroy(); // Remove chest after healing
            }
        }
    }
}

// Original F-key chest interaction (for other purposes)
if (keyboard_check_pressed(ord("F")) && chest_nearby != noone) {
    with (chest_nearby) {
        event_user(0); // Keep original functionality
    }
}