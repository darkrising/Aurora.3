/proc/spawn_diona_nymph_from_organ(var/obj/item/organ/organ)
	if(!istype(organ))
		return 0

	//This is a terrible hack and I should be ashamed.
	var/datum/seed/diona = plant_controller.seeds["diona"]
	if(!diona)
		return 0

	spawn(1) // So it has time to be thrown about by the gib() proc.
		var/mob/living/carbon/alien/diona/D = new(get_turf(organ))
		diona.request_player(D)
		spawn(60)
			if(D)
				if(!D.ckey || !D.client)
					D.death()
		return 1

/obj/item/organ/external/diona
	name = "tendril"
	cannot_break = 1
	amputation_point = "branch"
	joint = "structural ligament"
	dislocated = -1

/obj/item/organ/external/diona/chest
	name = "core trunk"
	limb_name = "chest"
	icon_name = "torso"
	health = 200
	min_broken_damage = 50
	body_part = UPPER_TORSO
	vital = 1
	cannot_amputate = 1
	parent_organ = null

/obj/item/organ/external/diona/groin
	name = "fork"
	limb_name = "groin"
	icon_name = "groin"
	health = 100
	min_broken_damage = 50
	body_part = LOWER_TORSO
	parent_organ = "chest"

/obj/item/organ/external/diona/arm
	name = "left upper tendril"
	limb_name = "l_arm"
	icon_name = "l_arm"
	health = 35
	min_broken_damage = 20
	body_part = ARM_LEFT
	parent_organ = "chest"
	can_grasp = 1

/obj/item/organ/external/diona/arm/right
	name = "right upper tendril"
	limb_name = "r_arm"
	icon_name = "r_arm"
	body_part = ARM_RIGHT

/obj/item/organ/external/diona/leg
	name = "left lower tendril"
	limb_name = "l_leg"
	icon_name = "l_leg"
	health = 35
	min_broken_damage = 20
	body_part = LEG_LEFT
	icon_position = LEFT
	parent_organ = "groin"
	can_stand = 1

/obj/item/organ/external/diona/leg/right
	name = "right lower tendril"
	limb_name = "r_leg"
	icon_name = "r_leg"
	body_part = LEG_RIGHT
	icon_position = RIGHT

/obj/item/organ/external/diona/foot
	name = "left foot"
	limb_name = "l_foot"
	icon_name = "l_foot"
	health = 20
	min_broken_damage = 10
	body_part = FOOT_LEFT
	icon_position = LEFT
	parent_organ = "l_leg"
	can_stand = 1

/obj/item/organ/external/diona/foot/right
	name = "right foot"
	limb_name = "r_foot"
	icon_name = "r_foot"
	body_part = FOOT_RIGHT
	icon_position = RIGHT
	parent_organ = "r_leg"
	joint = "right ankle"
	amputation_point = "right ankle"

/obj/item/organ/external/diona/hand
	name = "left grasper"
	limb_name = "l_hand"
	icon_name = "l_hand"
	health = 30
	min_broken_damage = 15
	body_part = HAND_LEFT
	parent_organ = "l_arm"
	can_grasp = 1

/obj/item/organ/external/diona/hand/right
	name = "right grasper"
	limb_name = "r_hand"
	icon_name = "r_hand"
	body_part = HAND_RIGHT
	parent_organ = "r_arm"

/obj/item/organ/external/diona/head
	limb_name = "head"
	icon_name = "head"
	name = "head"
	health = 50
	min_broken_damage = 25
	body_part = HEAD
	parent_organ = "chest"

/obj/item/organ/external/diona/head/removed()
	if(owner)
		owner.u_equip(owner.head)
		owner.u_equip(owner.l_ear)
	..()

//DIONA ORGANS.
/obj/item/organ/external/diona/removed()
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && spawn_diona_nymph_from_organ(src))
		qdel(src)

/obj/item/organ/diona/process()
	return

/obj/item/organ/diona/strata
	name = "neural strata"
	parent_organ = "chest"

/obj/item/organ/diona/bladder
	name = "gas bladder"
	parent_organ = "head"

/obj/item/organ/diona/polyp
	name = "polyp segment"
	parent_organ = "groin"

/obj/item/organ/diona/ligament
	name = "anchoring ligament"
	parent_organ = "groin"

/obj/item/organ/diona
	name = "diona nymph"
	icon = 'icons/obj/objects.dmi'
	icon_state = "nymph"
	organ_tag = "special" // Turns into a nymph instantly, no transplanting possible.

/obj/item/organ/diona/removed(var/mob/living/user)
	var/mob/living/carbon/human/H = owner
	..()
	if(!istype(H) || !H.organs || !H.organs.len)
		H.death()
	if(prob(50) && spawn_diona_nymph_from_organ(src))
		qdel(src)

// These are different to the standard diona organs as they have a purpose in other
// species (absorbing radiation and light respectively)
/obj/item/organ/diona/nutrients
	name = "nutrient channel"
	parent_organ = "chest"
	organ_tag = "nutrient channel"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/diona/nutrients/removed()
	return

/obj/item/organ/diona/node
	name = "response node"
	parent_organ = "head"
	organ_tag = "receptor node"
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/organ/diona/node/removed()
	return

