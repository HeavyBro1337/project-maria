extends CanvasLayer


@export var animation_player: AnimationPlayer


func change_scene_to_packed(scene: PackedScene) -> void:
	animation_player.play("fade")
	get_tree().paused = true
	await animation_player.animation_finished
	get_tree().paused = false
	animation_player.play_backwards("fade")
	get_tree().change_scene_to_packed(scene)


func change_scene_to_file(path: String) -> void:
	change_scene_to_packed(load(path))
