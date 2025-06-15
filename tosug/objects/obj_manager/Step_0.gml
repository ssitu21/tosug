// Get player once per step (optimization)
var _player = instance_find(obj_diver, 0);
if (!instance_exists(_player)) exit; // Exit early if player doesn't exist

// Update depth tracking
global.player_depth = _player.x; // Current X = depth
global.max_depth = max(global.max_depth, _player.x); // Track deepest point

// Update oxygen depletion rate based on depth
if (global.player_depth < 10000) {
    global.oxygen_depletion_rate = 0.5; // Easy (0–10K)
} else if (global.player_depth < 25000) {
    global.oxygen_depletion_rate = 1; // Medium (10K–25K)
} else if (global.player_depth < 40000) {
    global.oxygen_depletion_rate = 2; // Hard (25K–40K)
} else {
    global.oxygen_depletion_rate = 3; // Brutal (40K+)
}

// Apply to player
_player.oxygen_depletion_rate = global.oxygen_depletion_rate;

// Depth transition warnings (only show once per threshold)
if (global.player_depth >= 10000 && global.player_depth < 10050) {
    show_debug_message("DANGER: Oxygen depletes faster now! (Rate: " + string(global.oxygen_depletion_rate) + ")");
} else if (global.player_depth >= 25000 && global.player_depth < 25050) {
    show_debug_message("WARNING: Oxygen drains much faster! (Rate: " + string(global.oxygen_depletion_rate) + ")");
} else if (global.player_depth >= 40000 && global.player_depth < 40050) {
    show_debug_message("CRITICAL: Oxygen depletion at maximum rate! (Rate: " + string(global.oxygen_depletion_rate) + ")");
}