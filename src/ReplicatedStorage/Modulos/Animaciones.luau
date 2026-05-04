local Animaciones = {}

Animaciones.Ids = {
	{ID = 74498799892136, Nombre = 'Thriller'},
	{ID = 100837352999512, Nombre = 'Smooth Criminal'},
	{ID = 139957672285986, Nombre = 'Moon Walk'},
	{ID = 122830472348236, Nombre = 'Lean'},
	{ID = 130179674791973, Nombre = 'Billie Jean'},
	{ID = 138316142522795, Nombre = 'Menea I'},
	{ID = 93650537970037, Nombre = 'Menea II'},
	{ID = 87026730190141, Nombre = 'Macarena'},
	{ID = 129764254213842, Nombre = 'Gangnam Style'},
	{ID = 109863843469159, Nombre = 'Zapateo I'},
	{ID = 79209803496762, Nombre = 'Zapateo II'},
	{ID = 95598009785895, Nombre = 'Ghosts Turros'},
	{ID = 104764044091264, Nombre = 'Ghosts Takadance'},
	{ID = 117717879866825, Nombre = 'Ghosts Garrote'},
	{ID = 101011728520473, Nombre = 'Default Dance'},
	{ID = 124982597491660, Nombre = 'California Girls'},
	{ID = 133551169796944, Nombre = 'Salsa Sensual'},
	{ID = 80443100846814, Nombre = 'Sexy Dance'},
	{ID = 140264972855688, Nombre = 'Rock n Roll'},
	{ID = 108060277268915, Nombre = 'Soul I'},
	{ID = 99786006678146, Nombre = 'Soul II'},
	{ID = 82928714109101, Nombre = 'Soul III'}, 
	{ID = 122584436407402, Nombre = 'Bombastic'},
	{ID = 74790864906333, Nombre = 'Snide'},
	{ID = 106725869492202, Nombre = 'Samba I'},
	{ID = 89111424480965, Nombre = 'Samba II'},
	{ID = 135274414278380, Nombre = 'Samba III'},
	{ID = 88477349752052, Nombre = 'Samba IV'},
	{ID = 99676854128770, Nombre = 'Diamond'},
	{ID = 128838190174445, Nombre = 'Arm Sway'},
	{ID = 134572990299074, Nombre = 'Sprint'},
	{ID = 98813116714164, Nombre = 'Belly I'},
	{ID = 101421039901803, Nombre = 'Belly II'},
	{ID = 111030032759956, Nombre = 'Belly III'},
	{ID = 110328541025392, Nombre = 'Belly IV'},
	{ID = 125053765985375, Nombre = 'Rumba I'},
	{ID = 134059337517351, Nombre = 'Rumba II'},
	{ID = 128344837018606, Nombre = 'Shuffle I'},
	{ID = 116042143121600, Nombre = 'Shuffle II'},
	{ID = 75666907339474, Nombre = 'Shuffle III'},
	{ID = 139695580295254, Nombre = 'Dreaming'},
	{ID = 87256667587302, Nombre = 'Salsa I'},
	{ID = 79730790380560, Nombre = 'Salsa II'},
	{ID = 105174102127690, Nombre = 'Salsa III'},
	{ID = 81075111598672, Nombre = 'Salsa IV'},
	{ID = 95627144044934, Nombre = 'Salsa V'},
	{ID = 93582366449826, Nombre = 'HipHop VII'},
	{ID = 96766414425070, Nombre = 'Glitter'},
	{ID = 116841169463406, Nombre = 'Shuffle I'},
	{ID = 83397227750805, Nombre = 'Shuffle II'},
	{ID = 90143650792048, Nombre = 'Shuffle III'},
	{ID = 104904326781868, Nombre = 'Fresh'},
	{ID = 111951087688291, Nombre = 'Gandy'},
	{ID = 87366880880445, Nombre = 'Fancy'},
	{ID = 105978455508635, Nombre = 'Dynamite'},
	{ID = 87911767600339, Nombre = 'DnB Step'},
	{ID = 121070617692386, Nombre = 'Daydream'},
	{ID = 133510433394834, Nombre = 'CrissCross'},
	{ID = 95012987273322, Nombre = 'Crazy'},
	{ID = 90051254810946, Nombre = 'Chill'},
	{ID = 72420765697390, Nombre = 'CanCan'},
	{ID = 76314116414269, Nombre = 'Billie'},
	{ID = 84492113139839, Nombre = 'Conceited'},
	{ID = 107878753518729, Nombre = 'Cannonbal'},
	{ID = 132611906841113, Nombre = 'Pushing Buttons'},
	{ID = 129005976068322, Nombre = 'Ner Ner'},
	{ID = 72433216272255, Nombre = 'Pop'},
	{ID = 99079687606639, Nombre = 'Baby Bunny'},
	{ID = 116800653493137, Nombre = 'Bboy'},
	{ID = 111525609019853, Nombre = 'Afox'},
	{ID = 98627473756565, Nombre = 'Freak'},
	{ID = 139794680145941, Nombre = 'Freak II'},      
	{ID = 78603995113426, Nombre = 'Line Dancing'},
	{ID = 115583440429313, Nombre = 'The Mind'},
	{ID = 116157825323323, Nombre = 'Cheerleader'},
	{ID = 115945187669605, Nombre = 'Zoom'},
	{ID = 111308118702107, Nombre = 'Take That'},
	{ID = 82739993831978, Nombre = 'Tamm Boy'},
	{ID = 80511356535613, Nombre = 'Sugar'},
	{ID = 78484642922390, Nombre = 'Purps'},
	{ID = 135442181835658, Nombre = 'Jingle'},
	{ID = 131346111337433, Nombre = 'Al Tiro'},
	{ID = 139466480557551, Nombre = 'Amar Para'},
	{ID = 77238420817572, Nombre = 'Apple'},
	{ID = 95144651496491, Nombre = 'Attention'},
	{ID = 126313891149979, Nombre = 'Bepp'},
	{ID = 139986480705861, Nombre = 'PomPom'},
	{ID = 119774995987419, Nombre = 'BoomBoom'},
	{ID = 111604765506563, Nombre = 'Chasin'},
	{ID = 108571779943901, Nombre = 'Collide'},
	{ID = 109592914853200, Nombre = 'Damn Time'},
	{ID = 75470256573704, Nombre = 'Disco'},
	{ID = 123539369286057, Nombre = 'Feel Spectacular'},
	{ID = 133320214944635, Nombre = 'Fiesta'},
	{ID = 89288947751010, Nombre = 'Galleta'},
	{ID = 121472315872091, Nombre = 'Gee'},
	{ID = 125802053398277, Nombre = 'Glass Bead'},
	{ID = 132334408930899, Nombre = 'Going Loco'},
	{ID = 116788416886018, Nombre = 'Green Grass'},
	{ID = 110237007424845, Nombre = 'Smooth Ice'},
	{ID = 107075515945550, Nombre = 'Many Nights'},
	{ID = 121444371059761, Nombre = 'Me Likey'},
	{ID = 89104334671171, Nombre = 'Mor Mor'},         
	{ID = 82450833836212, Nombre = 'Not Crying'},
	{ID = 129776939385438, Nombre = 'Seeing Tinny'},
	{ID = 114168056167542, Nombre = 'Sole Dance'},
	{ID = 115874865062092, Nombre = 'Still Yapping'},
	{ID = 96380808235336, Nombre = 'Yo Move Like Dat'},
	{ID = 89675190698975, Nombre = '1000 Nights'},
	{ID = 133578356860108, Nombre = '2 on'},
	{ID = 101009932520056, Nombre = 'Anaconda'},
	{ID = 137250409077626, Nombre = 'Beat Snap'},
	{ID = 134165883160830, Nombre = 'Bom Bom'},
	{ID = 124139750930267, Nombre = 'Brie'},
	{ID = 87526877181849, Nombre = 'Careta'},
	{ID = 133741611350496, Nombre = 'Dentro'},
	{ID = 100888224480462, Nombre = 'Disturbia'},
	{ID = 105387483802526, Nombre = 'Fearless'},
	{ID = 134168226768716, Nombre = 'Glitches'},
	{ID = 120043392669833, Nombre = 'World Ruler'},
	{ID = 102925318918158, Nombre = 'Lively'},
	{ID = 95374494986368, Nombre = 'Parfesta'},
	{ID = 74595445883300, Nombre = 'Paseventou'},
	{ID = 89703843633445, Nombre = 'Working Hard'},
	{ID = 75354665537151, Nombre = 'Yo'},
} 


Animaciones.Ids2 = {
	


	
	
}



Animaciones.VIP = { ---EMOTES
	

	

	

}


Animaciones.RobloxPremium = {
	
	

}




return Animaciones

