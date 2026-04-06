extends Area2D

var lines : Array;
var line : int;
var Shadow : Area2D;
var active : bool = false; 

func _process(delta):
	if active:
		if isInArea():
			Shadow.visible = true;
			visible = false;
			line = getClosest(get_viewport().get_mouse_position());
			Shadow.get_child(0).visible = true if line == 0 else false;
			Shadow.global_position.y = lines[0][line].global_position.y;
			Shadow.global_position.x = getPos();
			if Shadow.isOverlaping():
				#Shadow.global_position = get_viewport().get_mouse_position();
				Shadow.visible = false;
			
			#global_position = Shadow.global_position;
		else:
			Shadow.visible = false
			visible = true;
			#global_position = get_viewport().get_mouse_position();
		
		global_position = get_viewport().get_mouse_position();
	else:
		visible = false;
		Shadow.visible = false;

func setLines(arr : Array, shd : Area2D):
	lines = arr;
	Shadow = shd;
	#print(arr);

func getClosest(pos : Vector2):
	var minVal = +INF;
	var closest;
	for i in range(len(lines[0])):
		if abs(lines[0][i].global_position.y - pos.y) < minVal:
			minVal = abs(lines[0][i].global_position.y - pos.y);
			closest = i;
	return closest;

func isOverlaping():
	if get_overlapping_areas().size() > 0:
		for i in get_overlapping_areas():
			if i.has_method("setPitch"):
				return true;
	return false;

func isInArea():
	if get_overlapping_areas().size() > 0:
		for i in get_overlapping_areas():
			if i.name == "staffArea":
				return true;
	return false;

func getPos():
	var x = get_viewport().get_mouse_position().x;
	if get_overlapping_areas().size() > 0:
		for i in get_overlapping_areas():
			if i.has_method("setPitch"):
				if x > i.global_position.x:
					return x + 85 + (i.global_position.x - x );
				else:
					return x - 85 + (i.global_position.x - x );
	return x;

