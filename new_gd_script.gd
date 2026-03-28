extends Node

@export var button_a:bool = false
@export var button_b:bool = false

func set_button_a(is_pressing:bool):
	var has_changed= button_a!=is_pressing
	print("A:",is_pressing)
	button_a = is_pressing
	if has_changed and self.has_method("notify_button_a_changed"):
		self.call("notify_button_a_changed", button_a)
	
func set_button_b(is_pressing:bool):
	var has_changed= button_b!=is_pressing
	button_b = is_pressing
	if has_changed and self.has_method("notify_button_b_changed"):
		self.call("notify_button_b_changed", button_b)



####-------- <DEV|USER> --------####


func notify_button_a_changed(value_is_pressing:bool)->void :
	print("PRESS A:", str(value_is_pressing))
	
func notify_button_b_changed(value_is_pressing:bool)->void :
	print("PRESS B:", str(value_is_pressing))
