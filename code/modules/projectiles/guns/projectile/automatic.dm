/obj/item/weapon/gun/projectile/automatic //Hopefully someone will find a way to make these fire in bursts or something. --Superxpdude
	name = "submachine gun"
	desc = "A lightweight, fast firing gun. Uses 9mm rounds."
	icon_state = "saber"	//ugly
	w_class = 3
	load_method = SPEEDLOADER //yup. until someone sprites a magazine for it.
	max_shells = 22
	caliber = "9mm"
	origin_tech = "combat=4;materials=2"
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/c9mm
	multi_aim = 1

	firemodes = list(
		list(name="semiauto", burst=1, fire_delay=0),
		list(name="3-round bursts", burst=3, move_delay=4, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.0, 0.6, 1.0)),
		list(name="short bursts", 	burst=5, move_delay=4, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		)

//Submachine guns and personal defence weapons, go.

/obj/item/weapon/gun/projectile/automatic/mini_uzi
	name = "\improper Uzi"
	desc = "A lightweight, fast firing gun, for when you want someone dead. Uses .45 rounds."
	icon_state = "mini-uzi"
	w_class = 3
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45uzi
	max_shells = 16
	caliber = ".45"
	origin_tech = "combat=5;materials=2;syndicate=8"
	ammo_type = /obj/item/ammo_casing/c45

/obj/item/weapon/gun/projectile/automatic/c20r
	name = "\improper C-20r SMG"
	desc = "A lightweight, fast firing gun, for when you REALLY need someone dead. Uses 12mm pistol rounds. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp"
	icon_state = "c20r"
	item_state = "c20r"
	w_class = 3
	force = 10
	caliber = "12mm"
	origin_tech = "combat=5;materials=2;syndicate=8"
	slot_flags = SLOT_BELT|SLOT_BACK
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a12mm
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

/obj/item/weapon/gun/projectile/automatic/c20r/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "c20r-[round(ammo_magazine.stored_ammo.len,4)]"
	else
		icon_state = "c20r"
	return

/obj/item/weapon/gun/projectile/automatic/wt550
	name = "\improper W-T 550 Saber"
	desc = "A cheap, mass produced Ward-Takahashi PDW. Uses 9mm rounds."
	icon_state = "wt550"
	item_state = "wt550"
	w_class = 3
	caliber = "9mm"
	origin_tech = "combat=5;materials=2"
	slot_flags = SLOT_BELT
	ammo_type = "/obj/item/ammo_casing/c9mmr"
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/mc9mmt/rubber

/obj/item/weapon/gun/projectile/automatic/wt550/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "wt550-[round(ammo_magazine.stored_ammo.len,4)]"
	else
		icon_state = "wt550"
	return

//Ballistic rifles, go.

/obj/item/weapon/gun/projectile/automatic/rifle
	name = "automatic rifle"
	desc = "A weapon firing an intermediate caliber round, or larger."
	icon_state = "arifle"
	item_state = null
	w_class = 4
	force = 10
	caliber = "a762"
	origin_tech = "combat=6;materials=1;syndicate=4"
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c762

	firemodes = list(
		list(name="semiauto", burst=1, fire_delay=0),
		list(name="3-round bursts", burst=3, move_delay=6, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.0, 0.6, 0.6)),
		list(name="short bursts", 	burst=5, move_delay=6, accuracy = list(0,-1,-1,-2,-2), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		)

	//slower to regain aim, more inaccurate if not wielding
	fire_delay = 10
	accuracy = -2

	//wielding information
	fire_delay_wielded = 6
	accuracy_wielded = 0

	//action button for wielding
	icon_action_button = "action_blank"
	action_button_name = "Wield rifle"

/obj/item/weapon/gun/projectile/automatic/rifle/can_wield()
	return 1

/obj/item/weapon/gun/projectile/automatic/rifle/ui_action_click()
	if(src in usr)
		toggle_wield(usr)

/obj/item/weapon/gun/projectile/automatic/rifle/verb/wield_rifle()
	set name = "Wield rifle"
	set category = "Object"
	set src in usr

	toggle_wield(usr)

/obj/item/weapon/gun/projectile/automatic/rifle/sts35
	name = "\improper STS-35 automatic rifle"
	desc = "A durable, rugged looking automatic weapon of a make popular on the frontier worlds. Uses 7.62mm rounds. It is unmarked."

/obj/item/weapon/gun/projectile/automatic/rifle/sts35/update_icon()
	..()
	icon_state = (ammo_magazine)? "arifle" : "arifle-empty"
	update_held_icon()

/datum/firemode/z8
	var/use_launcher = 0

/obj/item/weapon/gun/projectile/automatic/rifle/z8
	name = "\improper Z8 Bulldog"
	desc = "An older model bullpup carbine, made by the now defunct Zendai Foundries. Uses armor piercing 5.56mm rounds. Makes you feel like a space marine when you hold it."
	icon_state = "carbine"
	item_state = "z8carbine"
	w_class = 4
	force = 10
	caliber = "a556"
	origin_tech = "combat=8;materials=3"
	ammo_type = "/obj/item/ammo_casing/a556"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a556
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

	burst_delay = 4
	firemode_type = /datum/firemode/z8
	firemodes = list(
		list(name="semiauto", burst=1, fire_delay=0),
		list(name="3-round bursts", burst=3, move_delay=6, accuracy = list(0,-1,-1), dispersion = list(0.0, 0.6, 0.6)),
		list(name="fire grenades", use_launcher=1)
		)

	var/obj/item/weapon/gun/launcher/grenade/underslung/launcher

