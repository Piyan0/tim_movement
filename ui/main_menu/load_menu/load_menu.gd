extends Control
class_name LoadMenu

signal slot_clicked(slot, has_data)

@export var _btn_back: HoverableButton
@export var _slot_list: Array[Slot]

var slot_data: Array[SlotData] = [
    SlotData.new(-22, null),
    SlotData.new(1, null),
    SlotData.new(2, null),
]


func _ready() -> void:    
    _btn_back.cb = func():
        queue_free()
        
    for slot in _slot_list:
        slot.slot_clicked.connect(func(slot_id):
            slot_clicked.emit(slot_id, slot.has_data)
        )
    
    # from_slot_list(slot_data)
    

func from_slot_list(slot_data):
    for i in range(0, clamp(slot_data.size(), 0, _slot_list.size())):
        var slot_d = slot_data[i] as SlotData
        var slot = func(slot_id):
            for slot_item in _slot_list:
                # printt(slot_item.slot_id, slot_id)
                if slot_item.slot_id == slot_id:
                    return slot_item
                else:
                    continue
                assert(false, "slot id is not valid")
        
        slot = slot.call(slot_d.slot_id) as Slot
        slot.has_data = true
        slot.image_preview = slot_d.image_preview


func from_save_collections(collections: Dictionary):
    # print(">>", collections)
    for slot_item in _slot_list:
        slot_item.has_data = false

    var slot_data = []
    for key in collections.keys():
        var image = Image.load_from_file(collections[key].image_preview)
        image = ImageTexture.create_from_image(image)
        var slot_d = SlotData.new(int(key), image)
        slot_data.append(slot_d)
    
    from_slot_list(slot_data)


class SlotData:
    var slot_id = -1
    var image_preview: Texture2D

    func _init(slot_id, image_preview):
        self.slot_id = slot_id
        self.image_preview = image_preview
