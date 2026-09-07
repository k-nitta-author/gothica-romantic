extends Node2D

@onready var props := get_children()

var bullet_collectible := preload("uid://dm5vcf468tpcc")
var hp_collectible := preload("uid://c0mt74e0g4ia6")

enum DROPS {NONE, HP, BULLET}

func _ready() -> void:
	for p in props:
		p.connect("destroyed", OnPropDestroyed)

func OnPropDestroyed(prop: BaseProp) -> void:
	pass

func bind_dependencies(stage: Stage) -> void:
	for p in props:
		p.bind_dependencies(stage)

		if p is BreakableProp:
			p.connect("destroyed", stage.spawn_collectible)

func add_collectible(drop: DROPS, pos: Vector2) -> void:
	
	var node: Node2D

	match drop:
		DROPS.NONE: return
		DROPS.BULLET: node = bullet_collectible.instantiate()
		DROPS.HP: node = hp_collectible.instantiate()

	node.global_position = pos

	call_deferred("add_child", node)

func _physics_process(_delta: float) -> void:

	for p in props: p.update()
