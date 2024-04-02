extends Node


signal stepped()


func step() -> void:
	stepped.emit()	
