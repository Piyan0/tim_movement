class_name InventoryV2
extends VBoxContainer


@export var _normal_items_slot: Array[ItemSlot]
@export var _crystal_items_slot: Array[ItemSlot]


var items_slot_data: Array[SlotData]

var _items_slot: Array[ItemSlot]:
    get(): return _normal_items_slot + _crystal_items_slot 

const _item_picked_drop = 100 
const _item_picked_tween_dur = 0.2 
const TYPE_CRYSTAL = "crsytal"
const TYPE_NORMAL = "normal"


func _ready() -> void:
    for slot in _items_slot :
        slot.item_picked.connect(func():
            mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
            var t = create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
            t.tween_property(self, "position:y", position.y + _item_picked_drop, _item_picked_tween_dur)
            t.tween_property(self, "modulate:a", 0.0, _item_picked_tween_dur)
        )
        slot.item_dropped.connect(func():
            queue_free()
        )
    
    # _update(items_slot_data)


func _input(event: InputEvent) -> void:
    if event is InputEventMouse || event is InputEventScreenTouch:
        if event.is_pressed():
            if !get_global_rect().has_point(event.position):
                # printt(get_global_rect(), get_rect(), event.position)
                accept_event()
                queue_free()


static func spawn():
    var ins = load("uid://dxd41a5vnfasq").instantiate()
    return ins
        

func from_data(data: Array[Dictionary]):
    var slot_data: Array[SlotData] = []
    for value in data:
        var image_icon = load(Bootstrap.items_db.get_item(value.id).path)
        slot_data.append(
            SlotData.new(value.type, value.id, image_icon)
        )
    _update(slot_data)
    


func _preupdate_items():
    for slot in _items_slot:
        slot.item_id = ""
        slot.icon = CompressedTexture2D.new()


func _update(item_slot_data: Array[SlotData]):
    _preupdate_items()
    for slot_data in item_slot_data:
        var slot: ItemSlot = _get_slot(slot_data.type)
        if slot == null:
            return
        slot.item_id = slot_data.item_id
        slot.icon = slot_data.item_icon




func _get_slot(type = TYPE_NORMAL):
    var slot_data = []
    match type:
        TYPE_NORMAL:
            slot_data = _normal_items_slot
        TYPE_CRYSTAL:
            slot_data = _crystal_items_slot

    for slot in slot_data:
        if slot.is_empty:
            return slot
    
    return null
    

class SlotData:
    var type = -1
    var item_id: String
    var item_icon: Texture2D

    func _init(type, item_id, item_icon):
        self.type = type
        self.item_id = item_id
        self.item_icon = item_icon

    