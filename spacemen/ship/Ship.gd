extends KinematicBody2D

signal on_ship_clicked

var agent := GSAIKinematicBody2DAgent.new(self)
var arrive_target := GSAIAgentLocation.new()
var arrive := GSAIArrive.new(agent, arrive_target)
var look := GSAILookWhereYouGo.new(agent)
var blend := GSAIBlend.new(agent)
var _accel := GSAITargetAcceleration.new()

var _velocity := Vector2()
var _drag := 0.1

func _ready() -> void:
	
	
	agent.linear_speed_max = 8000.0
	agent.linear_acceleration_max = 500.0
	agent.linear_drag_percentage = 0.1
	agent.angular_speed_max = 250.0
	agent.angular_acceleration_max = 100.0
	agent.angular_drag_percentage = 0.25

	arrive_target.position = agent.position
	arrive.deceleration_radius = 250.0
	arrive.arrival_tolerance = 25.0
	
	look.alignment_tolerance = deg2rad(5.0)
	look.deceleration_radius = deg2rad(45)
	blend.add(arrive, 1.0)
	blend.add(look, 1.0)
	
	
	
func issue_arrive_order(arrive_position:Vector2):
	print ("[Ship] issue_arrive_order: %s" % [arrive_position])
	arrive_target.position = GSAIUtils.to_vector3(arrive_position)
	arrive_target.orientation = rand_range(0.0, 2.0*PI)
	#arrive_target.orientation = position.angle_to(arrive_position)
	
func _physics_process(delta: float) -> void:
	blend.calculate_steering(_accel)
	agent._apply_steering(_accel, delta)

func _input_event(viewport: Object, e: InputEvent, shape_idx: int):
	if e is InputEventMouseButton:
		if e.button_index == 1 and e.pressed:
			print ("[Ship] ship clicked")
			emit_signal("on_ship_clicked", self)
			get_tree().set_input_as_handled()
