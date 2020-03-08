extends Line2D

export var lifetime := 1.0

var age := 0.0

func _process(delta: float) -> void:
	age += delta
	if age > lifetime:
		queue_free()
