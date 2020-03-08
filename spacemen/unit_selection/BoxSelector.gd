extends Node

onready var box:Polygon2D = $SelectionBox
onready var box_area = $SelectionBox/Polygon2D/Area2D
onready var input_signals = $"../InputSignals"
onready var unit_selection = $"../UnitSelection"

var mouse_down_position := Vector2.ZERO

func _ready():
	box.visible = false
	input_signals.connect("on_left_mouse_down", self, "on_left_mouse_down")
	input_signals.connect("on_left_mouse_up", self, "on_left_mouse_up")
	
func on_left_mouse_down(position:Vector2):
	mouse_down_position = position
	box.visible = true
	box.position = position
	box.scale = Vector2(1.0,1.0)
	
func on_left_mouse_up(position:Vector2):
	box.visible = false
	var selected_units = box_area.get_overlapping_areas()
	print ("num overlapping units: " + str(selected_units.size()))
	var selected_unit_bodies := []
	for unit in selected_units:
		selected_unit_bodies.append(unit.get_parent())
	unit_selection.select_units(selected_unit_bodies)
	
func _process(delta: float) -> void:
	if box.visible:
		var mouse_delta = get_viewport().get_mouse_position() - mouse_down_position
		box.scale = min_box_scale(mouse_delta)
		
func min_box_scale(scale):
	# Minimum of 1px box dimensions
	if abs(scale.x) < 1.0:
		scale.x = sign(scale.x)
	if abs(scale.y) < 1.0:
		scale.y = sign(scale.y)
	return scale
