class_name EffectPool
extends RefCounted

var in_use : Array[BaseEffect]
var available : Array[BaseEffect]

func populate(pop_num: int, effect: PackedScene) -> EffectPool:
    for i in range(pop_num):
        var e : BaseEffect = effect.instantiate()
        e.pool = weakref(self)
        available.append(e)
    return self

func get_from_pool() -> BaseEffect:
    var e = available.pop_back()
    in_use.append(e)
    return e

func return_to_pool(e: BaseEffect) -> void:
    var idx = in_use.find(e)
    in_use.remove_at(idx)
    available.append(e)

func clean_object(e: BaseEffect) -> void:
    pass