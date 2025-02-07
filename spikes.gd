extends Node2D  

func _ready():
	$Area2D.connect("body_entered", _on_body_entered)  #Connect signal from Area2D

func _on_body_entered(body):
	if body.name == "Coin Man":  #Detect Coin Man
		body.respawn()  #Call the respawn function
