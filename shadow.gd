extends Area2D


func isOverlaping():
	if get_overlapping_areas().size() > 0:
		for i in get_overlapping_areas():
			if i.has_method("setPitch"):
				return true;
	return false;
