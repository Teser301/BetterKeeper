extends CharacterBody3D
var names = [
	"Wiggle McJiggles",
	"Bumpy Knuckles",
	"Fluffy McPuffins",
	"Sir Laughs-a-Lot",
	"Doodle Von Noodle",
	"Giggly Wiggly",
	"Snickers O'Chuckles",
	"Wobbleton Jellifish",
	"Captain Quirk",
	"Silly McPickles"
]
var Name

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # Optional, makes sure random values are different each time
	var random_name = names[randi() % names.size()]
	Name = random_name
	print("Randomly selected name: ", random_name)
	move_and_slide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
