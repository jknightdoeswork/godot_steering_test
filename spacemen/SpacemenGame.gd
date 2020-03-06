extends Node2D

signal on_selection_changed

var selected_unit = null

onready var input_signals = $InputSignals

func _ready():
	input_signals.connect("on_left_mouse_down", self, "on_left_mouse_down")
	input_signals.connect("on_right_mouse_down", self, "on_right_mouse_down")
	
func on_left_mouse_down(position:Vector2):
	print ("[Game] on_left_mouse_button_pressed")
	if selected_unit != null:
		print ("deselecting unit")
		selected_unit = null

func on_right_mouse_down(position:Vector2):
	if selected_unit != null:
		selected_unit.issue_arrive_order(position)
	
func on_ship_clicked(ship):
	print ("selecting unit " + str(ship))
	selected_unit = ship

