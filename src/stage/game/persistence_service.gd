class_name PersistenceService
extends Resource

var primary_save_file_path: String
var secondary_save_file_path: String

var in_memory_save_data : Dictionary

func retrieve_flag_value(flag_name: String) -> bool: return in_memory_save_data[flag_name]

func update_flag_value(flag_name: String, new_value: bool) -> bool:
    in_memory_save_data[flag_name] = new_value
    
    return in_memory_save_data[flag_name]

func bind_dependencies(game: Game) -> void:
    pass

func load_game() -> Dictionary:
    return {}

func save_game() -> void:
    pass