extends Node

signal on_death
signal on_damage

export var starting_health := 10

var health_points := 0

func _ready():
	health_points = starting_health

func is_dead()->bool:
	return !is_alive()

func is_alive()->bool:
	return health_points > 0

func take_damage(damage:int):
	if is_dead():
		print ("[Health] take_damage is_dead")
		return
	
	emit_signal("on_damage")
	health_points -= damage
	if health_points <= 0:
		health_points = 0
		var parent = get_parent()
		assert(parent != null)
		emit_signal("on_death")
		parent.queue_free()
