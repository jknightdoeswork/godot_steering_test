extends Node

onready var unit_selection = $"../UnitSelection"

var selection_circles := []

export(PackedScene) var selection_circle_scene

func _ready():
	var e = unit_selection.connect("on_selection_changed", self, "on_selection_changed")

func on_selection_changed(selected_units):
	print ("[UnitSelectionCircles] on_selection_changed")
	
	# Remove old selection circles
	for weak_selection_circle in selection_circles:
		var selection_circle = weak_selection_circle.get_ref()
		if selection_circle != null:
			selection_circle.queue_free()
	selection_circles.clear()
	
	# Add new selection circles
	for selected_unit in selected_units:
		print ("[UnitSelectionCircles] instancing selected circle")
		var selection_circle_instance = selection_circle_scene.instance()
		selection_circles.append(weakref(selection_circle_instance))
		selected_unit.add_child(selection_circle_instance)
		
		
