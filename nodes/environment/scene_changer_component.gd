@tool
class_name SceneChangerComponent extends Node


@export_file("*.tscn") var target_scene: String


func _get_configuration_warnings() -> PackedStringArray:
	if target_scene == null:
		return ["У этого узла не установлена сцена!"]
	return []


func change_scene() -> void:
	Transition.change_scene_to_file(target_scene)


func reload_scene() -> void:
	get_tree().reload_current_scene()


func quit_game() -> void:
	get_tree().quit()
