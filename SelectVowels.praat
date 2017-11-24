#! praat
# 
# Select vowel segments
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

procedure select_vowel_target .sound .formants .textgrid
	.f1_Lowest = 250
	.f1_Highest = 1050
	selectObject: .textgrid
	.duration = Get total duration
	.firstTier$ = Get tier name: 1
	if .firstTier$ <> "Vowel"
		Insert point tier: 1, "VowelTarget"
		Insert interval tier: 1, "Vowel"
	endif
	.vowelTier = 1
	.targetTier = 2
	.peakTier = 3
	.valleyTier = 4
	.silencesTier = 5
	.vuvTier = 6

	selectObject: .sound
	.samplingFrequency = Get sampling frequency
	.intensity = Get intensity (dB)
	if .samplingFrequency = 10000
		.formantsBurg = noprogress To Formant (burg): 0, 5, 5000, 0.025, 50
	else
		.formantsBurg = noprogress To Formant (burg): 0, 5, 5500, 0.025, 50
	endif
	.totalNumFrames = Get number of frames
		
	# Nothing found, but there is sound. Try to find at least 1 vowel
	
	selectObject: .textgrid
	.numPeaks = Get number of points: .peakTier	
	if .numPeaks <= 0 and .intensity >= 45
		selectObject: .sound
		.t_max = Get time of maximum: 0, 0, "Sinc70"
		.pp = noprogress To PointProcess (periodic, cc): 75, 600
		.textGrid = noprogress To TextGrid (vuv): 0.02, 0.01
		.i = Get interval at time: 1, .t_max
		.label$ = Get label of interval: 1, .i
		.start = Get start time of interval: 1, .i
		.end = Get end time of interval: 1, .i
		if .label$ = "V"
			selectObject: .syllableKernels
			Insert point: .peakTier, .t_max, "P"
			Insert point: .valleyTier, .start, "V"
			Insert point: .valley, .end, "V"
		endif
	endif
	
	selectObject: .sound
	.voicePP = noprogress To PointProcess (periodic, cc): 75, 600
	selectObject: .textgrid
	.numPeaks = Get number of points: .peakTier
	.numValleys = Get number of points: .valleyTier
	for .p to .numPeaks
		selectObject: .textgrid
		.tp = Get time of point: .peakTier, .p
		# Find boundaries
		# From valleys
		.tl = 0
		.vl = Get low index from time: .valleyTier, .tp
		if .vl > 0 and .vl < .numValleys
			.tl = Get time of point: .valleyTier, .vl
		endif
		.th = .duration
		.vh = Get high index from time: .valleyTier, .tp
		if .vh > 0 and .vh < .numValleys
			.th = Get time of point: .valleyTier, .vh
		endif
		# From silences
		.sl = Get interval at time: .silencesTier, .tl
		.label$ = Get label of interval: .silencesTier, .sl
		.tsl = .tl
		if .label$ = "silent"
			.tsl = Get end time of interval: .silencesTier, .sl
		endif
		if .tsl > .tl and .tsl < .tp
			.tl = .tsl
		endif
		.sh = Get interval at time: .silencesTier, .th
		.label$ = Get label of interval: .silencesTier, .sh
		.tsh = .th
		if .label$ = "silent"
			.tsh = Get start time of interval: .silencesTier, .sh
		endif
		if .tsh < .th and .tsh > .tp
			.th = .tsh
		endif
		
		# From vuv
		.vuvl = Get interval at time: .vuvTier, .tl
		.label$ = Get label of interval: .vuvTier, .vuvl
		.tvuvl = .tl
		if .label$ = "U"
			.tvuvl = Get end time of interval: .vuvTier, .vuvl
		endif
		if .tvuvl > .tl and .tvuvl < .tp
			.tl = .tvuvl
		endif
		.vuvh = Get interval at time: .vuvTier, .th
		.label$ = Get label of interval: .vuvTier, .vuvh
		.tvuvh = .th
		if .label$ = "U"
			.tvuvh = Get start time of interval: .vuvTier, .vuvh
		endif
		if .tvuvh < .th and .tvuvh > .tp
			.th = .tvuvh
		endif
		
		# From formants: 300 <= F1 <= 1000
		# F1 >= 300
		selectObject: .formants
		.dt = Get time step

		selectObject: .formants
		.f = Get value at time: 1, .tl, "Hertz", "Linear"
		selectObject: .formantsBurg
		.b = Get bandwidth at time: 1, .tl, "Hertz", "Linear"
		.iframe = Get frame number from time: .tl
		if .iframe > .totalNumFrames
			.iframe = .totalNumFrames
		elsif .iframe < 1
			.iframe = 1
		endif
		.nf = Get number of formants: .iframe
		while (.f < .f1_Lowest or .f > .f1_Highest or .b > 0.7 * .f or .nf < 4) and .tl + .dt < .th
			.tl += .dt
			selectObject: .formants
			.f = Get value at time: 1, .tl, "Hertz", "Linear"
			selectObject: .formantsBurg
			.b = Get bandwidth at time: 1, .tl, "Hertz", "Linear"
			.iframe = Get frame number from time: .tl	
			if .iframe > .totalNumFrames
				.iframe = .totalNumFrames
			elsif .iframe < 1
				.iframe = 1
			endif
			.nf = Get number of formants: .iframe		
		endwhile

		selectObject: .formants
		.f = Get value at time: 1, .th, "Hertz", "Linear"
		selectObject: .formantsBurg
		.b = Get bandwidth at time: 1, .th, "Hertz", "Linear"
		.iframe = Get frame number from time: .th
		if .iframe > .totalNumFrames
			.iframe = .totalNumFrames
		elsif .iframe < 1
			.iframe = 1
		endif
		.nf = Get number of formants: .iframe
		while (.f < .f1_Lowest or .f > .f1_Highest or .b > 0.7 * .f or .nf < 4) and .th - .dt > .tl
			.th -= .dt
			selectObject: .formants
			.f = Get value at time: 1, .th, "Hertz", "Linear"
			selectObject: .formantsBurg
			.b = Get bandwidth at time: 1, .th, "Hertz", "Linear"
			.iframe = Get frame number from time: .th
			if .iframe > .totalNumFrames
				.iframe = .totalNumFrames
			elsif .iframe < 1
				.iframe = 1
			endif
			.nf = Get number of formants: .iframe		
		endwhile
		
		# New points
		if .th - .tl > 0.01
			selectObject: .textgrid
			.numPoints = Get number of points: .targetTier
			.tmp = 0
			if .numPoints > 0
				.tmp = Get time of point: .targetTier, .numPoints
			endif
			if .tl <> .tmp
				#Insert point: .targetTier, .tl, "L"
			else
				.ptxt$ = Get label of point: .targetTier, .numPoints
				#Set point text: .targetTier, .numPoints, .ptxt$+"L"
			endif
			#Insert point: .targetTier, .th, "H"
			
			selectObject: .formants
			if .tp > .tl and .tp < .th
				.tt = .tp
			else
				.tt = (.tl+.th)/2
				.f1_median = Get quantile: 1, .tl, .th, "Hertz", 0.5 
				.f2_median = Get quantile: 2, .tl, .th, "Hertz", 0.5 
				if .f1_median > 400
					.tt = Get time of maximum: 1, .tl, .th, "Hertz", "Parabolic"
				elsif .f2_median > 1600
					.tt = Get time of maximum: 2, .tl, .th, "Hertz", "Parabolic"
				elsif .f2_median < 1100
					.tt = Get time of minimum: 2, .tl, .th, "Hertz", "Parabolic"
				endif
				
				if .tt < .tl + 0.01 or .tt > .th - 0.01
					.tt = (.tl+.th)/2
				endif
			endif
			
			# Insert Target
			selectObject: .textgrid
			.numPoints = Get number of points: .targetTier
			.tmp = 0
			if .numPoints > 0
				.tmp = Get time of point: .targetTier, .numPoints
			endif
			if .tt <> .tmp
				Insert point: .targetTier, .tt, "T"
			endif
			
			# Now find vowel interval from taget
			.ttl = .tt
			# Lower end
			selectObject: .formants
			.f = Get value at time: 1, .ttl, "Hertz", "Linear"
			selectObject: .formantsBurg
			.b = Get bandwidth at time: 1, .ttl, "Hertz", "Linear"
			.iframe = Get frame number from time: .th
			if .iframe > .totalNumFrames
				.iframe = .totalNumFrames
			elsif .iframe < 1
				.iframe = 1
			endif
			.nf = Get number of formants: .iframe	
			
			# Voicing: Is there a voiced point below within 0.02 s?
			selectObject: .voicePP
			.i_near = Get nearest index: .ttl - .dt
			.pp_near = Get time from index: .i_near
			
			while (.f > 300 and .f < 1000 and .b < 0.9 * .f and .nf >= 4) and .ttl - .dt >= .tl and abs((.ttl - .dt) - .pp_near) <= 0.02
				.ttl -= .dt
				selectObject: .formants
				.f = Get value at time: 1, .ttl, "Hertz", "Linear"
				selectObject: .formantsBurg
				.b = Get bandwidth at time: 1, .ttl, "Hertz", "Linear"
				.iframe = Get frame number from time: .ttl
				if .iframe > .totalNumFrames
					.iframe = .totalNumFrames
				elsif .iframe < 1
					.iframe = 1
				endif
				.nf = Get number of formants: .iframe
				# Voicing: Is there a voiced point below within 0.02 s?
				selectObject: .voicePP
				.i_near = Get nearest index: .ttl - .dt
				.pp_near = Get time from index: .i_near
			endwhile
			# Make sure something has changed
			if .ttl > .tt - 0.01
				.ttl = .tl
			endif
			
			# Higher end
			.tth = .tp
			selectObject: .formants
			.f = Get value at time: 1, .tth, "Hertz", "Linear"
			selectObject: .formantsBurg
			.b = Get bandwidth at time: 1, .tth, "Hertz", "Linear"
			.iframe = Get frame number from time: .th
			if .iframe > .totalNumFrames
				.iframe = .totalNumFrames
			elsif .iframe < 1
				.iframe = 1
			endif
			.nf = Get number of formants: .iframe		
			
			# Voicing: Is there a voiced point above within 0.02 s?
			selectObject: .voicePP
			.i_near = Get nearest index: .ttl + .dt
			.pp_near = Get time from index: .i_near
			
			while (.f > 300 and .f < 1000 and .b < 0.9 * .f and .nf >= 4) and .tth + .dt <= .th and abs((.ttl + .dt) - .pp_near) <= 0.02
				.tth += .dt
				selectObject: .formants
				.f = Get value at time: 1, .tth, "Hertz", "Linear"
				selectObject: .formantsBurg
				.b = Get bandwidth at time: 1, .tth, "Hertz", "Linear"
				.iframe = Get frame number from time: .tth
				if .iframe > .totalNumFrames
					.iframe = .totalNumFrames
				elsif .iframe < 1
					.iframe = 1
				endif
				.nf = Get number of formants: .iframe		
				# Voicing: Is there a voiced point above within 0.02 s?
				selectObject: .voicePP
				.i_near = Get nearest index: .ttl + .dt
				.pp_near = Get time from index: .i_near
			endwhile
			# Make sure something has changed
			if .tth < .tt + 0.01
				.tth = .th
			endif
			
			# Insert interval
			selectObject: .textgrid
			.index = Get interval at time: .vowelTier, .ttl
			.start = Get start time of interval: .vowelTier, .index
			.end = Get end time of interval: .vowelTier, .index
			if .ttl <> .start and .ttl <> .end
				Insert boundary: .vowelTier, .ttl
			endif
			.index = Get interval at time: .vowelTier, .tth
			.start = Get start time of interval: .vowelTier, .index
			.end = Get end time of interval: .vowelTier, .index
			if .tth <> .start and .tth <> .end
				Insert boundary: .vowelTier, .tth
			endif
			.index = Get interval at time: .vowelTier, .tt
			.start = Get start time of interval: .vowelTier, .index
			.end = Get end time of interval: .vowelTier, .index
			# Last sanity checks on voicing and intensity
			# A vowel is voiced
			selectObject: .voicePP
			.meanPeriod = Get mean period: .start, .end, 0.0001, 0.02, 1.3
			if .meanPeriod <> undefined
				selectObject: .sound
				.sd = Get standard deviation: 1, .start, .end
				# Is there enough sound to warrant a vowel? > -15dB
				if 20*log10(.sd/(2*10^-5)) - .intensity > -15
					selectObject: .textgrid
					Set interval text: .vowelTier, .index, "Vowel"
				endif
			endif
		endif
	endfor
	
	selectObject: .formantsBurg, .voicePP
	Remove
	
