class_name SaveDataRef
extends RefCounted

var dateString: String
var playTimeString: String
var placeString: String

func Save(place_string: String, play_time_string: String) -> void:
    dateString = Time.get_date_string_from_system()
    playTimeString = play_time_string
    placeString = place_string