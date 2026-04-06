extends Area2D

var mouseInside : bool = false;

func _on_area_entered(Player):
	if Player.name == "Player":
		$NoteSound.play();
		$Pup.frame = 1;

func setPitch(pitch : int):
	match pitch:
		1:
			$NoteSound.stream = load("res://Sounds/meowC0.mp3");
			$ColorRect.visible = true;
		2:
			$NoteSound.stream = load("res://Sounds/meowD0.mp3");
		3:
			$NoteSound.stream = load("res://Sounds/meowE0.mp3");
		4:
			$NoteSound.stream = load("res://Sounds/meowF0.mp3");
		5:
			$NoteSound.stream = load("res://Sounds/meowG0.mp3");
		6:
			$NoteSound.stream = load("res://Sounds/meowA1.mp3");
		7:
			$NoteSound.stream = load("res://Sounds/meowB1.mp3");
		8:
			$NoteSound.stream = load("res://Sounds/meowC1.mp3");
		9:
			$NoteSound.stream = load("res://Sounds/meowD1.mp3");
		10:
			$NoteSound.stream = load("res://Sounds/meowE1.mp3");
		11:
			$NoteSound.stream = load("res://Sounds/meowF1.mp3");
		12:
			$NoteSound.stream = load("res://Sounds/meowG1.mp3");

func _on_note_sound_finished():
	$Pup.frame = 0;

func resetNotes():
	queue_free();


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		queue_free()
