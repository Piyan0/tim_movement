class_name InventoryV2
extends VBoxContainer


@export var _items_slot: Array[ItemSlot]

const _item_picked_drop = 100 
const _item_picked_tween_dur = 0.2 

func _ready() -> void:
    for slot in _items_slot:
        slot.item_picked.connect(func():
            mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
            var t = create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
            t.tween_property(self, "position:y", position.y + _item_picked_drop, _item_picked_tween_dur)
            t.tween_property(self, "modulate:a", 0.0, _item_picked_tween_dur)
        )
        slot.item_dropped.connect(func():
            queue_free()
            # mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_ENABLED
            # var t = create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
            # t.tween_property(self, "modulate:a", 1, _item_picked_tween_dur)
            # t.tween_property(self, "position:y", position.y + (-_item_picked_drop), _item_picked_tween_dur)
        )

static func spawn():
    var ins = load("uid://dxd41a5vnfasq").instantiate()
    return ins