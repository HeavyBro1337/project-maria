extends Node


@export var control_component: ControlComponent
@export var disabled: bool


func _physics_process(_delta: float):
	if disabled: return
	
	var parent := get_parent()
	parent.position += control_component
	parent.move_and_collide()
	
	get_parent().move_and_slide()
