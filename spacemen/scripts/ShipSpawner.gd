extends Node2D

signal on_ship_spawned

export(Color) var color
export(Color) var body_color
export var spawn_rate := 1.0
export var faction := 0
export var enabled := false
export var max_spawn := 1

export(PackedScene) var ship_scene

var spawn_timer := 0.0
var num_spawned := 0

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
	
	if faction == 1:
		print ("spawning at: " + str(self.global_position))
	
	ship.position = Vector2(rand_range(-5.0, 5.0), rand_range(-5.0, 5.0))
	#ship.global_position = self.global_position
	
	
	# Set identity
	var identity := ship.get_node("Identity") as Identity
	assert(identity != null)
	identity.faction = faction
	identity.color = color
	
	# Add child
	add_child(ship)
	
	num_spawned += 1
	
	emit_signal("on_ship_spawned", ship)
