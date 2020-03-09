extends Node

onready var unit_selection = $"../UnitSelection"

var selection_circles := []

export(PackedScene) var selection_circle_scene

func _ready():
	var e = unit_selection.connect("on_selection_changed", self, "on_selection_changed")

func on_selection_changed(selected_units):
	# Remove old selection circles
	for selection_circle in selection_circles:
		if !selection_circle.is_queued_for_deletion():
			selection_circle.queue_free()
		else:
			printerr("[SelectionCircle] attempted double delete")
	selection_circles.clear()
	
	# Add new selection circles
	for selected_unit in selected_units:
		var selection_circle_instance = selection_circle_scene.instance()
		selection_circles.append(selection_circle_instance)
		selected_unit.add_child(selection_circle_instance)
		
		
