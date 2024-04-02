## Триггер для активации чего либо в зависимости от действия игрока
class_name InputTriggerComponent extends Area2D

 ## Отключить триггер, который ни на что не будет реегировать
@export var disabled: bool
## Если значение `true`, то не ожидать нажатие клавиши от игрока
@export var automatic: bool


## Сигнал, который эмитируется, если игрок заходит в зону и нажимает клавишу (если `automatic == false`)
signal triggered()
signal player_exited()
signal player_entered()

## Находится ли игрок в зоне триггера?
var active: bool = false


func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)


func _body_entered(n: Node2D) -> void:
	if Player.instance == n:
		active = true
		player_entered.emit()


func _body_exited(n: Node2D) -> void:
	if Player.instance == n:
		active = false
		player_exited.emit()


func _process(_delta: float) -> void:
	if disabled: return
	
	if (automatic or Input.is_action_just_pressed("interact")) and active:
		triggered.emit()
