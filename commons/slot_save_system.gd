class_name SlotSaveSystem

signal on_data_saved(slot, save_path)
signal on_data_loaded(data)

var get_save_data = func(): return {}
var save_dir = "user://save_{0}"
var max_slot = 5
var used_slot = -1
var fields = {}
var _save_slot:Array[SaveSystem] = []


func _init() -> void:
    _create_save_slot()


func load_data(slot: int):
    used_slot = slot
    _save_slot[slot].on_data_loaded.connect(func(data): on_data_loaded.emit(data))
    _save_slot[slot].load_data()


func save(slot):
    _save_slot[slot].get_save_data = get_save_data
    _save_slot[slot].save()
    on_data_saved.emit(slot, _save_slot[slot].get_save_path())

    
func _create_save_slot():
    for slot in max_slot:
        var save_system = SaveSystem.new(save_dir.format([str(slot)]))
        save_system.fields = fields
        _save_slot.append(save_system)
        if !save_system.is_saved():
            # print(1)
            save_system.save()
        
