class_name SaveManager
extends Node

const USER_FILE_DIRECTORY := "user://"
const SAVE_FILE_DIRECTORY := "user://save"

func create_file_name(fileIdx: int) -> String: return str(fileIdx) + ".sav"

func create_save_file(save_data_callback: Callable) -> void:
	var f = FileAccess.open(SAVE_FILE_DIRECTORY + create_file_name(1), FileAccess.WRITE)

	save_data_callback.call(f)

	f.close()