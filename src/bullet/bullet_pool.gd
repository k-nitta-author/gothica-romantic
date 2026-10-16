class_name BulletPool
extends RefCounted

var in_use : Array[BaseEffect]
var available : Array[BaseEffect]

func populate(pop_num: int, effect: PackedScene) -> BulletPool:
    for i in range(pop_num):
        var e : BaseBullet = effect.instantiate()
        e.pool = weakref(self)
        available.append(e)
    return self

func get_from_pool() -> BaseBullet:
    var e = available.pop_back()
    in_use.append(e)
    return e

func return_to_pool(e: BaseBullet) -> void:
    var idx = in_use.find(e)
    in_use.remove_at(idx)
    available.append(e)

func clean_object(e: BaseBullet) -> void:
    pass