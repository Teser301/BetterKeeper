extends Sprite3D

signal no_hp_left

@export var max_hp : int = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewport/Panel/ProgressBar.max_value = max_hp
	$SubViewport/Panel/ProgressBar.value = max_hp

func take_damage(damage: float):
	$SubViewport/Panel/ProgressBar.value -= damage
	
	if $SubViewport/Panel/ProgressBar.value <= 0.1:
		no_hp_left.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
