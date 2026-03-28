## DEVELOPER CODE

extends Node

func say_hello()->void:
	print("Hello World")
func _ready()->void:
	user_ready()



####-------- <DEV|USER> --------####


## USER CODE
func user_ready()->void:
	say_hello()
	print("Hey o")
