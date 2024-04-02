extends Node


@export var other_trigger: InputTriggerComponent


func enable_trigger() -> void:
	other_trigger.disabled = false
