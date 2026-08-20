class_name BaseProp
extends Area2D

@onready var sprite2D = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var anim = $anim

@export var isInactive: bool: set = set_is_inactive 

@export var maxHitPoints: int:
	set(value):
		maxHitPoints = value
		hitPoints = maxHitPoints

var hitPoints : int:
	set(value):
		hitPoints = clamp(value, 0, maxHitPoints)
		
		isInactive = (hitPoints == 0)            

signal destroyed(prop: BaseProp)

func set_is_inactive(value: bool):
		isInactive = value

		call_deferred("set", "monitorable", !value)
		call_deferred("set", "monitoring", !value)

		visible = !value

		if isInactive: emit_signal("destroyed", self)

func _ready() -> void:
	self.connect("area_entered", OnAreaEntered)

func OnAreaEntered(area: Area2D) -> void:

	hitPoints -= 1

# to be overriden by child classes
func update() -> void:

	if isInactive: return

func bind_dependencies(stage: Stage) -> void:
	pass


func on_triggered() -> void:
	pass