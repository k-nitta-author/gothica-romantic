extends Node2D

@onready var props := get_children()

func _ready() -> void:
	for p in props:
		p.connect("destroyed", OnPropDestroyed)

func OnPropDestroyed(prop: BaseProp) -> void:
	pass

func bind_dependencies(stage: Stage) -> void:
	for p in props:
		p.bind_dependencies(stage)

func _physics_process(_delta: float) -> void:

	for p in props: p.update()
