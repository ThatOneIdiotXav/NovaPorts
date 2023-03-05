function onCreate() {
	var bordies:FlxTypedGroup<FNFSprite> = new FlxTypedGroup();
	add(bordies);

	for (i in 0...2) {
		var bordie:FNFSprite = new FNFSprite().makeGraphic(FlxG.width, 90, 0xFF000000);
		bordies.add(bordie);
		bordie.y = (i == 1) ? FlxG.height - bordie.height : 0;
		bordie.scrollFactor.set();
		bordie.cameras = [camHUD];
	}
}
