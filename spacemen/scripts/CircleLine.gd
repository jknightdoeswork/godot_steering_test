tool
extends Line2D
export var numsides = 32 setget set_numsides
export var radius = 10.0 setget set_radius

func create_poly(var n, var r):
	#print ("[CirclePolygon] create_poly (" + str(n) + ", " + str(r) + ")")
	var new_poly = []
	var angle_delta = (2.0*PI) / (n-1)

	for x in range(n):
		var angle = angle_delta*x
		new_poly.append(Vector2(
			10 * r * cos(angle),
			10 * r * sin(angle)))

	points = new_poly

func set_radius(new_radius):
	if radius != new_radius:
		radius = new_radius
		create_poly(numsides, radius)
		property_list_changed_notify()

func set_numsides(new_n):
	if numsides != new_n:
		numsides = new_n
		create_poly(numsides, radius)
		property_list_changed_notify()