/obj/item/weapon/gun/projectile/automatic/rifle/z8/New()
	..()
	launcher = new(src)

/obj/item/weapon/gun/projectile/automatic/rifle/z8/attackby(obj/item/I, mob/user)
	if((istype(I, /obj/item/weapon/grenade)))
		launcher.load(I, user)
	else
		..()

/obj/item/weapon/gun/projectile/automatic/rifle/z8/attack_hand(mob/user)
	var/datum/firemode/z8/current_mode = firemodes[sel_mode]
	if(user.get_inactive_hand() == src && current_mode.use_launcher)
		launcher.unload(user)
	else
		..()

/obj/item/weapon/gun/projectile/automatic/rifle/z8/Fire(atom/target, mob/living/user, params, pointblank=0, reflex=0)
	var/datum/firemode/z8/current_mode = firemodes[sel_mode]
	if(current_mode.use_launcher)
		launcher.Fire(target, user, params, pointblank, reflex)
		if(!launcher.chambered)
			switch_firemodes() //switch back automatically
	else
		..()

/obj/item/weapon/gun/projectile/automatic/rifle/z8/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "carbine-[round(ammo_magazine.stored_ammo.len,2)]"
	else
		icon_state = "carbine"
	return

/obj/item/weapon/gun/projectile/automatic/rifle/z8/examine(mob/user)
	..()
	if(launcher.chambered)
		user << "\The [launcher] has \a [launcher.chambered] loaded."
	else
		user << "\The [launcher] is empty."

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw
	name = "\improper L6 SAW"
	desc = "A rather traditionally made light machine gun with a pleasantly lacquered wooden pistol grip. Has 'Aussec Armoury- 2531' engraved on the reciever"
	icon_state = "l6closed100"
	item_state = "l6closedmag"
	w_class = 4
	force = 10
	slot_flags = 0
	max_shells = 50
	caliber = "a762"
	origin_tech = "combat=6;materials=1;syndicate=2"
	slot_flags = SLOT_BACK
	ammo_type = "/obj/item/ammo_casing/a762"
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/a762

	firemodes = list(
		list(name="short bursts",	burst=5, move_delay=6, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(name="long bursts",	burst=8, move_delay=8, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		)

	var/cover_open = 0

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/special_check(mob/user)
	if(cover_open)
		user << "<span class='warning'>[src]'s cover is open! Close it before firing!</span>"
		return 0
	return ..()

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	user << "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>"
	update_icon()

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/attack_self(mob/user as mob)
	if(cover_open)
		toggle_cover(user) //close the cover
	else
		return ..() //once closed, behave like normal

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/attack_hand(mob/user as mob)
	if(!cover_open && user.get_inactive_hand() == src)
		toggle_cover(user) //open the cover
	else
		return ..() //once open, behave like normal

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/update_icon()
	icon_state = "l6[cover_open ? "open" : "closed"][ammo_magazine ? round(ammo_magazine.stored_ammo.len, 25) : "-empty"]"

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/load_ammo(var/obj/item/A, mob/user)
	if(!cover_open)
		user << "<span class='warning'>You need to open the cover to load [src].</span>"
		return
	..()

/obj/item/weapon/gun/projectile/automatic/rifle/l6_saw/unload_ammo(mob/user, var/allow_dump=1)
	if(!cover_open)
		user << "<span class='warning'>You need to open the cover to unload [src].</span>"
		return
	..()
	
/obj/item/weapon/gun/projectile/automatic/tommygun
	name = "\improper Tommygun"
	desc = "A classic among criminals. Uses .45 rounds."
	icon_state = "tommygun"
	w_class = 3
	max_shells = 50
	caliber = ".45"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ILLEGAL = 5)
	slot_flags = SLOT_BELT
	ammo_type = /obj/item/ammo_casing/c45
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/tommymag

/obj/item/weapon/gun/projectile/automatic/tommygun/update_icon()
	..()
	icon_state = (ammo_magazine)? "tommygun" : "tommygun-empty"

/obj/item/weapon/gun/projectile/automatic/railgun
	name = "Railgun"
	desc = "An advanced rifle that magnetically propels hyperdense rods at breakneck speeds to devastating effect."
	icon_state = "railgun"
	item_state = "arifle"
	w_class = 3
	force = 10
	caliber = "trod"
	origin_tech = "combat=5;materials=2"
	slot_flags = SLOT_BELT|SLOT_BACK
	fire_sound = 'sound/effects/Explosion2.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/trodpack
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

	firemodes = list(
		list(name="single coil",	burst=1, move_delay=6, accuracy = list(0)),
		list(name="dual coil",	burst=2, move_delay=8, accuracy = list(-2,-3), dispersion = list(2.0, 3.0)),
		)