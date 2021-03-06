#!praat
#
.sp_default = 2
scanWords = 1

# Initialization
call init_LanguageTargets
call CreateEN_US_IPA
sge.en_usIPA = selected("Table") 

form Source directiory
	sentence Source Data/EN_US_wordlist.tsv
	choice Speaker_is_a 2
		option Female
		option Male
	boolean Plot 1
endform
outFile$ = "targets.tsv"
.sp$ = "M"
.sp_default = 2
if speaker_is_a$ = "Female"
	.sp$ = "F"
	.sp_default = 1
endif

if not plot
	writeFileLine: outFile$, "Words", tab$, "IPA", tab$, "Gender", tab$, "Nt", tab$, "F1", tab$, "F2", tab$, "F3", tab$, "t"
endif

if source$ <> ""
	.audioList = Read Table from tab-separated file: source$
	Randomize rows
endif

selectObject: .audioList
.numFiles = Get number of rows
	sourceTextGrid = -1
for .f to .numFiles
	selectObject: .audioList
	.infile$ = Get value: .f, "Audio"
	.word$ = Get value: .f, "Words"
	.ipa$ = Get value: .f, "IPA"
	.sound = Read from file: .infile$
	if sourceTextGrid > 0
		selectObject: sourceTextGrid
		Remove
	endif
	sourceTextGrid = -1
	sourceTextGridName$ = replace_regex$(.infile$, "\.(wav|mp3|ogg)$", ".TextGrid", 0)
	if index_regex(sourceTextGridName$, "TextGrid$") and fileReadable(sourceTextGridName$)
		sourceTextGrid = Read from file: sourceTextGridName$
	endif
	
	if plot
		demo Erase all
		call set_up_Canvas
		call plot_vowel_triangle '.sp$'
	
		demo Black
		demo Text special: 50, "Centre", 110, "Bottom", "Helvetica", 24, "0", .word$ + " [" + .ipa$ + "]"
		demoShow()
	endif
	
	@drawSourceVowelTarget: plot, .audioList, .f, .sp$, .sound
#pause
	selectObject: .sound
	if sourceTextGrid > -1
		plusObject: sourceTextGrid
		sourceTextGrid = -1
	endif
	Remove
endfor
selectObject: .audioList
Remove


#################
#


# Set up Canvas
procedure set_up_Canvas
	demo Select outer viewport: 0, 100, 0, 100
	demo Select inner viewport: 20, 80, 20, 80
	demo Axes: 0, 100, 0, 100
	demo Solid line
	demo Black
	demo Line width: 1.0
endproc

# Stop the progam
procedure exitVowelTarget .message$
	select all
	if numberOfSelected() > 0
		Remove
	endif
	exitScript: .message$
endproc

include VowelTarget.praat
include SelectVowels.praat
include LanguageTargets.praat
include CreateIPAtargets.praat
