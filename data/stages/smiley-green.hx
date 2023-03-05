var strip:FNFSprite;
var tittle:FNFSprite;
var g_d:FNFSprite; // dark
var g_n:FNFSprite; // normal
var g_f:FNFSprite; // light/flash
// shader shit
var shadeCA:CustomShader;
var shadeCAIntensity:Float = 0.00085;
var shadeFE:CustomShader;
var shadeFEIntensity:Float = 0.0001;
var shadeFEEffectTime:Float = 0.25;

function onCreate() {
	defaultCamZoom = 0.6;
	FlxG.camera.bgColor = -1;

	add(strip = new FNFSprite().loadGraphic(Paths.image('stages/smiley/literally the only damn image for the stages lmao')));
	strip.scale.set(FlxG.width * 5, 2);
	strip.updateHitbox();
	strip.screenCenter();

	add(tittle = new FNFSprite().loadGraphic(Paths.image('song card thingies/'
		+ PlayState.SONG.name.toLowerCase()
		+ (!SettingsAPI.get(mod + ':ShowArtistInTitle') ? '-noCredit' : ''))));
	tittle.setGraphicSize(FlxG.width * 1.5, FlxG.height / 1.5);
	tittle.x += tittle.width * 3;
	tittle.y += 50;

	tittle.scrollFactor.set();
	strip.scrollFactor.set();
	bf.scrollFactor.set(1, 0);
	dad.scrollFactor.set(1, 0);
	gf.visible = false;

	// doing these for the sake of caching (and loadGraphicFromSprite)
	g_d = new FNFSprite().loadGraphic(Paths.image('stages/green/greenDark'));
	g_n = new FNFSprite().loadGraphic(Paths.image('stages/green/greenNormal'));

	add(g_f = new FNFSprite().loadGraphic(Paths.image('stages/green/greenFlash')));
	g_f.scale.set(FlxG.width * 5, 2);
	g_f.updateHitbox();
	g_f.screenCenter();
	g_f.scrollFactor.set();

	if (SettingsAPI.get(mod + ':Shaders')) {
		shadeCA = new CustomShader('shaders/ChromaticAberration');
		shadeFE = new CustomShader('shaders/FishEyelens');
		camGame.addShader(shadeCA);
		camGame.addShader(shadeFE);
	}
}

function onCreatePost() {
	bf.x += 150;
	bf.y -= 250;
	dad.y -= 250;

	bf.cameraOffset.x = -100;
	dad.cameraOffset.x = 100;
}

function onUpdate(_) {
	if (SettingsAPI.get(mod + ':Shaders')) {
		for (i in ['rOffset', 'gOffset', 'bOffset'])
			shadeCA.hset(i, shadeCAIntensity);
		shadeFE.hset('aberration', shadeFEIntensity);
		shadeFE.hset('effectTime', shadeFEEffectTime);
	}

	g_f.alpha = FlxMath.lerp(g_f.alpha, 0, _ * 10);
}

function onBeatHit(_) {
	if (_ % 8 == 4 && _ >= 228) {
		g_f.alpha = 1;
	}
}

function onStepHit(_) {
	switch (PlayState.SONG.name) {
		case 'Viridis':
			switch (_) {
				case 16:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(false);
				case 56:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(true);
				case 656, 808, 840, 872, 904:
					strip.loadGraphicFromSprite(g_d);
				case 784, 816, 848, 880, 912:
					strip.loadGraphicFromSprite(g_n);
			}
	}
}

function slideCard(?out:Bool = false) {
	if (out) {
		FlxTween.tween(tittle, {x: tittle.x - (tittle.width * 3)}, (Conductor.crochet / 1000) * 2, {ease: FlxEase.circIn});
	} else {
		FlxTween.tween(tittle, {x: tittle.x - (tittle.width * 3)}, (Conductor.crochet / 1000) * 2, {ease: FlxEase.circOut});
	}
}
