class_name InteractActions

func text(arr = ["Shane shane.png owh is that right"]):
    var batches: Array[HUDDialogue.DialogueWithPortrait]

    for el in arr:
        var split = Array(el.split(" "))
        var name = split[0]
        var portrait_id = split[1]
        var content = split.slice(2)
        content = " ".join(content)
        # printt(name, portrait_id, content)
        var batch_el = HUDDialogue.DialogueWithPortrait.new(
            name,
            content,
            Bootstrap.portraits.get_asset(portrait_id)
        ) 
        batches.append(batch_el)
    
    await Bootstrap.hud.dialogue.start_dialogue(batches)
    # var ins = load("uid://bxikvddg4fkyy").instantiate()
    # ins.dialogue_batch = arr.map(func(value):
    #     var split = value.split("/")
    #     var line = Dialogue.DialogueLine.new(split[0].strip_edges(), split[2].strip_edges())
    #     line.avatar_path = split[1].replace(".", "/").strip_edges()
    #     return line
    # )
    # GlobalCanvas.add_child(ins)
    # await ins.finished
