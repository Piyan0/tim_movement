class_name Database

var _items= {}

func _init():
    _items= _get_items()
    if OS.is_debug_build():
        _dump(_dump_path())
        

# @virtual
func get_item(id: String):
    return _items[id]
            
        
func _dump(p_path: String):
    var items_str= "@@ "+ _title() + " @@\n"
    var items_display= func(id, name):
        return "\t({0}) {1}\n".format([id, name])
    
    for key in _items.keys():
        var info = ""
        if "info" in _items[key]:
            info = _items[key].info

        items_str+= items_display.call(key, info)
    
    if !DirAccess.dir_exists_absolute(p_path.get_base_dir()):
        DirAccess.make_dir_recursive_absolute(p_path.get_base_dir())
        
    var file= FileAccess.open(p_path, FileAccess.WRITE)
    file.store_string(items_str)
    file.close()


func _dump_path():
    return "res://dump/dump_{0}_collections.txt".format([_title()])


# @virtual
func _title():
    return "my_database"
    

# @virtual
func _get_items():
    var items= []
    items.append("item_idx_1")
    return items
    
