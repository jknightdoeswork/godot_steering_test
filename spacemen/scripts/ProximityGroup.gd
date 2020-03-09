extends Area2D

signal on_closest_unit_changed
signal on_group_changed
signal on_unit_entered
signal on_unit_exited

var _closest_unit:Node2D = null

enum DetectionType {
	Friendly,
	Enemy
}

export(DetectionType) var detection_type
onready var identity:Identity = $"../Identity" as Identity

func _ready():
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")

func closest_unit():
	return _closest_unit
	
func nearby_units():
	var bodies := get_overlapping_bodies()
	var filtered_bodies := []
	for b in bodies:
		var other_identity = b.get_node("Identity")
		if other_identity != null:
			if identity.is_enemy(other_identity):
				filtered_bodies.append(b)
	
	return filtered_bodies

func identity_compare(id1:Identity, id2:Identity)->bool:
	if detection_type == DetectionType.Friendly:
		return id1.is_friend(id2)
	else:
		return id2.is_enemy(id2)
		
func on_body_entered(body:Node2D):
	#print ("[ProximityGroup] on_body_entered %s" % [body])
	var other_identity = body.get_node("Identity")
	if other_identity != null:
		if identity.is_enemy(other_identity):
			emit_signal("on_unit_entered", body)
			emit_signal("on_group_changed")
	else:
		print ("no id")

func on_body_exited(body:Node):
	#print ("[ProximityGroup] on_body_exited %s" % [body])
	var other_identity = body.get_node("Identity")
	if other_identity != null:
		if identity.is_enemy(other_identity):
			emit_signal("on_unit_exited", body)
			emit_signal("on_group_changed")


func select_closest_unit_from_group(bodies:Array)->Node2D:
	var unit:Node2D = null
	for body in bodies:
		unit = select_closest_unit(unit, body)
	return unit

func select_closest_unit(body1:Node2D, body2:Node2D)->Node2D:
	if body1 == null:
		return body2
	if body2 == null:
		return body1
		
	var my_position:Vector2 = global_position
	var distance1:float = body1.global_position.distance_to(my_position)
	var distance2:float = body2.global_position.distance_to(my_position)
	
	if distance1 < distance2:
		return body1
	return body2

func refresh_closest_unit():
	var old_closest = _closest_unit
	_closest_unit = select_closest_unit_from_group(nearby_units())
	if _closest_unit != old_closest:
		#print ("new closest unit %s" %[closest_unit])
		emit_signal("on_closest_unit_changed")
		
func _physics_process(delta):
	refresh_closest_unit()
	
