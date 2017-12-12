.table = Read from file: "pb_median.tsv"
.numRows = Get number of rows

for .r to .numRows
	.type$ = Get value: .r, "Type"
	.sex$ = Get value: .r, "Sex"
	.sex$ = replace_regex$(.sex$, "(.)", "\U\1", 0)
	.ipa$ = Get value: .r, "IPA"
	if .type$ = "c"
		.type$ = "C"+.sex$
	else
		.type$ = .sex$
	endif
	.f0 = Get value: .r, "F0"
	.f1 = Get value: .r, "F1"
	.f2 = Get value: .r, "F2"
	.f3 = Get value: .r, "F3"

	appendInfoLine:  "languageTargets.phonemes [""EN-US"", ""'.type$'"", ""'.ipa$'"", ""F0""] = '.f0:0'"
	appendInfoLine:  "languageTargets.phonemes [""EN-US"", ""'.type$'"", ""'.ipa$'"", ""F1""] = '.f1:0'"
	appendInfoLine:  "languageTargets.phonemes [""EN-US"", ""'.type$'"", ""'.ipa$'"", ""F2""] = '.f2:0'"
	appendInfoLine:  "languageTargets.phonemes [""EN-US"", ""'.type$'"", ""'.ipa$'"", ""F3""] = '.f3:0'"

endfor