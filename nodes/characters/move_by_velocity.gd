extends Node


@export var velocity_component: VelocityComponent
@export var disabled: bool


func _physics_process(_delta: float):
	if disabled: return
	
	var parent := get_parent()
	parent.velocity = velocity_component.get_velocity_of_speed()
	parent.move_and_slide()
	
	get_parent().move_and_slide()
