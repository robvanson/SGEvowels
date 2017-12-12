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

procedure init_LanguageTargets
	ipavowelsymbols$ = "ɑɛɜIOoYaeiouyəæʌɪɔʊ"
	
	###################################################################
	# 
	# US English
	# 
	###################################################################
	
	# These should be US English vowel formant values
	#
	# Male
	languageTargets.phonemes ["EN-US", "M", "i_corner", "F1"] = 250
	languageTargets.phonemes ["EN-US", "M", "i_corner", "F2"] = 2200
	languageTargets.phonemes ["EN-US", "M", "a_corner", "F1"] = 800
	languageTargets.phonemes ["EN-US", "M", "a_corner", "F2"] = 1300
	languageTargets.phonemes ["EN-US", "M", "u_corner", "F1"] = 280
	languageTargets.phonemes ["EN-US", "M", "u_corner", "F2"] = 600

	# @_center is not fixed but derived from current corners
	languageTargets.phonemes ["EN-US", "M", "ə_center", "F1"] =(languageTargets.phonemes ["EN-US", "M", "i_corner", "F1"]*languageTargets.phonemes ["EN-US", "M", "u_corner", "F1"]*languageTargets.phonemes ["EN-US", "M", "a_corner", "F1"])^(1/3)
	languageTargets.phonemes ["EN-US", "M", "ə_center", "F2"] = (languageTargets.phonemes ["EN-US", "M", "i_corner", "F2"]*languageTargets.phonemes ["EN-US", "M", "u_corner", "F2"]*languageTargets.phonemes ["EN-US", "M", "a_corner", "F2"])^(1/3)

	# Sides are not fixed but derived from current corners
	languageTargets.phonemes ["EN-US", "M", "e_side", "F1"] =(languageTargets.phonemes ["EN-US", "M", "i_corner", "F1"]*languageTargets.phonemes ["EN-US", "M", "a_corner", "F1"])^(1/2)
	languageTargets.phonemes ["EN-US", "M", "e_side", "F2"] =(languageTargets.phonemes ["EN-US", "M", "i_corner", "F2"]^2*languageTargets.phonemes ["EN-US", "M", "a_corner", "F2"])^(1/3)

	languageTargets.phonemes ["EN-US", "M", "o_side", "F1"] =(languageTargets.phonemes ["EN-US", "M", "u_corner", "F1"]*languageTargets.phonemes ["EN-US", "M", "a_corner", "F1"])^(1/2)
	languageTargets.phonemes ["EN-US", "M", "o_side", "F2"] =(languageTargets.phonemes ["EN-US", "M", "a_corner", "F2"]*languageTargets.phonemes ["EN-US", "M", "u_corner", "F2"]^2)^(1/3)

	languageTargets.phonemes ["EN-US", "M", "y_side", "F1"] = languageTargets.phonemes ["EN-US", "M", "i_corner", "F1"]
	languageTargets.phonemes ["EN-US", "M", "y_side", "F2"] =(languageTargets.phonemes ["EN-US", "M", "i_corner", "F2"]*languageTargets.phonemes ["EN-US", "M", "a_corner", "F2"])^(1/2)
	
	# Formant values according to Peterson and Barney, 1952
	# Median values as presented in Praat
	
	# Female Child
	languageTargets.phonemes ["EN-US", "CF", "ɑ", "F0"] = 270
	languageTargets.phonemes ["EN-US", "CF", "ɑ", "F1"] = 1080
	languageTargets.phonemes ["EN-US", "CF", "ɑ", "F2"] = 1405
	languageTargets.phonemes ["EN-US", "CF", "ɑ", "F3"] = 3275
	languageTargets.phonemes ["EN-US", "CF", "æ", "F0"] = 250
	languageTargets.phonemes ["EN-US", "CF", "æ", "F1"] = 1095
	languageTargets.phonemes ["EN-US", "CF", "æ", "F2"] = 2400
	languageTargets.phonemes ["EN-US", "CF", "æ", "F3"] = 3600
	languageTargets.phonemes ["EN-US", "CF", "ʌ", "F0"] = 278
	languageTargets.phonemes ["EN-US", "CF", "ʌ", "F1"] = 915
	languageTargets.phonemes ["EN-US", "CF", "ʌ", "F2"] = 1635
	languageTargets.phonemes ["EN-US", "CF", "ʌ", "F3"] = 3500
	languageTargets.phonemes ["EN-US", "CF", "ɔ", "F0"] = 271
	languageTargets.phonemes ["EN-US", "CF", "ɔ", "F1"] = 670
	languageTargets.phonemes ["EN-US", "CF", "ɔ", "F2"] = 1075
	languageTargets.phonemes ["EN-US", "CF", "ɔ", "F3"] = 3435
	languageTargets.phonemes ["EN-US", "CF", "ɛ", "F0"] = 272
	languageTargets.phonemes ["EN-US", "CF", "ɛ", "F1"] = 755
	languageTargets.phonemes ["EN-US", "CF", "ɛ", "F2"] = 2735
	languageTargets.phonemes ["EN-US", "CF", "ɛ", "F3"] = 3650
	languageTargets.phonemes ["EN-US", "CF", "ɜ", "F0"] = 280
	languageTargets.phonemes ["EN-US", "CF", "ɜ", "F1"] = 610
	languageTargets.phonemes ["EN-US", "CF", "ɜ", "F2"] = 1840
	languageTargets.phonemes ["EN-US", "CF", "ɜ", "F3"] = 2380
	languageTargets.phonemes ["EN-US", "CF", "ɪ", "F0"] = 292
	languageTargets.phonemes ["EN-US", "CF", "ɪ", "F1"] = 570
	languageTargets.phonemes ["EN-US", "CF", "ɪ", "F2"] = 2870
	languageTargets.phonemes ["EN-US", "CF", "ɪ", "F3"] = 3725
	languageTargets.phonemes ["EN-US", "CF", "i", "F0"] = 278
	languageTargets.phonemes ["EN-US", "CF", "i", "F1"] = 365
	languageTargets.phonemes ["EN-US", "CF", "i", "F2"] = 3250
	languageTargets.phonemes ["EN-US", "CF", "i", "F3"] = 3825
	languageTargets.phonemes ["EN-US", "CF", "ʊ", "F0"] = 285
	languageTargets.phonemes ["EN-US", "CF", "ʊ", "F1"] = 590
	languageTargets.phonemes ["EN-US", "CF", "ʊ", "F2"] = 1385
	languageTargets.phonemes ["EN-US", "CF", "ʊ", "F3"] = 3500
	languageTargets.phonemes ["EN-US", "CF", "u", "F0"] = 295
	languageTargets.phonemes ["EN-US", "CF", "u", "F1"] = 450
	languageTargets.phonemes ["EN-US", "CF", "u", "F2"] = 1125
	languageTargets.phonemes ["EN-US", "CF", "u", "F3"] = 3465
	
	# Male Child
	languageTargets.phonemes ["EN-US", "CM", "ɑ", "F0"] = 250
	languageTargets.phonemes ["EN-US", "CM", "ɑ", "F1"] = 960
	languageTargets.phonemes ["EN-US", "CM", "ɑ", "F2"] = 1350
	languageTargets.phonemes ["EN-US", "CM", "ɑ", "F3"] = 3050
	languageTargets.phonemes ["EN-US", "CM", "æ", "F0"] = 240
	languageTargets.phonemes ["EN-US", "CM", "æ", "F1"] = 935
	languageTargets.phonemes ["EN-US", "CM", "æ", "F2"] = 2275
	languageTargets.phonemes ["EN-US", "CM", "æ", "F3"] = 3200
	languageTargets.phonemes ["EN-US", "CM", "ʌ", "F0"] = 253
	languageTargets.phonemes ["EN-US", "CM", "ʌ", "F1"] = 795
	languageTargets.phonemes ["EN-US", "CM", "ʌ", "F2"] = 1535
	languageTargets.phonemes ["EN-US", "CM", "ʌ", "F3"] = 3200
	languageTargets.phonemes ["EN-US", "CM", "ɔ", "F0"] = 254
	languageTargets.phonemes ["EN-US", "CM", "ɔ", "F1"] = 710
	languageTargets.phonemes ["EN-US", "CM", "ɔ", "F2"] = 1040
	languageTargets.phonemes ["EN-US", "CM", "ɔ", "F3"] = 2940
	languageTargets.phonemes ["EN-US", "CM", "ɛ", "F0"] = 254
	languageTargets.phonemes ["EN-US", "CM", "ɛ", "F1"] = 654
	languageTargets.phonemes ["EN-US", "CM", "ɛ", "F2"] = 2510
	languageTargets.phonemes ["EN-US", "CM", "ɛ", "F3"] = 3400
	languageTargets.phonemes ["EN-US", "CM", "ɜ", "F0"] = 252
	languageTargets.phonemes ["EN-US", "CM", "ɜ", "F1"] = 510
	languageTargets.phonemes ["EN-US", "CM", "ɜ", "F2"] = 1660
	languageTargets.phonemes ["EN-US", "CM", "ɜ", "F3"] = 1870
	languageTargets.phonemes ["EN-US", "CM", "ɪ", "F0"] = 269
	languageTargets.phonemes ["EN-US", "CM", "ɪ", "F1"] = 500
	languageTargets.phonemes ["EN-US", "CM", "ɪ", "F2"] = 2680
	languageTargets.phonemes ["EN-US", "CM", "ɪ", "F3"] = 3425
	languageTargets.phonemes ["EN-US", "CM", "i", "F0"] = 262
	languageTargets.phonemes ["EN-US", "CM", "i", "F1"] = 314
	languageTargets.phonemes ["EN-US", "CM", "i", "F2"] = 3132
	languageTargets.phonemes ["EN-US", "CM", "i", "F3"] = 3630
	languageTargets.phonemes ["EN-US", "CM", "ʊ", "F0"] = 275
	languageTargets.phonemes ["EN-US", "CM", "ʊ", "F1"] = 535
	languageTargets.phonemes ["EN-US", "CM", "ʊ", "F2"] = 1435
	languageTargets.phonemes ["EN-US", "CM", "ʊ", "F3"] = 3100
	languageTargets.phonemes ["EN-US", "CM", "u", "F0"] = 276
	languageTargets.phonemes ["EN-US", "CM", "u", "F1"] = 395
	languageTargets.phonemes ["EN-US", "CM", "u", "F2"] = 1290
	languageTargets.phonemes ["EN-US", "CM", "u", "F3"] = 3015
	
	# Male
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F0"] = 122
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F1"] = 720
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F2"] = 1096
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F3"] = 2435
	languageTargets.phonemes ["EN-US", "M", "æ", "F0"] = 125
	languageTargets.phonemes ["EN-US", "M", "æ", "F1"] = 660
	languageTargets.phonemes ["EN-US", "M", "æ", "F2"] = 1710
	languageTargets.phonemes ["EN-US", "M", "æ", "F3"] = 2435
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F0"] = 125
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F1"] = 626
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F2"] = 1200
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F3"] = 2395
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F0"] = 123
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F1"] = 562
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F2"] = 850
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F3"] = 2420
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F0"] = 125
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F1"] = 540
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F2"] = 1840
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F3"] = 2490
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F0"] = 128
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F1"] = 495
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F2"] = 1345
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F3"] = 1705
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F0"] = 134
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F1"] = 400
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F2"] = 1995
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F3"] = 2565
	languageTargets.phonemes ["EN-US", "M", "i", "F0"] = 133
	languageTargets.phonemes ["EN-US", "M", "i", "F1"] = 265
	languageTargets.phonemes ["EN-US", "M", "i", "F2"] = 2295
	languageTargets.phonemes ["EN-US", "M", "i", "F3"] = 2900
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F0"] = 132
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F1"] = 449
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F2"] = 1028
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F3"] = 2240
	languageTargets.phonemes ["EN-US", "M", "u", "F0"] = 140
	languageTargets.phonemes ["EN-US", "M", "u", "F1"] = 312
	languageTargets.phonemes ["EN-US", "M", "u", "F2"] = 900
	languageTargets.phonemes ["EN-US", "M", "u", "F3"] = 2190
	# Guessed
	languageTargets.phonemes ["EN-US", "M", "ə", "F1"] = 417.7000
	languageTargets.phonemes ["EN-US", "M", "ə", "F2"] = 1455.100

	# Female
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F0"] = 209
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F1"] = 850
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F2"] = 1225
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F3"] = 2800
	languageTargets.phonemes ["EN-US", "F", "æ", "F0"] = 206
	languageTargets.phonemes ["EN-US", "F", "æ", "F1"] = 848
	languageTargets.phonemes ["EN-US", "F", "æ", "F2"] = 2060
	languageTargets.phonemes ["EN-US", "F", "æ", "F3"] = 2860
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F0"] = 218
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F1"] = 755
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F2"] = 1440
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F3"] = 2780
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F0"] = 213
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F1"] = 594
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F2"] = 900
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F3"] = 2750
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F0"] = 220
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F1"] = 616
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F2"] = 2345
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F3"] = 3010
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F0"] = 218
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F1"] = 500
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F2"] = 1630
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F3"] = 1952
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F0"] = 232
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F1"] = 440
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F2"] = 2500
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F3"] = 3055
	languageTargets.phonemes ["EN-US", "F", "i", "F0"] = 233
	languageTargets.phonemes ["EN-US", "F", "i", "F1"] = 308
	languageTargets.phonemes ["EN-US", "F", "i", "F2"] = 2780
	languageTargets.phonemes ["EN-US", "F", "i", "F3"] = 3300
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F0"] = 233
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F1"] = 468
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F2"] = 1180
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F3"] = 2660
	languageTargets.phonemes ["EN-US", "F", "u", "F0"] = 235
	languageTargets.phonemes ["EN-US", "F", "u", "F1"] = 380
	languageTargets.phonemes ["EN-US", "F", "u", "F2"] = 958
	languageTargets.phonemes ["EN-US", "F", "u", "F3"] = 2645

	# Guessed
	languageTargets.phonemes ["EN-US", "F", "ə", "F1"] = 500.5
	languageTargets.phonemes ["EN-US", "F", "ə", "F2"] = 1706.6
	

	# REMOVE AFTER CHECK Copy CENTER vowels
	
	# Formant values according to 
	# IFA corpus averages from FPA isolated vowels
	# Using Split-Levinson algorithm
	languageTargets.phonemes ["EN-US", "M", "a", "F1"] = 788.6000
	languageTargets.phonemes ["EN-US", "M", "a", "F2"] = 1290.600
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F1"] = 695.6000
	languageTargets.phonemes ["EN-US", "M", "ɑ", "F2"] = 1065.500
	languageTargets.phonemes ["EN-US", "M", "ɒ", "F1"] = 695.6000
	languageTargets.phonemes ["EN-US", "M", "ɒ", "F2"] = 1065.500
	languageTargets.phonemes ["EN-US", "M", "æ", "F1"] = 552.5000
	languageTargets.phonemes ["EN-US", "M", "æ", "F2"] = 1659.200
	languageTargets.phonemes ["EN-US", "M", "e", "F1"] = 552.5000
	languageTargets.phonemes ["EN-US", "M", "e", "F2"] = 1659.200
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F1"] = 552.5000
	languageTargets.phonemes ["EN-US", "M", "ɛ", "F2"] = 1659.200
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F1"] = 552.5000
	languageTargets.phonemes ["EN-US", "M", "ɜ", "F2"] = 1659.200
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F1"] = 378.0909
	languageTargets.phonemes ["EN-US", "M", "ɪ", "F2"] = 1868.545
	languageTargets.phonemes ["EN-US", "M", "i", "F1"] = 259.5556
	languageTargets.phonemes ["EN-US", "M", "i", "F2"] = 1971.889
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F1"] = 482.9000
	languageTargets.phonemes ["EN-US", "M", "ɔ", "F2"] = 725.800
	languageTargets.phonemes ["EN-US", "M", "o", "F1"] = 426.7000
	languageTargets.phonemes ["EN-US", "M", "o", "F2"] = 743.600
	languageTargets.phonemes ["EN-US", "M", "u", "F1"] = 287.5000
	languageTargets.phonemes ["EN-US", "M", "u", "F2"] = 666.500
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F1"] = 287.5000
	languageTargets.phonemes ["EN-US", "M", "ʊ", "F2"] = 666.500
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F1"] = 268.4000
	languageTargets.phonemes ["EN-US", "M", "ʌ", "F2"] = 1581.400
	# Guessed
	languageTargets.phonemes ["EN-US", "M", "ə", "F1"] = 417.7000
	languageTargets.phonemes ["EN-US", "M", "ə", "F2"] = 1455.100
	
	# Female
	languageTargets.phonemes ["EN-US", "F", "i_corner", "F1"] = 285
	languageTargets.phonemes ["EN-US", "F", "i_corner", "F2"] = 2100
	languageTargets.phonemes ["EN-US", "F", "a_corner", "F1"] = 900
	languageTargets.phonemes ["EN-US", "F", "a_corner", "F2"] = 1435
	languageTargets.phonemes ["EN-US", "F", "u_corner", "F1"] = 370
	languageTargets.phonemes ["EN-US", "F", "u_corner", "F2"] = 650

	# @_center is not fixed but derived from current corners
	languageTargets.phonemes ["EN-US", "F", "ə_center", "F1"] =(languageTargets.phonemes ["EN-US", "F", "i_corner", "F1"]*languageTargets.phonemes ["EN-US", "F", "u_corner", "F1"]*languageTargets.phonemes ["EN-US", "F", "a_corner", "F1"])^(1/3)
	languageTargets.phonemes ["EN-US", "F", "ə_center", "F2"] = (languageTargets.phonemes ["EN-US", "F", "i_corner", "F2"]*languageTargets.phonemes ["EN-US", "F", "u_corner", "F2"]*languageTargets.phonemes ["EN-US", "F", "a_corner", "F2"])^(1/3)

	# Sides are not fixed but derived from current corners
	languageTargets.phonemes ["EN-US", "F", "e_side", "F1"] =(languageTargets.phonemes ["EN-US", "F", "i_corner", "F1"]*languageTargets.phonemes ["EN-US", "F", "a_corner", "F1"])^(1/2)
	languageTargets.phonemes ["EN-US", "F", "e_side", "F2"] =1.1*(languageTargets.phonemes ["EN-US", "F", "i_corner", "F2"]^2*languageTargets.phonemes ["EN-US", "F", "a_corner", "F2"])^(1/3)

	languageTargets.phonemes ["EN-US", "F", "o_side", "F1"] =(languageTargets.phonemes ["EN-US", "F", "u_corner", "F1"]*languageTargets.phonemes ["EN-US", "F", "a_corner", "F1"])^(1/2)
	languageTargets.phonemes ["EN-US", "F", "o_side", "F2"] =(languageTargets.phonemes ["EN-US", "F", "a_corner", "F2"]*languageTargets.phonemes ["EN-US", "F", "u_corner", "F2"]^2)^(1/3)

	languageTargets.phonemes ["EN-US", "F", "y_side", "F1"] = languageTargets.phonemes ["EN-US", "F", "i_corner", "F1"]
	languageTargets.phonemes ["EN-US", "F", "y_side", "F2"] =(languageTargets.phonemes ["EN-US", "F", "i_corner", "F2"]*languageTargets.phonemes ["EN-US", "F", "a_corner", "F2"])^(1/2)
	
	
	# Formant values according to 
	# IFA corpus average from FPA isolated vowels
	# Using Split-Levinson algorithm
	languageTargets.phonemes ["EN-US", "F", "a", "F1"] = 853.6000
	languageTargets.phonemes ["EN-US", "F", "a", "F2"] = 1435.800
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F1"] = 817.7000
	languageTargets.phonemes ["EN-US", "F", "ɑ", "F2"] = 1197.300
	languageTargets.phonemes ["EN-US", "F", "ɒ", "F1"] = 817.7000
	languageTargets.phonemes ["EN-US", "F", "ɒ", "F2"] = 1197.300
	languageTargets.phonemes ["EN-US", "F", "æ", "F1"] = 667.9000
	languageTargets.phonemes ["EN-US", "F", "æ", "F2"] = 1748.500
	languageTargets.phonemes ["EN-US", "F", "e", "F1"] = 667.9000
	languageTargets.phonemes ["EN-US", "F", "e", "F2"] = 1748.500
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F1"] = 667.9000
	languageTargets.phonemes ["EN-US", "F", "ɛ", "F2"] = 1748.500
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F1"] = 667.9000
	languageTargets.phonemes ["EN-US", "F", "ɜ", "F2"] = 1748.500
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F1"] = 378.0909
	languageTargets.phonemes ["EN-US", "F", "ɪ", "F2"] = 1868.545
	languageTargets.phonemes ["EN-US", "F", "i", "F1"] = 294.3000
	languageTargets.phonemes ["EN-US", "F", "i", "F2"] = 1855.000
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F1"] = 570.8000
	languageTargets.phonemes ["EN-US", "F", "ɔ", "F2"] = 882.100
	languageTargets.phonemes ["EN-US", "F", "o", "F1"] = 527.5000
	languageTargets.phonemes ["EN-US", "F", "o", "F2"] = 894.100
	languageTargets.phonemes ["EN-US", "F", "u", "F1"] = 376.0000
	languageTargets.phonemes ["EN-US", "F", "u", "F2"] = 666.500
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F1"] = 287.5000
	languageTargets.phonemes ["EN-US", "F", "ʊ", "F2"] = 735.200
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F1"] = 268.4000
	languageTargets.phonemes ["EN-US", "F", "ʌ", "F2"] = 1581.400

	# Guessed
	languageTargets.phonemes ["EN-US", "F", "ə", "F1"] = 500.5
	languageTargets.phonemes ["EN-US", "F", "ə", "F2"] = 1706.6

endproc
