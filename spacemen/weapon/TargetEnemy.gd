extends Node

var override_target_enemy:Node = null
var target_enemy:Node=null



func overlapping_units():
	return detection_area.get_overlapping_areas()
	
func on_body_entered(body:Node):
	if target_enemy == null:
		pass
	pass

func on_body_exited(body:Node):
	pass	
