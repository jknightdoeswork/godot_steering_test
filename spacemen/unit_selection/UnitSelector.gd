extends Node

signal on_selection_changed

var selected_units := []

onready var input_signals = $"../InputSignals"

func _ready():
	var error = input_signals.connect("on_left_mouse_down", self, "on_left_mouse_down")
	assert(error == OK)
	error = input_signals.connect("on_right_mouse_down", self, "on_right_mouse_down")
	assert(error == OK)
	
func on_left_mouse_down(position:Vector2):
	print ("[Game] on_left_mouse_button_pressed")
	if selected_units.size() > 0:
		print ("deselecting unit")
		selected_units.clear()
		emit_signal("on_selection_changed", selected_units)

func on_right_mouse_down(position:Vector2):
	if selected_units.size() > 0:
		for selected_unit in selected_units:
			selected_unit.issue_arrive_order(position)
	
func on_ship_clicked(ship):
	print ("selecting unit " + str(ship))
	selected_units = [ship]
	emit_signal("on_selection_changed", selected_units)

