extends Node2D
signal on_selection_changed

onready var input_signals = $"../InputSignals"
var selected_unit = null

func _ready():
	input_signals.connect("on_left_mouse_pressed", self, "on_left_mouse_button_pressed")
	input_signals.connect("on_right_mouse_pressed", self, "on_right_mouse_button_pressed")

func on_left_mouse_button_pressed(position:Vector2):
	if selected_unit != null:
		print ("deselecting unit")
		selected_unit = null

func on_right_mouse_button_pressed(position:Vector2):
	if selected_unit != null:
		print ("issuing arrive order")

func on_ship_clicked(ship):
	print ("selecting unit " + str(ship))
	selected_unit = ship

