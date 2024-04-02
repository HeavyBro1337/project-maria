class_name VelocityComponent extends Node


@export var deceleration_speed: float = 0.0
@export var speed: float
@export var decelerating: bool = false

var velocity: Vector2


func force_set_velocity(value: Vector2) -> void:
	velocity = value


func _physics_process(delta: float) -> void:
	_decelerate(delta)


func _decelerate(delta: float) -> void:
	if not decelerating: return
	
	velocity = velocity.lerp(Vector2.ZERO, delta * deceleration_speed)


func get_velocity_of_speed() -> Vector2:
	return velocity * speed
