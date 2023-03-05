import flixel.tweens.FlxTween;

var coverItUp:FNFSprite;
var coverItDown:FNFSprite;

function onCreatePost() {
	add(coverItUp = new FNFSprite().makeGraphic(FlxG.width * 3, FlxG.height / 2, 0xFF000000));
	coverItUp.cameras = [camHUD];
	add(coverItDown = new FNFSprite(0, FlxG.height / 2).makeGraphic(FlxG.width * 3, FlxG.height / 2, 0xFF000000));
	coverItDown.cameras = [camHUD];

	coverItUp.screenCenter(FlxAxes.X);
	coverItDown.screenCenter(FlxAxes.X);

	coverItUp.scrollFactor.set();
	coverItDown.scrollFactor.set();
}

function onStepHit(_) {
	switch (_) {
		case 127:
			trace('coverItUp begone!');
			FlxTween.tween(coverItUp, {y: -coverItUp.height}, (Conductor.stepCrochet / 1000) * 128, {ease: FlxEase.quadIn});
			FlxTween.tween(coverItDown, {y: FlxG.height}, (Conductor.stepCrochet / 1000) * 128, {ease: FlxEase.quadIn});

	}
}
