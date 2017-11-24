# VowelProt/CreateIPAtargets.praat
# 
# Automatically created code!
# Any changes will be lost when this file is regenerated.
# Adapt the original Tables instead of this code.
# To regenerate the original Tables, run a Praat script
# with the following code:
# 
#: include tables2scripts.praat
#: call Create<TableName>
#: Write to table file... <TableName>.Table
# 
# Where <TableName> is the name of the table.
# Move the Table file to the desired location (eg, Data/)
# 
# Tables and this code are licensed under the GNU GPL version 2
# or later.
# 

procCreateEN_US_IPA$ = "EN_US_IPA"
procedure CreateEN_US_IPA
	Create Table with column names... EN_US_IPA 1
	... Num Words IPA Gender Nt F1 F2 F3 t
	# Fill table values
	# Row 1
	Set string value... 1 Num the
	Set string value... 1 Words the
	Set string value... 1 IPA ði
	Set string value... 1 Gender M
	Set string value... 1 Nt 1
	Set string value... 1 F1 813;
	Set string value... 1 F2 1402;
	Set string value... 1 F3 2917;
	Set string value... 1 t 0.486;
endproc

procCreateCreateIPAtargets$ = "CreateIPAtargets"
procedure CreateCreateIPAtargets
	Create Table with column names... CreateIPAtargets 1
	... Name
	# Fill table values
	# Row 1
	Set string value... 1 Name EN_US_IPA
endproc
