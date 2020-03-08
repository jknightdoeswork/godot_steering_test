extends Node

signal on_weapon_fired

export var damage := 3
export var cooldown := 1.0

onready var target_enemy = $"../TargetEnemy"

var shot_timer := 0.0

func _physics_process(delta):
	# if target available, fire weapon with cooldown
	if shot_timer <= 0.0:
		var target:Node2D = target_enemy.get_target()
		if target != null:
			var target_health = target.get_node("Health")
			if target_health != null:
				shot_timer = cooldown
				target_health.take_damage(damage)
				emit_signal("on_weapon_fired", target)
	else:
		shot_timer -= delta

