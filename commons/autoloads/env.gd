extends Node

var SAVE_COLLECTIONS_PATH = "user://.save"
var SAVE_COLLECTIONS:
    get():
        if FileAccess.file_exists(SAVE_COLLECTIONS_PATH):
            var file = FileAccess.open(SAVE_COLLECTIONS_PATH, FileAccess.READ)
            var text = file.get_as_text()
            file.close()
            return JSON.parse_string(text)

        else:
            var file = FileAccess.open(SAVE_COLLECTIONS_PATH, FileAccess.WRITE)
            file.store_string("{}")
            file.close()
            return {}

var CONTINUE_SLOT_PATH = "user://.continue_slot"
var CONTINUE_SLOT:
    get():
        if FileAccess.file_exists(CONTINUE_SLOT_PATH):
            var file = FileAccess.open(CONTINUE_SLOT_PATH, FileAccess.READ)
            file.close()
            return int(file.get_as_text())
        else:
            var file = FileAccess.open(CONTINUE_SLOT_PATH, FileAccess.WRITE)
            file.store_string("-1")
            file.close()
            return -1
