class_name SaveManager
extends Node

const USER_FILE_DIRECTORY := "user://"
const SAVE_FILE_DIRECTORY := "user://save/"

var save_file_data : Array[SaveDataRef]

func create_file_name(fileIdx: int) -> String: return SAVE_FILE_DIRECTORY + str(fileIdx) + ".sav"

func create_save_file(idx: int, save_data_callback: Callable) -> void:
	var f = FileAccess.open(create_file_name(idx), FileAccess.WRITE)

	save_data_callback.call(f)

	f.close()

# get the save dir or create it
func get_save_dir() -> DirAccess:

	if DirAccess.dir_exists_absolute(SAVE_FILE_DIRECTORY):
		return DirAccess.open(SAVE_FILE_DIRECTORY)

	var dir = DirAccess.open(USER_FILE_DIRECTORY)
	var save_dir = dir.make_dir("save")

	return save_dir

# load save files into an array of SaveFileRefs 
func load_data_from_save_files() -> Array[SaveDataRef]:
	var save_data : Array[SaveDataRef]

	var dir = get_save_dir()

	# get all files if any in save file directory
	for file_name in dir.get_files():

		# get save file text and parse the json
		var save_file_body := FileAccess.get_file_as_string(SAVE_FILE_DIRECTORY + "/" + file_name)
		var parsed_json : Dictionary = JSON.parse_string(save_file_body)

		# get the new save data and intilize values
		var newSaveData := SaveDataRef.new()

		newSaveData.placeString = parsed_json["place"]
		newSaveData.playTimeString = str(parsed_json["play_time"])
		newSaveData.dateString = parsed_json["save_date"]

		save_data.append(newSaveData)

		save_file_data = save_data

	return save_data