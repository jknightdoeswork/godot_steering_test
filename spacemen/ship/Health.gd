extends Node

signal on_death
signal on_damage

export var starting_health := 10

var health_points := 0

func _ready():
	health_points = starting_health
	
func take_damage(damage:int):
	emit_signal("on_damage")
	health_points -= damage
	if health_points <= 0:
		health_points = 0
		emit_signal("on_death")
		get_parent().queue_free()
