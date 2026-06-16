class_name SaveSystem
signal on_data_loaded(p_save_data)

var fields = {}
var get_save_data = func() : return {"key":"this is save example."}
var save_dir: String = "res://user/save"


func _init(psave_dir = save_dir):
    save_dir = psave_dir
    var dir = DirAccess.make_dir_recursive_absolute(save_dir)
    
        

func load_data():
    var path = get_save_path()
    var file = FileAccess.open(path, FileAccess.READ)
    var str_data = file.get_as_text()
    file.close()
    var save_data = JSON.parse_string(str_data)
    fields = save_data["fields"]
    on_data_loaded.emit(save_data)
    


func save():
    var path = get_save_path()
    var file = FileAccess.open(path, FileAccess.WRITE)
    var save_data = get_save_data.call()
    save_data["fields"] = fields
    file.store_string(JSON.stringify(save_data, "\t"))
    file.close()


func is_saved():
    return FileAccess.file_exists(get_save_path())

    
func get_save_path():
    return save_dir.path_join("save.json")