endproc


###########################################################################
#                                                                         #
#  Praat Script Syllable Nuclei                                           #
#  Copyright (C) 2017  R.J.J.H. van Son                                   #
#                                                                         #
#    This program is free software: you can redistribute it and/or modify #
#    it under the terms of the GNU General Public License as published by #
#    the Free Software Foundation, either version 2 of the License, or    #
#    (at your option) any later version.                                  #
#                                                                         #
#    This program is distributed in the hope that it will be useful,      #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of       #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
#    GNU General Public License for more details.                         #
#                                                                         #
#    You should have received a copy of the GNU General Public License    #
#    along with this program.  If not, see http://www.gnu.org/licenses/   #
#                                                                         #
###########################################################################
#
# Simplified summary of the script by Nivja de Jong and Ton Wempe         #
procedure segment_syllables .silence_threshold .minimum_dip_between_peaks .minimum_pause_duration .keep_Soundfiles_and_Textgrids .soundid
	# Get intensity
	selectObject: .soundid
	.intensity = noprogress To Intensity: 70, 0, "yes"
	.dt = Get time step
	.maxFrame = Get number of frames
	
	# Determine Peaks
	selectObject: .intensity
	.peaksInt = noprogress To IntensityTier (peaks)
	.peaksPoint = Down to PointProcess
	.peaksPointTier = Up to TextTier: "P"
	Rename: "Peaks"
	
	# Determine valleys
	selectObject: .intensity
	.valleyInt = noprogress To IntensityTier (valleys)
	.valleyPoint = Down to PointProcess
	.valleyPointTier = Up to TextTier: "V"
	Rename: "Valleys"
	
	selectObject: .peaksPointTier, .valleyPointTier
	.segmentTextGrid = Into TextGrid
	
	selectObject: .peaksPointTier, .valleyPointTier, .peaksInt, .peaksPoint, .valleyInt, .valleyPoint
	Remove
	
	# Select the sounding part
	selectObject: .intensity
	.silenceTextGrid = noprogress To TextGrid (silences): .silence_threshold, .minimum_pause_duration, 0.05, "silent", "sounding"
	
	# Determine voiced parts
	selectObject: .soundid
	.voicePP = noprogress To PointProcess (periodic, cc): 75, 600
	.vuvTextGrid = noprogress To TextGrid (vuv): 0.02, 0.01
	plusObject: .segmentTextGrid, .silenceTextGrid
	.textgridid = Merge
	
	selectObject: .vuvTextGrid, .silenceTextGrid, .segmentTextGrid, .voicePP
	Remove
	
	# Remove irrelevant peaks and valleys
	selectObject: .textgridid
	.numPeaks = Get number of points: 1
	for .i to .numPeaks
		.t = Get time of point: 1, .numPeaks + 1 - .i
		.s = Get interval at time: 3, .t
		.soundLabel$ = Get label of interval: 3, .s
		.v = Get interval at time: 4, .t
		.voiceLabel$ = Get label of interval: 4, .v
		if .soundLabel$ = "silent" or .voiceLabel$ = "U"
			Remove point: 1, .numPeaks + 1 - .i
		endif
	endfor
	
	# valleys
	selectObject: .textgridid
	.numValleys = Get number of points: 2
	.numPeaks = Get number of points: 1
	# No peaks, nothing to do
	if .numPeaks <= 0
		goto VALLEYREADY
	endif
	
	for .i from 2 to .numValleys
		selectObject: .textgridid
		.il = .numValleys + 1 - .i
		.ih = .numValleys + 2 - .i
		.tl = Get time of point: 2, .il
		.th = Get time of point: 2, .ih
		
		
		.ph = Get high index from time: 1, .tl
		.tph = 0
		if .ph > 0 and .ph <= .numPeaks
			.tph = Get time of point: 1, .ph
		endif
		# If there is no peak between the valleys remove the highest
		if .tph <= 0 or (.tph < .tl or .tph > .th)
			# If the area is silent for both valleys, keep the one closest to a peak
			.psl = Get interval at time: 3, .tl
			.psh = Get interval at time: 3, .th
			.psl_label$ = Get label of interval: 3, .psl
			.psh_label$ = Get label of interval: 3, .psh
			if .psl_label$ = "silent" and .psh_label$ = "silent"
				.plclosest = Get nearest index from time: 1, .tl
				if .plclosest <= 0
					.plclosest = 1
				endif
				if .plclosest > .numPeaks
					.plclosest = .numPeaks
				endif
				.tlclosest = Get time of point: 1, .plclosest
				.phclosest = Get nearest index from time: 1, .th
				if .phclosest <= 0
					.phclosest = 1
				endif
				if .phclosest > .numPeaks
					.phclosest = .numPeaks
				endif
				.thclosest = Get time of point: 1, .phclosest
				if abs(.tlclosest - .tl) > abs(.thclosest - .th)
					selectObject: .textgridid
					Remove point: 2, .il
				else
					selectObject: .textgridid
					Remove point: 2, .ih
				endif
			else
				# Else Compare valley depths
				selectObject: .intensity
				.intlow = Get value at time: .tl, "Cubic"
				.inthigh = Get value at time: .th, "Cubic"
				if .inthigh >= .intlow
					selectObject: .textgridid
					Remove point: 2, .ih
				else
					selectObject: .textgridid
					Remove point: 2, .il
				endif
			endif
		endif
	endfor

	# Remove superfluous valleys
	selectObject: .textgridid
	.numValleys = Get number of points: 2
	.numPeaks = Get number of points: 1
	for .i from 1 to .numValleys
		selectObject: .textgridid
		.iv = .numValleys + 1 - .i
		.tv = Get time of point: 2, .iv
		.ph = Get high index from time: 1, .tv
		if .ph > .numPeaks
			.ph = .numPeaks
		endif
		.tph = Get time of point: 1, .ph
		.pl = Get low index from time: 1, .tv
		if .pl <= 0
			.pl = 1
		endif
		.tpl = Get time of point: 1, .pl
		
		# Get intensities
		selectObject: .intensity
		.v_int = Get value at time: .tv, "Cubic"
		.pl_int = Get value at time: .tpl, "Cubic"
		.ph_int = Get value at time: .tph, "Cubic"
		# If there is no real dip, remove valey and lowest peak
		if min((.pl_int - .v_int), (.ph_int - .v_int)) < .minimum_dip_between_peaks
			selectObject: .textgridid
			Remove point: 2, .iv
			if .ph <> .pl
				if .pl_int < .ph_int
					Remove point: 1, .pl
				else
					Remove point: 1, .ph
				endif
			endif
			.numPeaks = Get number of points: 1
			if .numPeaks <= 0
				goto VALLEYREADY
			endif
		endif
	endfor
	label VALLEYREADY
	
	selectObject: .intensity
	Remove
	
	selectObject: .textgridid
