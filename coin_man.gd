extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
var jump_count = 0  #For double jump
var coin_count: int = 0 #Tracks the coins
var spawn_position: Vector2 #Sets Spawn Point

@onready var sprite_2d = $Sprite2D
@export var respawn_delay: float = 1.0 #Adjustable delay for repsawning

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < 2:  # for double jump
		jump_count += 1  #for double jump
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var isLeft = velocity.x < 0 #This makes the sprite flip when looking left or right
	sprite_2d.flip_h = isLeft 
	
func _ready():
	spawn_position = position
	
func add_coins(amount):
	coin_count += amount
	print("Coins collected:", coin_count)
	
func respawn():
	hide()
	await get_tree().create_timer(respawn_delay).timeout
	position = spawn_position
	show()
	
