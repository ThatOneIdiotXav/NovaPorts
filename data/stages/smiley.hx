var shadeCA:CustomShader;
var shadeCAIntensity:Float = 0.00085;
var shadeFE:CustomShader;
var shadeFEIntensity:Float = 0.0001;
var shadeFEEffectTime:Float = 0.25;
var strip:FNFSprite;
var tittle:FNFSprite;
var bgCover:FNFSprite;

function onCreate() {
	defaultCamZoom = 0.6;

	camGame.bgColor = 0xFFFFFFFF;

	add(strip = new FNFSprite().loadGraphic(Paths.image('stages/smiley/literally the only damn image for the stages lmao')));
	strip.scale.set(FlxG.width * 5, 2);
	strip.updateHitbox();
	strip.screenCenter();

	add(bgCover = new FNFSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFF000000));
	bgCover.screenCenter();
	bgCover.scrollFactor.set();
	bgCover.alpha = 0;

	add(tittle = new FNFSprite().loadGraphic(Paths.image('song card thingies/'
		+ PlayState.SONG.name.toLowerCase()
		+ (!SettingsAPI.get(mod + ':ShowArtistInTitle') ? '-noCredit' : ''))));
	tittle.setGraphicSize(FlxG.width * 1.5, FlxG.height / 1.5);
	tittle.x += tittle.width * 3;

	tittle.scrollFactor.set();
	strip.scrollFactor.set();
	bf.scrollFactor.set(1, 0);
	dad.scrollFactor.set(1, 0);
	gf.visible = false;

	if (SettingsAPI.get(mod + ':Shaders')) {
		shadeCA = new CustomShader('shaders/ChromaticAberration');
		shadeFE = new CustomShader('shaders/FishEyelens');
		camGame.addShader(shadeCA);
		camGame.addShader(shadeFE);
	}
}

function onCreatePost() {
	bf.x += 200;
	bf.y -= 250;
	dad.y -= 450;

	bf.cameraOffset.x = -200;
	dad.cameraOffset.x = 175;
}

function onUpdate(elap) {
	if (SettingsAPI.get(mod + ':Shaders')) {
		for (i in ['rOffset', 'gOffset', 'bOffset'])
			shadeCA.hset(i, shadeCAIntensity);
		shadeFE.hset('aberration', shadeFEIntensity);
		shadeFE.hset('effectTime', shadeFEEffectTime);
	}
}

function onStepHit(_) {
	switch (PlayState.SONG.name) {
		case 'Caeruleum':
			switch (_) {
				case 128:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(false);
				case 176:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(true);
			}
		case 'Neurogenesis':
			switch (_) {
				case 256:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(false);
				case 304:
					if (SettingsAPI.get(mod + ':ShowTitle')) slideCard(true);
				case 800:
					zoomToSmiley_start();
				case 1054:
					zoomToSmiley_finish();
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

function zoomToSmiley_start() {
	trace('start zoomToSmiley executed.');
	var dadMid:FlxPoint = new FlxPoint(dad.x + dad.width / 2, dad.y + dad.height / 2);
	var time = (Conductor.stepCrochet / 1000) * 223.5;
	var twnSettings = {ease: FlxEase.quadOut};

	FlxTween.tween(bgCover, {alpha: 1}, time, twnSettings);

	camGame.follow(null);
	FlxTween.num(0, 1, time, twnSettings, function(_) {
		dad.scrollFactor.y = _;
	});
	FlxTween.num(camGame.scroll.x, -dadMid.x, time, twnSettings, function(_) {
		camGame.scroll.x = _;
	});
	FlxTween.num(camGame.scroll.y, dadMid.y - 20, time, twnSettings, function(_) {
		camGame.scroll.y = _;
	});
	FlxTween.num(0.6, 1.5, time, twnSettings, function(_) {
		defaultCamZoom = _;
	});

	// shaders
	if (SettingsAPI.get(mod + ':Shaders')) {
		FlxTween.num(shadeFEEffectTime, 0.4, time, twnSettings, function(_) {
			shadeFEEffectTime = _;
		});

		FlxTween.num(shadeCAIntensity, 0.00125, time, twnSettings, function(_) {
			shadeCAIntensity = _;
		});
	}
}

function zoomToSmiley_finish() {
	trace('finish zoomToSmiley executed.');
	camGame.follow(camFollow);

	// dad scrollfactor reset
	FlxTween.num(1, 0, (Conductor.stepCrochet / 1000) * 3, {ease: FlxEase.quadOut}, function(_) {
		dad.scrollFactor.y = _;
	});

	// cam zoom reset
	defaultCamZoom = 0.6;

	// hide bgCover now
	FlxTween.cancelTweensOf(bgCover);
	FlxTween.tween(bgCover, {alpha: 0}, (Conductor.stepCrochet / 1000) * 3, {
		ease: FlxEase.quadOut,
		onComplete: function(twn) {
			trace('bgCover alpha is now: ' + bgCover.alpha);
			bgCover.destroy();
		}
	});

	// shaders (if enabled)
	if (SettingsAPI.get(mod + ':Shaders')) {
		FlxTween.num(shadeFEEffectTime, 0.25, (Conductor.stepCrochet / 1000) * 3, {ease: FlxEase.quadOut}, function(_) {
			shadeFEEffectTime = _;
		});

		FlxTween.num(shadeCAIntensity, 0.00085, (Conductor.stepCrochet / 1000) * 3, {ease: FlxEase.quadOut}, function(_) {
			shadeCAIntensity = _;
		});
	}

	trace('end of file finish zoomToSmiley.');
}