endproc

# 
# Determine COG as an intensity
#
# .cog_Matrix = Down to Matrix
# call calculateCOG .dt .soundid
# .cog_Tier = calculateCOG.cog_tier
# selectObject: .cog_Tier
# .numPoints = Get number of points
# for .i to .numPoints
# 	selectObject: .cog_Tier
# 	.cog = Get value at index: .i
# 	.t = Get time from index: .i
# 	selectObject: .intensity
# 	.c = Get frame number from time: .t
# 	if .c >= 0.5 and .c <= .maxFrame
# 		selectObject: .cog_Matrix
# 		Set value: 1, round(.c), .cog
# 	endif
# endfor
# selectObject: .cog_Matrix
# .cogIntensity = noprogress To Intensity

procedure calculateCOG .dt .sound
	selectObject: .sound
	.duration = Get total duration
	if .dt <= 0 or .dt > .sound
		.dt = 0.01
	endif
	
	# Create Spectrogram
	selectObject: .sound
	.spectrogram = noprogress To Spectrogram: 0.005, 8000, 0.002, 20, "Gaussian"
	.cog_tier = Create IntensityTier: "COG", 0.0, .duration
	
	.t = .dt / 2
	while .t < .duration
		selectObject: .spectrogram
		.spectrum = noprogress To Spectrum (slice): .t
		.cog_t = Get centre of gravity: 2
		selectObject: .cog_tier
		Add point: .t, .cog_t
		
		.t += .dt
		
		selectObject: .spectrum
		Remove
	endwhile
	
	selectObject: .spectrogram
	Remove
endproc
