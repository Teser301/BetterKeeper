extends Node3D

@onready var minion_manager : MinionManager = $"../MinionManager"
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	minion_manager.addMinion(global_position)
	pass # Replace with function body.
