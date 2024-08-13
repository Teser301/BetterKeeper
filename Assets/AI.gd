extends Node3D

@onready var raycast =$"../RayCast3D"
@onready var navAgent = $"../NavigationAgent3D"
@onready var timer = $"../Timer"
@onready var minion: CharacterBody3D = $".."
var speed = 2
var accel = 10

func _physics_process(delta):
	
	var direction = Vector3()
	
	if !navAgent.target_position:
		return
	direction = navAgent.get_next_path_position() - minion.global_position
	direction = direction.normalized()
	
	minion.velocity = minion.velocity.lerp(direction * speed, accel * delta)
	if !raycast.is_colliding():
		minion.move_and_slide()
	

func _on_timer_timeout():
	var x = randi_range(4,-4)
	var z = randi_range(4,-4)
	var destination = Vector3(x, 0, z)
	
	navAgent.target_position = Vector3(x, 0, z)
	pass # Replace with function body.
