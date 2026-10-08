class_name CollectibleProp
extends BaseProp

signal collected(collectible: CollectibleProp)

@export var fall_speed := 100

const TIME_TILL_CAN_BE_COLLECTED := .5

var can_be_collected := false

func _ready() -> void:
	super()
	connect("body_entered", on_body_entered)

	var t := get_tree().create_timer(TIME_TILL_CAN_BE_COLLECTED)

	t.connect("timeout", on_timer_timeout)

func on_timer_timeout() -> void:
	can_be_collected = true 

func on_body_entered(_body: Node2D) -> void: fall_speed = 0

func _physics_process(delta: float) -> void:

	self.global_position.y += fall_speed * delta

func collect() -> void:
	if can_be_collected:
		emit_signal("collected", self)
		hitPoints -= 1

func OnAreaEntered(area: Area2D) -> void:
	super(area)
	collect()
	

