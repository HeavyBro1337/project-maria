class_name ControlComponent extends Node


@export var velocity_component: VelocityComponent
@export var acceleration: float = 5.0


func _process(delta: float) -> void:
	var dir := Input.get_vector("left", "right", "up", "down")
	
	var current_velocity := velocity_component.velocity
	var modified := current_velocity.move_toward(dir, delta * acceleration)
	
	velocity_component.velocity = modified
