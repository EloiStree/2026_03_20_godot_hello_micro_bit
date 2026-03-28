class_name MicroBitModdingInterfaceToNode
extends Node

@export var node_to_affect:Node

@export_group("Variable")
@export var name_of_var_leds_percent_array ="leds_percent_5x5"
@export var name_of_var_button_a ="button_a"
@export var name_of_var_button_b ="button_b"
@export_group("Function in")
@export var name_of_call_leds_changed ="mod_in_set_leds_array_changed"
@export var name_of_call_set_button_a ="mod_in_set_button_a_changed"
@export var name_of_call_set_button_b ="mod_in_set_button_b_changed"
@export var name_of_call_a_value_changed ="mod_in_on_a_value_changed"

func set_node_to_affect(node:Node):
	node_to_affect = node
	

func set_variable_to(variable_name:String, set_method_name:String, value):
	if node_to_affect!=null and node_to_affect.has_method(set_method_name):
		node_to_affect.call(set_method_name,value)
	if node_to_affect and variable_name in node_to_affect:
		node_to_affect.set(variable_name,value)
	notify_a_value_changed()
	
	
func call_methode_without_params(methode_name:String):
	if node_to_affect and node_to_affect.has_method(methode_name):
		node_to_affect.call(methode_name)	
			

func notify_a_value_changed():
	call_methode_without_params(name_of_call_a_value_changed)	
	
	
func set_leds_percent_with_random_5x5():
	var random_5x5:Array[float]= []
	for i in range(25):
		random_5x5.append(randf())
	set_leds_percent_array(random_5x5)
	
func set_leds_percent_array(array:Array[float]):
	set_variable_to(name_of_var_leds_percent_array, name_of_call_leds_changed, array)
	

func set_button_a_state(is_pressing:bool):
	set_variable_to(name_of_var_button_a, name_of_call_set_button_a, is_pressing)
		
func set_button_b_state(is_pressing:bool):
	set_variable_to(name_of_var_button_b, name_of_call_set_button_b, is_pressing)
		
