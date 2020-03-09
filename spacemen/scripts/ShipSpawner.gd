extends Node2D

signal on_ship_spawned

export(Color) var color
export(Color) var body_color
export var spawn_rate := 1.0
export var faction := 0
export var enabled := false
export var max_spawn := 1
export var initial_spawn := 0
export(PackedScene) var ship_scene

var spawn_timer := 0.0
var num_spawned := 0

var ships := []

func _ready():
	if enabled:
		for i in range(initial_spawn):
			spawn_ship()

func _process(delta: float) -> void:
	if spawn_timer <= 0:
		spawn_timer = spawn_rate
		spawn_ship()
	else:
		spawn_timer -= delta

func spawn_ship():
	if !enabled:
		return
	if max_spawn > -1:
		if num_spawned >= max_spawn:
			return
		
	var ship := ship_scene.instance() as KinematicBody2D
	assert(ship != null)
	
	ship.position = Vector2(rand_range(-5.0, 5.0), rand_range(-5.0, 5.0))
	
	
	# Set identity
	var identity := ship.get_node("Identity") as Identity
	assert(identity != null)
	identity.faction = faction
	identity.color = color
	
	# Watch for death
	var health = ship.get_node("Health")
	assert(health != null)
	var e = health.connect("on_death", self, "on_ship_died", [ship])
	assert(e == OK)
	
	# Add child
	add_child(ship)
	
	num_spawned += 1
	
	ships.append(ship)
	emit_signal("on_ship_spawned", ship)

func on_ship_died(ship):
	ships.erase(ship)
