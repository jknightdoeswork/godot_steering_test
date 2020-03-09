extends Node

signal on_selection_changed

var selected_units := []

var selection_area:Area2D = null
var selection_box:Polygon2D = null

onready var input_signals = $"../InputSignals"
var ship_spawners = ["../BlueTeam", "../RedTeam"]

func _ready():
	# Input Signals
	var error = input_signals.connect("on_left_mouse_down", self, "on_left_mouse_down")
	assert(error == OK)
	error = input_signals.connect("on_right_mouse_down", self, "on_right_mouse_down")
	assert(error == OK)
	
	# Spawner Signals
	for s in ship_spawners:
		var ship_spawner = get_node(s)
		assert(ship_spawner != null)
		error = ship_spawner.connect("on_ship_spawned", self, "on_ship_spawned")
		assert(error == OK)

func select_units(units:Array):
	# Set array
	selected_units = units
	emit_signal("on_selection_changed", selected_units)



func deselect_units():
	select_units([])

func on_left_mouse_down(position:Vector2):
	deselect_units()

func on_right_mouse_down(position:Vector2):
	if selected_units.size() > 0:
		for selected_unit in selected_units:
			selected_unit.issue_arrive_order(position)

func on_ship_clicked(ship):
	pass

func on_ship_spawned(ship):
	var health = ship.get_node("Health")
	if health != null:
		health.connect("on_death", self, "on_selected_unit_death", [ship], CONNECT_ONESHOT)
	else:
		print ("[UnitSelector] on_ship_spawned " + str(ship))

func on_selected_unit_death(unit:Node):
	if selected_units.has(unit):
		selected_units.erase(unit)
		emit_signal("on_selection_changed", selected_units)
