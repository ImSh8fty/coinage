extends Area2D

@export var coin_value: int = 1  # The value of this coin

func _ready():
	connect("body_entered", _on_body_entered)  # Detects when something enters the coin's area

func _on_body_entered(body):
	if body.name == "Coin Man":  # Check if the entered body is "Coin Man"
		body.add_coins(coin_value)  # Call a function on "Coin Man" to update score
		queue_free()  # Remove the coin
