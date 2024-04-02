class_name ProgressComponent extends Node


signal done()
signal progressed()


@export var max: int = 3


var current: int = 0


func progress() -> void:
	progressed.emit()
	current += 1
	if current == max:
		done.emit()
