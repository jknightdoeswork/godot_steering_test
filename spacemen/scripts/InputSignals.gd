extends Node

export var process_input			:= false
export var process_unhandled_input 	:= false

signal on_left_mouse_pressed
signal on_right_mouse_pressed

func _input(event):
	if process_input:
		process_input_event(event)

func _unhandled_input(event):
	if process_unhandled_input:
		process_input_event(event)

func process_input_event(e:InputEvent):
	if e is InputEventMouseButton:
		if e.pressed and e.button_index == 1:
			emit_signal("on_left_mouse_down", e.position)
		if !e.pressed and e.button_index == 1:
			emit_signal("on_left_mouse_up", e.position)
		
		if e.pressed and e.button_index == 2:
			emit_signal("on_right_mouse_down", e.position)
		if !e.pressed and e.button_index == 2:
			emit_signal("on_right_mouse_up", e.position)

