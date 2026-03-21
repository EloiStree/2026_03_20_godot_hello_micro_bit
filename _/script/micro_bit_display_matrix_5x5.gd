class_name MicroBitDisplayMatrix5X5
extends Node3D

const MAX_LED_COUNT:int =25
const MAX_LINE_COUNT:int =5
const MAX_COLUMN_COUNT:int =5
const MAX_LED_INDEX:int =24
const MAX_LINE_INDEX:int =4
const MAX_COLUMN_INDEX:int =4


const IMAGE_EMPTY:String = "00000:00000:00000:00000:00000"
const IMAGE_FULL:String = "99999:99999:99999:99999:99999"
const IMAGE_HEART:String = "00000:09090:99999:09990:00900"
const IMAGE_SQUARE:String = "99999:90009:90009:90009:99999"
const IMAGE_AIM_SQUARE:String = "99999:90009:90909:90009:99999"
const IMAGE_CROSS:String = "90009:09090:00900:09090:90009"







@export var array_of_led:Array[MicroBitChangeLedColorWithSignal] 




func _ready():
	if array_of_led.size() != MAX_LED_COUNT:
		push_error("array_of_led must have exactly " + str(MAX_LED_COUNT) + " elements.")


	clear()	
	##set_with_text(IMAGE_AIM_SQUARE)
#
	#append_full_column(0)
	#await get_tree().create_timer(1.0).timeout
	#append_full_line(0)
	#await get_tree().create_timer(1.0).timeout
	#for i in range(100):
		#set_random_display()
		#await get_tree().create_timer(0.05).timeout
	set_with_text(IMAGE_HEART)


#region IS VALIDE

func is_valide_index_1d(value_0_24:int)->bool:
	if value_0_24 < 0 or value_0_24 > MAX_LED_INDEX:
		return false
	return true

func is_valide_index_2d(line_0_4:int, column_0_4:int)->bool:
	if line_0_4 < 0 or line_0_4 > MAX_LINE_INDEX:
		return false
	if column_0_4 < 0 or column_0_4 > MAX_COLUMN_INDEX:
		return false
	return true
#endregion	

#region CONVERT
func convert_2d_to_1d(line_0_4:int, column_0_4:int)->int:
	return line_0_4 * MAX_COLUMN_COUNT + column_0_4

func convert_1d_to_2d(index_0_24:int)->Vector2i:
	var line_0_4:int = int(index_0_24 / MAX_COLUMN_COUNT)
	var column_0_4:int = index_0_24 % MAX_COLUMN_COUNT
	return Vector2i(line_0_4, column_0_4)
	
#endregion

func clear():
	set_all_leds_to_percent(0.0)

func full():
	set_all_leds_to_percent(1.0)


func append_full_line(line_0_4:int):
	if not is_valide_index_2d(line_0_4, 0):
		return
	for column in range(MAX_COLUMN_COUNT):
		set_percent_at_2d_index(line_0_4, column, 1.0)

func append_full_column(column_0_4:int):
	if not is_valide_index_2d(0, column_0_4):
		return
	for line in range(MAX_LINE_COUNT):
		set_percent_at_2d_index(line, column_0_4, 1.0)


func set_random_display():
	for i in range(MAX_LED_COUNT):
		var random_percent:float = randf()
		set_percent_at_1d_index(i, random_percent)

func set_all_leds_to_percent(percent_0_1:float):
	for led in array_of_led:
		led.set_color_red_with_percent(percent_0_1)


func set_percent_at_1d_index(index_0_24:int, percent_0_1:float):
	if not is_valide_index_1d(index_0_24):
		return
	array_of_led[index_0_24].set_color_red_with_percent(percent_0_1)

func set_percent_at_2d_index(line_0_4:int, column_0_4:int, percent_0_1:float):
	if not is_valide_index_2d(line_0_4, column_0_4):
		return
	var index_0_24:int = convert_2d_to_1d(line_0_4, column_0_4)
	set_percent_at_1d_index(index_0_24, percent_0_1)

func set_char_at_1d_index(index_0_24:int, chararacter:String):
	if not is_valide_index_1d(index_0_24):
		return
	array_of_led[index_0_24].set_color_red_with_0_to_9_char(chararacter)

func set_char_at_2d_index(line_0_4:int, column_0_4:int, chararacter:String):
	if not is_valide_index_2d(line_0_4, column_0_4):
		return
	var index_0_24:int = convert_2d_to_1d(line_0_4, column_0_4)
	set_char_at_1d_index(index_0_24, chararacter)


func set_with_text(text:String):
	text = text.replace(" ", "").replace("\n", "").replace("\t", "").replace("\r", "").replace(":", "")
	clear()
	var char_array:Array = text.split("")
	for i in range(char_array.size()):
		if i >= MAX_LED_COUNT:
			break
		set_char_at_1d_index(i, char_array[i])
