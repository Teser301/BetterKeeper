extends Node3D

@onready var raycast =$"../RayCast3D"
@onready var navAgent = $"../NavigationAgent3D"
@onready var timer = $"../Timer"
@onready var minion: CharacterBody3D = $".."
@onready var health_bar = $"../Health Bar"
@onready var model = $"../Rig"
@onready var anim_player = $"../AnimationPlayer"
@onready var anim_tree = $"../AnimationTree"
@onready var anim_state = $"../AnimationTree".get("parameters/playback")
var speed = 2
var accel = 10

func _physics_process(delta):
	health_bar.take_damage(1.0)
	var direction = Vector3()
	
	if !navAgent.target_position:
		return
	direction = navAgent.get_next_path_position() - minion.global_position
	direction = direction.normalized()
	
	minion.velocity = minion.velocity.lerp(direction * speed, accel * delta)
	var vl = minion.velocity * model.transform.basis
	anim_tree.set("parameters/IWR/blend_position", Vector2(vl.x, -vl.z / speed))
	if !navAgent.is_navigation_finished():
		minion.move_and_slide()
		var turn_to = navAgent.get_next_path_position()
		minion.look_at(turn_to, Vector3.UP, true)
	

func _on_timer_timeout():
	var x = randi_range(4,-4) + minion.global_position.x
	var z = randi_range(4,-4) + minion.global_position.z
	var destination = Vector3(x, 0, z)
	navAgent.target_position = Vector3(x, 0, z)
	
	pass # Replace with function body.
