extends KinematicBody2D

signal on_ship_clicked

func _input_event(viewport: Object, e: InputEvent, shape_idx: int):
	if e is InputEventMouseButton:
		if e.button_index == 1 and e.pressed:
			print ("[Ship] ship clicked")
			emit_signal("on_ship_clicked", self)
			get_tree().set_input_as_handled()
