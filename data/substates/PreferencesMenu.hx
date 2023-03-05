function onGenerateTabs() {
	tabs.push("Blue Smiley");
}

function onGenerateOptions() {
	options["Blue Smiley"] = [
		new Checkbox("FPS+ UI", "If checked, changes the UI during gameplay to resemble FPS+'s.", mod + ":FPSUI"),
		new Checkbox("Shaders", "If checked, enables shaders like the fisheye-lens-ish effect, or chromatic abberation.", mod + ":Shaders"),
		new Checkbox("Show Title", "If checked, shows the title in the BG in the start of songs.", mod + ":ShowTitle"),
		new Checkbox("Show Artist in Title", "If checked, shows the version of the title image with the artist named, instead of just the name of the song.", mod + ":ShowArtistInTitle"),
		new Checkbox("Note Glow", "Glows the notes when they're able to be pressed, just like in FPS+.", mod + ":FPSNoteGlow"),
		new Number("NGlow Intensity", "Intensity of note glow.", mod + ":FPSNoteGlowIntensity", "", -255, 255, 5, 0, null, false),
		new Checkbox("NGlow Lerp", "Lerps the color instead of simply snapping to it. :)", mod + ":FPSNoteGlowLerp")
	];
}