//CORTICAL BORER ORGANS.
/obj/item/organ/borer
	name = "cortical borer"
	parent_organ = "head"
	vital = 1

/obj/item/organ/borer/process()

	// Borer husks regenerate health, feel no pain, and are resistant to stuns and brainloss.
	for(var/chem in list("tricordrazine","tramadol","hyperzine","alkysine"))
		if(owner.reagents.get_reagent_amount(chem) < 3)
			owner.reagents.add_reagent(chem, 5)

	// They're also super gross and ooze ichor.
	if(prob(5))
		var/mob/living/carbon/human/H = owner
		if(!istype(H))
			return

		var/datum/reagent/blood/B = locate(/datum/reagent/blood) in H.vessel.reagent_list
		blood_splatter(H,B,1)
		var/obj/effect/decal/cleanable/blood/splatter/goo = locate() in get_turf(owner)
		if(goo)
			goo.name = "husk ichor"
			goo.desc = "It's thick and stinks of decay."
			goo.basecolor = "#412464"
			goo.update_icon()

/obj/item/organ/borer
	name = "cortical borer"
	icon = 'icons/obj/objects.dmi'
	icon_state = "borer"
	organ_tag = "brain"
	desc = "A disgusting space slug."

/obj/item/organ/borer/removed(var/mob/living/user)

	..()

	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	if(B)
		B.leave_host()
		B.ckey = owner.ckey

	spawn(0)
		qdel(src)

//XENOMORPH ORGANS
/obj/item/organ/xenos/eggsac
	name = "egg sac"
	parent_organ = "groin"

/obj/item/organ/xenos/plasmavessel
	name = "plasma vessel"
	parent_organ = "chest"
	var/stored_plasma = 0
	var/max_plasma = 500

/obj/item/organ/xenos/plasmavessel/queen
	name = "bloated plasma vessel"
	stored_plasma = 200
	max_plasma = 500

/obj/item/organ/xenos/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/obj/item/organ/xenos/plasmavessel/hunter
	name = "tiny plasma vessel"
	stored_plasma = 100
	max_plasma = 150

/obj/item/organ/xenos/acidgland
	name = "acid gland"
	parent_organ = "head"

/obj/item/organ/xenos/hivenode
	name = "hive node"
	parent_organ = "chest"

/obj/item/organ/xenos/resinspinner
	name = "resin spinner"
	parent_organ = "head"

/obj/item/organ/xenos
	name = "xeno organ"
	icon = 'icons/effects/blood.dmi'
	desc = "It smells like an accident in a chemical factory."

/obj/item/organ/xenos/eggsac
	name = "egg sac"
	icon_state = "xgibmid1"
	organ_tag = "egg sac"

/obj/item/organ/xenos/plasmavessel
	name = "plasma vessel"
	icon_state = "xgibdown1"
	organ_tag = "plasma vessel"

/obj/item/organ/xenos/acidgland
	name = "acid gland"
	icon_state = "xgibtorso"
	organ_tag = "acid gland"

/obj/item/organ/xenos/hivenode
	name = "hive node"
	icon_state = "xgibmid2"
	organ_tag = "hive node"

/obj/item/organ/xenos/resinspinner
	name = "hive node"
	icon_state = "xgibmid2"
	organ_tag = "resin spinner"

//VOX ORGANS.
/obj/item/organ/stack
	name = "cortical stack"
	parent_organ = "head"
	robotic = 2
	vital = 1
	var/backup_time = 0
	var/datum/mind/backup

/obj/item/organ/stack/process()
	if(owner && owner.stat != 2 && !is_broken())
		backup_time = world.time
		if(owner.mind) backup = owner.mind

/obj/item/organ/stack/vox

/obj/item/organ/stack/vox/stack

/obj/item/organ/stack
	name = "cortical stack"
	icon_state = "brain-prosthetic"
	organ_tag = "stack"
	robotic = 2

/obj/item/organ/stack/vox
	name = "vox cortical stack"

// Slime limbs.
/obj/item/organ/external/chest/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/groin/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/arm/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/arm/right/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/leg/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/leg/right/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/foot/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/foot/right/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/hand/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/hand/right/slime
	cannot_break = 1
	dislocated = -1

/obj/item/organ/external/head/slime
	cannot_break = 1
	dislocated = -1

/*//VAURCA ORGANS
/obj/item/organ/vaurca/neuralsocket
    name = "neural socket"
    organ_tag = "neural socket"
    icon = 'icons/mob/alien.dmi'
    icon_state = "neural_socket"

/obj/item/organ/vaurca/neuralsocket/removed()
	return

/obj/item/organ/vaurca/breathingapparatus
    name = "breathing apparatus"
    organ_tag = "breathing apparatus"
    icon = 'icons/mob/alien.dmi'
    icon_state = "breathing_app"

/obj/item/organ/vaurca/breathingapparatus/removed()
	return

/obj/item/organ/vaurca/tracheae
    name = "tracheae"
    organ_tag = "tracheae"
    icon = 'icons/mob/alien.dmi'
    icon_state = "tracheae"
/obj/item/organ/vaurca/tracheae/removed()
	return */