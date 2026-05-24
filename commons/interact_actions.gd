class_name InteractActions

func text(arr = ["Godot/It works!"]):
    var ins = load("uid://bxikvddg4fkyy").instantiate()
    ins.dialogue_batch = arr.map(func(value):
        var split = value.split("/")
        return DialogueBase.DialogueNormal.new(split[0].strip_edges(), split[1].strip_edges())
    )
    GlobalCanvas.add_child(ins)
    await ins.finished
