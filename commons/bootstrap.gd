extends Node


var portraits: AssetLoader = AssetLoader.new()
var state: GlobalState
var drag_item_manager: DragItemManager
var canvas: CanvasLayer
var hud: HUD
var slot_save_manager: SlotSaveSystem
var fade: Fade
var tags: Array[String] = []

func _enter_tree():
    drag_item_manager = DragItemManager.new()
    canvas = _create_canvas()
  
    portraits.base_path = "res://assets/images/portraits"
    state = GlobalState.new()
    slot_save_manager = _create_save_slot()
    fade = Fade.spawn()

    get_tree().scene_changed.connect(func():
        if get_tree().current_scene is MainMenu:
            state = GlobalState.new()
            hud.queue_free()
            hud = null
        else:
            if hud == null:
                hud = HUD.spawn()
    )


func _create_canvas():
    var canvas = CanvasLayer.new()
    add_child(canvas)
    return canvas
    

signal save_image_created()
func _create_save_slot():
    var sv = SlotSaveSystem.new()

    sv.on_data_loaded.connect(func(data):
        if hud:
            hud.queue_free()
            hud = HUD.spawn()
        
        tags = data.tags
        var actions = InteractActions.new()
        # TODO change this into data.scene
        var map_path = "res://levels/main/main.tscn"
        if get_tree().current_scene.scene_file_path == map_path:
            await fade.fade_in()
            Player.instance.global_position = str_to_var(data.player_pos)
            await fade.fade_out()
        else:
            await actions.goto(map_path, str_to_var(data.player_pos))
    )

    sv.get_save_data = func():
        return {
            "player_pos" : var_to_str(Player.instance.global_position) if Player.instance else "Vector2(0,0)",
            "tags": tags,
        }

    sv.on_data_saved.connect(func(slot, save_path):
        var image_preview = func():
            var image: Image
            var image_preview_path = "user://save_preview{0}.png".format([slot])
            var sub_view = SubViewport.new()
            sub_view.size = Vector2(1280, 720)
            sub_view.render_target_update_mode = SubViewport.UPDATE_ONCE
            sub_view.world_2d = get_viewport().find_world_2d()
            var player_camera = Player.instance.camera
            player_camera = player_camera.duplicate()
            player_camera.global_position = Player.instance.camera.global_position
            sub_view.add_child(player_camera)
            add_child(sub_view)
            await RenderingServer.frame_post_draw
            image = sub_view.get_texture().get_image()
            sub_view.queue_free()
            image.resize(256, 144, Image.INTERPOLATE_LANCZOS)

            image.save_png(image_preview_path)    
            return image_preview_path


        var sv_collections = Env.SAVE_COLLECTIONS

        sv_collections[str(slot)] = {
            "save_path" : save_path,
            "image_preview" : await image_preview.call(), 
        }
        var file = FileAccess.open(Env.SAVE_COLLECTIONS_PATH, FileAccess.WRITE)
        file.store_string(JSON.stringify(sv_collections, "\t"))

        file = FileAccess.open(Env.CONTINUE_SLOT_PATH, FileAccess.WRITE)
        file.store_string(JSON.stringify(slot))
        file.close()
        save_image_created.emit()

    )
    return sv
