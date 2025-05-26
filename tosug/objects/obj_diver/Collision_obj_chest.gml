if (keyboard_check_pressed(ord("F")) && chest_nearby != noone) {
    with (chest_nearby) {
        event_user(0); // This triggers "User 0" in the chest
    }
}