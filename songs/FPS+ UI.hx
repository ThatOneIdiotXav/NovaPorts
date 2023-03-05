function onCreatePost() {
	camGame.followLerp = 120 / FlxG.updateFramerate;

	if (SettingsAPI.get(mod + ":FPSUI")) {
		scoreTxt.setPosition(scoreTxt.x, FlxG.height - scoreTxt.height - 20);
		scoreTxt.size = 22;
		scoreTxt.updateHitbox();
		scoreTxt.borderSize = 1.25;

		timeBar.visible = timeBarBG.visible = timeTxt.visible = false;

		if (!SettingsAPI.downscroll) {
			var _ = 18;

			healthBar.y -= _;
			healthBarBG.y -= _;
			iconP1.y -= _;
			iconP2.y -= _;
		}
	}
}

function onUpdate(_) {
	if (SettingsAPI.get(mod + ":FPSUI")) {
		scoreTxt.text = 'Score:'
			+ score
			+ ' | Misses:'
			+ misses
			+ ' | Accuracy:'
			+ FlxMath.roundDecimal(accuracy * 100, 2)
			+ '% ['
			+ getFCRank()
			+ ']';
		scoreTxt.screenCenter(FlxAxes.X);
	}
}
