extends Node

onready var identity		:= $"../Identity"
onready var nearby			:= $"../NearbyEnemies"
onready var kinematic_body 	:= $"../" as KinematicBody2D
onready var agent 			:= GSAIKinematicBody2DAgent.new(kinematic_body, GSAIKinematicBody2DAgent.MovementType.COLLIDE)
onready var arrive_target 	:= GSAIAgentLocation.new()
onready var arrive 			:= GSAIArrive.new(agent, arrive_target)
onready var look 			:= GSAILookWhereYouGo.new(agent)
onready var blend 			:= GSAIBlend.new(agent)
onready var avoid_prox		:= GSAIRadiusProximity.new(agent, [], 25.0)
onready var avoid			:= GSAIAvoidCollisions.new(agent, avoid_prox)
var _accel 					:= GSAITargetAcceleration.new()
var _velocity 				:= Vector2.ZERO
var _drag 					:= 0.1

func _ready() -> void:
	agent.position 					= GSAIUtils.to_vector3(kinematic_body.global_position)
	agent._last_position			= kinematic_body.global_position
	agent.linear_speed_max 			= 250.0
	agent.linear_acceleration_max 	= 1500.0
	agent.linear_drag_percentage 	= 0.1
	agent.angular_speed_max 		= 250.0
	agent.angular_acceleration_max 	= 100.0
	agent.angular_drag_percentage 	= 0.4
	agent.bounding_radius			= 10.0
	arrive_target.position 			= agent.position
	arrive.deceleration_radius 		= 100.0
	arrive.arrival_tolerance 		= 50.0
	
	look.alignment_tolerance = deg2rad(10.0)
	look.deceleration_radius = deg2rad(30)
	
	blend.add(avoid, 1.0)
	blend.add(arrive, 1.0)
	blend.add(look, 1.0)



func issue_arrive_order(arrive_position:Vector2):
	#print ("[ShipSteering] issue_arrive_order: %s" % [arrive_position])
	arrive_target.position = GSAIUtils.to_vector3(arrive_position)
	arrive_target.orientation = rand_range(0.0, 2.0*PI)
	
func _physics_process(delta: float) -> void:
	
	# Add nearby agents to avoidance
	avoid_prox.agents.clear()
	for u in nearby.nearby_units():
		var other_steering = u.get_node("Steering")
		if other_steering != null:
			var other_agent = other_steering.agent
			if other_agent != null:
				avoid_prox.agents.append(other_agent)
			else:
				printerr("[ShipSteering] node doesnt have agent")
		else:
			printerr("[ShipSteering] node doesnt have steering")
	blend.calculate_steering(_accel)
	
	agent._apply_steering(_accel, delta)
	
