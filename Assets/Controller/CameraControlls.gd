extends Node3D

@export var movespeed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direciton = Vector3.ZERO
	var boost = 1
	
	if Input.is_action_pressed("Shift"):
		boost = 3
	if Input.is_action_pressed("W"):
		direciton.x += 1
	if Input.is_action_pressed("S"):
		direciton.x -= 1
	if Input.is_action_pressed("A"):
		direciton.z -= 1
	if Input.is_action_pressed("D"):
		direciton.z += 1
		
	position += direciton * delta * movespeed * boost
