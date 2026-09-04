extends Node2D

@onready var children := get_children()
var stage

func add_bullet(bullet: BaseBullet, pos: Vector2) -> void:
	var b : BaseBullet = bullet
	b.global_position = pos
	b.bind_dependencies(stage)
	add_child(b)
	children.append(b)
	
func bind_dependencies(s: Stage):	
	stage = s

	for c in children:
		c.bind_dependencies(stage)

func _physics_process(delta: float) -> void:
	for c in children: c.update(delta) # call update on each bullet 
