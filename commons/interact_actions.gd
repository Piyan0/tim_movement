class_name InteractActions

func text(arr = ["Godot//It works!"]):
    var ins = load("uid://bxikvddg4fkyy").instantiate()
    ins.dialogue_batch = arr.map(func(value):
        var split = value.split("/")
        var line = Dialogue.DialogueLine.new(split[0].strip_edges(), split[2].strip_edges())
        line.avatar_path = split[1].replace(".", "/").strip_edges()
        return line
    )
    GlobalCanvas.add_child(ins)
    await ins.finished
