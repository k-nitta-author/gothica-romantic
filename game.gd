class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = $Stage

@export var next_level_scene: PackedScene

# saveable data
var stage_number: int
var area : String 
var gun_state: String
var player_hp: int

func _ready() -> void:
	pass

# polls the current game state to supply data to the save file
func poll_game_state() -> Dictionary:
	return {
		"current_stage_number": stage_number,
		"current_area": area,
		"current_gun_state": gun_state,
		"current_player_hp": player_hp
	}

func start_stage():
	
	var s = load_stage(next_level_scene)
	add_child(s)

func load_stage(nextLevel: PackedScene) -> Stage: return nextLevel.instantiate()

func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null
