extends Node

var override_target_enemy:Node = null
var target_enemy:Node=null

onready var detection_area = $DetectionArea

func _ready():
	detection_area.connect("body_entered", self, "on_body_entered")
	detection_area.connect("body_exited", self, "on_body_exited")

func overlapping_units():
	return detection_area.get_overlapping_areas()
	
func on_body_entered(body:Node):
	if target_enemy == null:
		pass
	pass

func on_body_exited(body:Node):
	pass	
