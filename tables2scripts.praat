#
# tables2scripts
# 
#     Praat script converting .Table files into praat scripts
#     
#     Copyright (C) 2010  R.J.J.H. van Son and the Netherlands Cancer Institute
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

# form Source directory and target file
# 	sentence Source_directory	Data
# 	sentence Target_file	CreateTables.praat
# endform

Text writing preferences... UTF-8

source_directory$ = "wordlists"
target_file$ = "CreateWordlists.praat"
call tables2scripts "'source_directory$'" 'target_file$'

# Definitions
procedure tables2scripts .sourceDir$ .targetFile$
	# Iterate over all tables in the directory
	if fileReadable(.sourceDir$)
		deleteFile(.targetFile$)
		# Start new file
		fileappend '.targetFile$' # 'target_file$''newline$'
		fileappend '.targetFile$' # 'newline$'
		fileappend '.targetFile$' # Automatically created code!'newline$'
		fileappend '.targetFile$' # Any changes will be lost when this file is regenerated.'newline$'
		fileappend '.targetFile$' # Adapt the original Tables instead of this code.'newline$'
		fileappend '.targetFile$' # To regenerate the original Tables, run a Praat script'newline$'
		fileappend '.targetFile$' # with the following code:'newline$'
		fileappend '.targetFile$' # 'newline$'
		fileappend '.targetFile$' #: include tables2scripts.praat'newline$'
		fileappend '.targetFile$' #: call Create<TableName>'newline$'
		fileappend '.targetFile$' #: Write to table file... <TableName>.Table'newline$'
		fileappend '.targetFile$' # 'newline$'
		fileappend '.targetFile$' # Where <TableName> is the name of the table.'newline$'
		fileappend '.targetFile$' # Move the Table file to the desired location (eg, Data/)'newline$'
		fileappend '.targetFile$' # 'newline$'
		fileappend '.targetFile$' # Tables and this code are licensed under the GNU GPL version 2'newline$'
		fileappend '.targetFile$' # or later.'newline$'
		fileappend '.targetFile$' # 'newline$'
		
		# 
		.nameStart = rindex(.targetFile$, "/")+1
		.nameEnd = rindex(.targetFile$, ".") -.nameStart
		.newTableNameList$ = mid$(.targetFile$, .nameStart, .nameEnd)
		Create Table with column names... '.newTableNameList$' 0 Name

		# Create a list of Tables with Paths
		Create Table with column names... ListOfTables 0 Name Directory
		recursion = 0
		call createListOfTables ListOfTables '.sourceDir$'

		select Table ListOfTables
	   .numOfTables = Get number of rows
		for .i to .numOfTables
			 select Table ListOfTables
			.table$ = Get value... '.i' Name
			.tableDir$ = Get value... '.i' Directory
			# Get Table
			Read from file... '.tableDir$'/'.table$'
			.tableName$ = selected$("Table")
			if .tableName$ = "wordlist" or .tableName$ = "table"
				.nameStart = rindex(.tableDir$, "/")+1
				.nameEnd = length(.tableDir$)+1 -.nameStart
				.newTableName$ = mid$(.tableDir$, .nameStart, .nameEnd)
				select Table '.tableName$'
				Rename... '.newTableName$'
				.tableName$ = selected$("Table")
			endif

			select Table '.newTableNameList$'
			Append row
			.currentTableNum = Get number of rows
			Set string value... '.currentTableNum' Name '.tableName$'

			# Convert table
			call table2procedure '.tableName$' '.targetFile$'
			select Table '.tableName$'
			Remove
		endfor

		# Convert table
		call table2procedure '.newTableNameList$' '.targetFile$'

		select Table '.newTableNameList$'
		plus Table ListOfTables
		Remove
	else
		exit Directory not found: '.sourceDir$'
	endif
endproc

# Convert a single table to a Praat script
procedure table2procedure .tableName$ .targetFile$
	select Table '.tableName$'
	
	.space$ = " "
	# Collect information
	.numberOfColumns = Get number of columns
	.numberOfRows = Get number of rows
	
	# Set name of procedure as variable
	.tableVariableName$ = replace_regex$(.tableName$, "[^\w]", "_", 0);
	fileappend '.targetFile$' 'newline$'procCreate'.tableVariableName$'$ = "'.tableName$'"'newline$'
	
	# Start output
	fileappend '.targetFile$' procedure Create'.tableVariableName$''newline$'
	# Create table with columns
	fileappend '.targetFile$' 'tab$'Create Table with column names... '.tableName$' '.numberOfRows''newline$'
	fileappend '.targetFile$' 'tab$'...
	for .col to .numberOfColumns
		.colName$ = Get column label... '.col'
		fileappend '.targetFile$' '.space$''.colName$'
	endfor
	fileappend '.targetFile$' 'newline$'
	fileappend '.targetFile$' 'tab$'# Fill table values'newline$'

	# Fill the table
	for .row to .numberOfRows
		fileappend '.targetFile$' 'tab$'# Row '.row''newline$'
		for .col to .numberOfColumns
			.label$ = Get column label... '.col'
			.value$ = Get value... '.row' '.label$'
			fileappend '.targetFile$' 'tab$'Set string value... '.row' '.label$' '.value$''newline$'
		endfor
	endfor

	fileappend '.targetFile$' endproc'newline$'
endproc

# .listName$ is name of table to recieve all file names
# Labels are Name and Directory
# Who says you cannot do recursion in Praat?
# This is eerily fragile code.
recursion = 0
procedure createListOfTables .listName$ .topDirectory$
	recursion += 1
	.listName'recursion'$ = .listName$
	.topDirectory'recursion'$ = .topDirectory$
	# Files
	.currentTopDirectory$ = .topDirectory'recursion'$
    Create Strings as file list... Files '.currentTopDirectory$'/*.Table
	.numOfFiles'recursion' = Get number of strings
	for .i to .numOfFiles'recursion'
		select Strings Files
		.table'recursion'$ = Get string... '.i'
		
		.currentListName$ = .listName'recursion'$
		select Table '.currentListName$'
		Append row
		.numRows = Get number of rows
		.currentTable$ = .table'recursion'$
		.currentTopDirectory$ = .topDirectory'recursion'$
		Set string value... '.numRows' Name '.currentTable$'
		Set string value... '.numRows' Directory '.currentTopDirectory$'
	endfor
	select Strings Files
	Remove
	# Recurse into directories
	.currentTopDirectory$ = .topDirectory'recursion'$
    Create Strings as directory list... Directories '.currentTopDirectory$'
	.numOfDirectories'recursion' = Get number of strings
	for .i'recursion' to .numOfDirectories'recursion'
		select Strings Directories
		.currentI = .i'recursion'
		.directory'recursion'$ = Get string... '.currentI'
		.currentTopDirectory$ = .topDirectory'recursion'$
		.currentDirectory$ = .directory'recursion'$
		call createListOfTables '.listName$' '.currentTopDirectory$'/'.currentDirectory$'
	endfor
	select Strings Directories
	Remove
	recursion -= 1
endproc
