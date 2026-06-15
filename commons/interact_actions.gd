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


func goto(map_path, player_pos):
    await Bootstrap.fade.fade_in()
    var ins = load("res://levels/level_screen.tscn").instantiate()
    ins.map_path = map_path
    ins.player_position = player_pos
    await Bootstrap.get_tree().process_frame
    await Bootstrap.get_tree().process_frame
    Bootstrap.get_tree().change_scene_to_node(ins)