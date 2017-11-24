#! praat
# 
# Practice Mandarin vowel pronunciation
#
# Copyright: R.J.J.H. van Son, 2017
# License: GNU GPL v2 or later
# email: r.j.j.h.vanson@gmail.com
# 
#     SGCvowels.praat: Praat script to practice vowel pronunciation 
#     
#     Copyright (C) 2017  R.J.J.H. van Son and the Netherlands Cancer Institute
# 
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 2 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program; if not, write to the Free Software
#     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
# 
# 
# Debugging 
.testAudio = 1
vowelTarget.printlog = 1
# 
.input$ = "Microphone"
.samplingFrequency = 44100
.recordingTime = 4

# Initialization
call init_LanguageTargets
call CreateEN_US_IPA
sgc.en_usIPA = selected("Table") 

# Read wordlist
.wordList$ = chooseReadFile$: "Select word list"
.wordDir$ = ""
if .wordList$ <> "" and fileReadable(.wordList$) and index_regex(.wordList$, "(?i\.(tsv|Table))$")
	.words = Read Table from tab-separated file: .wordList$
	if .words <= 0
		exitVowelTarget Not a tab-separated-values table: '.wordList$'
	endif
	
	.wordsDir$ = replace_regex$(.wordList$, "([/\\:])[^/\\]+$", "\1", 0)
else
	pause Not a valid tab-separated-values wordlist table. Will use default
	.words = Create Table with column names: "table", 1, "Text IPA Gender Audio"
	Set string value: 1, "Text", "the"
	Set string value: 1, "Gender", "M"
	Set string value: 1, "IPA", "ði"
	Set string value: 1, "Audio", "-"
endif
@initialize_table_collumns: .words, "Character$;Audio$;Gender$;IPA$;Gender$;F1$;F2$;F3$;", "-"
Randomize rows
selectObject: .words
.numWords = Get number of rows

# Run master loop
.continue = 1
beginPause: "Record a vowel"
	comment: "Click on ""Record"" and start speaking"
	choice: "You are a", 1
		option: "Female"
		option: "Male"
.clicked = endPause: "Stop", "Record", 2, 1
if .clicked = 1
	.continue = 0
	call exitVowelTarget Nothing to do
endif
.sp$ = "M"
if you_are_a$ = "Female"
	.sp$ = "F"
endif

.wordNumber = 1
while .continue
	# Draw vowel triangle
	demo Erase all
	call set_up_Canvas
	@plot_voweltriangle_and_target: .words, .wordNumber
	.word$ = plot_voweltriangle_and_target.word$
	.char$ = plot_voweltriangle_and_target.char$
	.ipa$ = plot_voweltriangle_and_target.ipa$
	.gendert$ = plot_voweltriangle_and_target.gendert$
	.f1_targets$ = plot_voweltriangle_and_target.f1_targets$
	.f2_targets$ = plot_voweltriangle_and_target.f2_targets$
	.f3_targets$ = plot_voweltriangle_and_target.f3_targets$
	
	# Locate audio
	selectObject: .words
	.audio$ = Get value: .wordNumber, "Audio"
	if index(.audio$, "/") <= 0
		.audio$ = .wordsDir$ + "/" + .audio$
	endif
	
	# Write Title
	demo Text special: 50, "Centre", 110, "Bottom", "Helvetica", 24, "0", .word$+" "+.char$
		
	# Record sound
	if .testAudio and index_regex(.audio$, "\.(wav|mp3)$") and fileReadable(.audio$)
		.sound = Read from file: .audio$
	else
		demo Paint circle: "Red", -20, 120, 3
		demoShow()
		.sound = Record Sound (fixed time): .input$, 0.99, 0.5, "'.samplingFrequency'", .recordingTime
		demo Paint circle: "White", -20, 120, 4
		demoShow()
	endif
	.intensity = Get intensity (dB)
	if .intensity > 50
		@plot_vowels: 1, "Red", .sp$, .sound, .word$, .ipa$, .gendert$, .f1_targets$, .f2_targets$, .f3_targets$
	endif
	
	selectObject: .sound
	Remove
	
	# Ready or not?
	beginPause: "Do you want to continue?"
		comment: "Click on ""Record"" and start speaking (or click ""Done"")"
	.clicked = endPause: "Done", "Record", 2, 1
	.continue = (.clicked = 2)
	
	.wordNumber += 1
	if .wordNumber > .numWords
		.wordNumber = 1
	endif
endwhile

selectObject: .words, sgc.en_usIPA
Remove

#####################################################################

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

