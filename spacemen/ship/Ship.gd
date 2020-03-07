extends KinematicBody2D

onready var steering = $Steering

func _ready() -> void:
	pass
	
func issue_arrive_order(arrive_position:Vector2):
	steering.issue_arrive_order(arrive_position)

