class_name ControlComponent extends Node


@export var character: CharacterBody2D

const GRID_SIZE := 16.0
var t: Tween
var target_position: Vector2


func _process(_delta: float) -> void:
	if t != null and t.is_running(): return
	
	var dir := Input.get_vector("left", "right", "up", "down")
	
	if dir == Vector2.ZERO:
		return
		
	if character.move_and_collide(dir * GRID_SIZE, true) == null:
		var pos := character.position
		t = create_tween()
		t.tween_property(character, "position", pos + dir * GRID_SIZE, 0.15)
		await t.finished
		TurnManager.step()
		t.stop()
