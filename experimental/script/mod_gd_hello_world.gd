extends Node


@export_multiline() var developer_text:String 
@export_multiline() var user_text_to_append:String
@export_multiline() var split_line_comment :String="\n\n# ----------------<-DEV  /  USER->------------------- #\n\n" 

@export_group("For Debug")
@export_multiline() var for_debug_last_executed_code:String
@export var created_node_with_script :Node
@export var local_script_file_name:String= "dynamic_script.gd"

func set_developer_text(text:String):
	developer_text = text
	
func set_user_text(text:String): 
	# TODO:  Add file read write protection code later
	user_text_to_append = text




func execute_code() -> void:
	var script_path: String = "user://"+local_script_file_name

	#Something like that
	# 1. Clean up the previous instance
	if created_node_with_script != null:
		created_node_with_script.queue_free()
		created_node_with_script = null

	# 2. Combine the code
	var code: String = "\n".join([developer_text, split_line_comment, user_text_to_append])
	for_debug_last_executed_code = code

	# 3. Create/Overwrite the file in the perma data folder (user://)
	var file = FileAccess.open(script_path, FileAccess.WRITE)
	if file:
		file.store_string(code)
		file.close()
	else:
		push_error("Failed to create file at: %s" % script_path)
		return

	var script = ResourceLoader.load(script_path, "GDScript", 0) 
	if not script is GDScript:
		push_error("Loaded file is not a valid GDScript.")
		return 

	var node: Node = Node.new()
	created_node_with_script = node
	node.set_script(script)
	node.set_process(true)
	node.set_physics_process(true)
	add_child(node)
		

	print("Saved and executed code from: %s" % script_path)
