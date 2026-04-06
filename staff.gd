extends Control

var PlayerSpeed: float;
var arr;

func _ready():
	arr = [[$C_1, $D_2, $E_3, $F_4, $G_5, $A_6, $B_7, $C_8, $D_9, $E_10, $F_11, $G_12],[1,2,3,4,5,6,7,8,9,10,11,12]];

func _process(delta):
	if %PlayerProgress.progress_ratio >= 1:
		%PlayerProgress.progress_ratio = 0;
	
	%PlayerProgress.progress_ratio += 0.1 * delta * (PlayerSpeed / 4);
	%Player.global_position = %PlayerProgress.global_position;

func getMarks():
	return arr


func _on_main_reset():
	%PlayerProgress.progress_ratio = 0;
