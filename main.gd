extends Node2D

var arr;
signal reset;
var mouseOverMenu : int = -1;

var busName: String;
var busIndex: int;

func _ready():
	busName = "Meow"
	busIndex = AudioServer.get_bus_index(busName);
	arr = %Staff.getMarks();
	$NewNote.setLines(arr, $Shadow);

func _process(delta):
	if %SlideProgress.progress_ratio >= 0.15:
		%ControlsShd.visible = true;
	else:
		%ControlsShd.visible = false;
	
	%SlideProgress.progress_ratio += 0.8 * delta * mouseOverMenu;
	$CanvasLayer/UI/ControlsMenu.global_position = %SlideProgress.global_position;

func getClosest(pos : Vector2):
	var min = +INF;
	var closest;
	for i in range(len(arr[0])):
		if abs(arr[0][i].global_position.y - pos.y) < min:
			min = abs(arr[0][i].global_position.y - pos.y);
			closest = i;
	return closest;


func CreateNote(x):
	var note = preload("res://note.tscn").instantiate();
	note.global_position.x = x;
	var line = getClosest(get_viewport().get_mouse_position());
	note.global_position.y = arr[0][line].global_position.y;
	note.setPitch(arr[1][line]);
	add_child(note)
	

func _on_note_creator_button_down():
	$NewNote.active = true;
	pass;


func _on_note_creator_button_up():
	$NewNote.active = false;
	if $NewNote.isInArea():
		if !$Shadow.isOverlaping():
			var x : int = $Shadow.global_position.x;
			CreateNote(x);

func _on_player_speed_value_changed(value):
	var mul = (%PlayerSpeed.value) / 4;
	%Staff.PlayerSpeed = %PlayerSpeed.value;
	%SpeedLabel.text = "Speed: x" + str(mul);
	pass


func _on_reset_button_button_up():
	get_children().filter(func(elem): return elem.has_method("resetNotes")).map(func(elem): elem.resetNotes());
	emit_signal("reset")


func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value));

func _on_menu_area_mouse_exited():
	mouseOverMenu = -1;

func _on_controls_area_mouse_entered():
	mouseOverMenu = 1;
