extends Node

onready var unit_selector = $"../UnitSelector"

var selection_circles := []

export(PackedScene) var selection_circle_scene

func _ready():
	var e = unit_selector.connect("on_selection_changed", self, "on_selection_changed")

func on_selection_changed(selected_units):
	print ("[UnitSelectionCircles] on_selection_changed")
	for s in selection_circles:
		s.queue_free()
	selection_circles.clear()
	for selected_unit in selected_units:
		print ("instancing selected circle")
		var selection_circle_instance = selection_circle_scene.instance()
		selection_circles.append(selection_circle_instance)
		selected_unit.add_child(selection_circle_instance)
		
		
