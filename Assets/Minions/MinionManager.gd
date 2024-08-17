extends Node3D
class_name MinionManager

@export var minions: Array[Node3D] = []
@onready var minionPrefab = preload("res://Assets/Minions/Skeleton_Minion.tscn")

var minion_cap = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addMinion(pos):
	if minions.size() >= minion_cap:
		return
	var minionSpawn = minionPrefab.instantiate()
	add_child(minionSpawn)
	minionSpawn.position = pos
	minions.append(minionSpawn)
