extends Node

export(Color) var color
export(Color) var body_color
export var spawn_rate := 1.0
export var faction := 0

export(PackedScene) var ship_scene

var spawn_timer := 0.0

func _process(delta: float) -> void:
	if spawn_timer <= 0:
		spawn_timer = spawn_rate
		spawn_ship()
	else:
		spawn_timer -= delta

func spawn_ship():
	var ship = ship_scene.instance()
	add_child(ship)
	
	# Set identity
	var identity := ship.get_node("Identity") as Identity
	assert(identity != null)
	identity.faction = faction
	
	# Set Color
	var body_poly := ship.get_node("BodyPolygon") as Polygon2D
	assert(body_poly != null)
	body_poly.color = body_color
	
	var line_poly := ship.get_node("BodyLine") as Line2D
	assert(line_poly != null)
	line_poly.default_color = color
