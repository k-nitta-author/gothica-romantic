extends Panel

@onready var backButton = $backButton
@onready var save_slots : Array = [
	$HBoxContainer/SaveSlotComponent,
	$HBoxContainer/SaveSlotComponent2,
	$HBoxContainer/SaveSlotComponent3,
	$HBoxContainer/SaveSlotComponent4,
]

const SAVE_FILE_DIRECTORY := "user://"

signal return_to_previous_screen()

func _ready() -> void:
	backButton.connect("pressed", on_back_button_pressed)

	# set each slot visible for each save file
	# none will be visible if there are no save files

	var save_data_array := load_data_from_save_files()

	for i in save_data_array.size():
		save_slots[i].visible = true
		save_slots[i].setup(i, save_data_array[i])

# return to the previous screen; meant to be used with the back button
func on_back_button_pressed() -> void:
	emit_signal("return_to_previous_screen")


# load save files into an array of SaveFileRefs 
func load_data_from_save_files() -> Array[SaveDataRef]:
	var save_data : Array[SaveDataRef]

	var dir = DirAccess.open(SAVE_FILE_DIRECTORY)

	# get all files if any in save file directory
	for file_name in DirAccess.get_files_at(SAVE_FILE_DIRECTORY):

		print(file_name)

		# get save file text and parse the json
		var save_file_body := FileAccess.get_file_as_string(SAVE_FILE_DIRECTORY + "/" + file_name)
		var parsed_json : Dictionary = JSON.parse_string(save_file_body)

		# get the new save data and intilize values
		var newSaveData := SaveDataRef.new()

		newSaveData.placeString = parsed_json["place"]
		newSaveData.playTimeString = parsed_json["play_time"]
		newSaveData.dateString = parsed_json["save_date"]

		save_data.append(newSaveData)

	return save_data
