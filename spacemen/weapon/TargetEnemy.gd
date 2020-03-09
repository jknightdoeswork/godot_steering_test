extends Node

onready var nearby_enemies = $"../NearbyEnemies"

var override_target_enemy:Node2D = null

func select_target(t:Node2D):
	override_target_enemy = t

func get_target()->Node2D:
	if override_target_enemy != null:
		return override_target_enemy
	else:
		return nearby_enemies.closest_unit()
