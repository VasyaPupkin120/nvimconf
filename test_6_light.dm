area/dark
	luminosity = 0

obj/torch
	icon = 'torch.dmi'
	luminosity = 2


turf
	floor
		icon = 'floor.dmi'
	wall
		icon = 'wall.dmi'
		density = 1

mob
	icon = 'player.dmi'
	luminosity = 1

	verb
		intangible()
			density = 0
		un_intangible()
			density = 1


obj/lamp/verb/Break()
	set name = "break"
	luminosity = 0


mob/verb/make_potato()
	set src in view()
	name = "potato"
	desc = "Mm. Where's the sour cream'
	icon = 'potato.dmi'




