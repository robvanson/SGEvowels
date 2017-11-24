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
