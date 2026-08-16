class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var tileMapLayer = $TileMapLayer
@onready var hudLayer = $HudLayer

@export var currentStageFilePath : String

func load_stage(file_path: String) -> Stage:
    return null

func unload_stage(current_stage: Stage) -> void:
    pass