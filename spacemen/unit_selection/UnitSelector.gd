extends Node

signal on_selection_changed

var selected_units := []

var selection_area:Area2D = null
var selection_box:Polygon2D = null

onready var input_signals = $"../InputSignals"

func _ready():
	var error = input_signals.connect("on_left_mouse_down", self, "on_left_mouse_down")
	assert(error == OK)
	error = input_signals.connect("on_right_mouse_down", self, "on_right_mouse_down")
	assert(error == OK)

func select_units(units:Array):
	print ("[Game] on_left_mouse_button_pressed")
	selected_units = units
	emit_signal("on_selection_changed", selected_units)
	
func deselect_units():
	print ("deselecting units")
	select_units([])
	

	
func on_left_mouse_down(position:Vector2):
	#selection_box = Polygon2D.new()
	#selection_area = Area2D.new()
	
	#selection_box.add_child(selection_area)
	
	#self.add_child(selection_box)
	pass
	deselect_units()
	
func on_right_mouse_down(position:Vector2):
	if selected_units.size() > 0:
		for selected_unit in selected_units:
			selected_unit.issue_arrive_order(position)
	
func on_ship_clicked(ship):
	print ("selecting unit " + str(ship))
	select_units([ship])

