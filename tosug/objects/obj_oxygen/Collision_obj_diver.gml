// Add oxygen to player, but don't exceed max
obj_diver.oxygen = min(obj_diver.oxygen + oxygen_value, obj_diver.max_oxygen);
instance_destroy(); // Remove the oxygen pickup