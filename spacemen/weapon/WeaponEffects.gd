extends Node2D

onready var identity = $"../Identity"
onready var weapon = $"../Weapon"

export(PackedScene) var weapon_line_scene

func _ready():
	weapon.connect("on_weapon_fired", self, "on_weapon_fired")

func on_weapon_fired(target:Node2D):
	var start_position = global_position
	var end_position = target.global_position
	
	var weapon_line = weapon_line_scene.instance() as Line2D
	assert(weapon_line != null)
	get_tree().root.add_child(weapon_line)
	
	weapon_line.position = start_position
	weapon_line.points[1] = end_position - start_position
	weapon_line.default_color = identity.color
	
