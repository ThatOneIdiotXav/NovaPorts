import music.events.ChangeCharacter;

var cover:FNFSprite;

// shaded chars :)
var greenShade:Character;
var picoShade:Character;

function onCreatePost() {
	add(cover = new FNFSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFF000000));
	cover.screenCenter();
	cover.scrollFactor.set();
	cover.cameras = [camHUD];

	add(greenShade = new Character(dad.x, dad.y, 'green-shade', false));
	add(picoShade = new Character(bf.x + 275, bf.y, 'pico-shade', true));

	greenShade.scrollFactor.set(1, 0);
	picoShade.scrollFactor.set(1, 0);
	picoShade.cameraOffset.x = -100;

	greenShade.alpha = picoShade.alpha = 0.0001;
}

function onStepHit(_) {
	switch (_) {
		case 16:
			cover.alpha = 0;
		case 656:
			goPicoSectionFX_start();
			goPicoSectionFX_pitchBlack(false);
		case 808, 840, 872, 904:
			goPicoSectionFX_pitchBlack(false);
		case 784, 816, 848, 880, 912:
			goPicoSectionFX_pitchBlack(true);
	}
}

function goPicoSectionFX_start() {
	var _time = (Conductor.stepCrochet / 1000) * 128;
	var _twn = {ease: FlxEase.linear};

	cover.alpha = 1;
	cover.cameras = [camGame];
	FlxTween.tween(cover, {alpha: 0}, _time, _twn);

	dad.visible = bf.visible = false;
	dad = greenShade;
	bf = picoShade;
	dad.visible = bf.visible = true;

	greenShade.alpha = picoShade.alpha = 1;
}

function goPicoSectionFX_pitchBlack(?_return:Bool = false) {
	dad.color = bf.color = (_return) ? -1 : 0;
}
