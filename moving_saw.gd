extends CharacterBody2D

@export var speed: float = 100.0  # Speed of movement
@export var move_distance: float = 200.0  # Distance the saw moves left and right
@export var respawn_coin_man: bool = true  # Should Coin Man respawn if hit?

var start_position: Vector2  # Stores the original position
var direction: int = 1  # Moving direction: 1 = right, -1 = left

func _ready():
	start_position = position  # Save the original position

func _physics_process(delta):
	# Move the saw manually, ignoring collisions
	position.x += speed * direction * delta

	# Reverse direction when reaching the movement limits
	if position.x >= start_position.x + move_distance:
		direction = -1  # Move left
	elif position.x <= start_position.x - move_distance:
		direction = 1  # Move right

	# Check for collision with Coin Man using physics shape query
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	
	# Convert the CollisionPolygon2D into a shape
	var polygon = $CollisionPolygon2D.polygon  # Get the polygon points
	var convex_shape = ConvexPolygonShape2D.new()
	convex_shape.points = polygon  # Assign the polygon shape

	query.set_shape(convex_shape)  # Use the converted polygon shape
	query.transform = global_transform  # Use current position

	var result = space_state.intersect_shape(query)
	for collision in result:
		var body = collision["collider"]
		if body and body.name == "Coin Man":
			if respawn_coin_man:
				body.respawn()  # Call the respawn function on Coin Man
