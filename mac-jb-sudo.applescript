set theHomePath to path to home folder

# ---------- variables to modify ---------- #

# a path to the folder, that contains installed version of in appropriate named subfolders (e.g. "173.4127.29", "172.4144.1459")
set theAppToLaunchPath to theHomePath & "Library:Application Support:JetBrains:Toolbox:apps:PhpStorm:ch-0" as Unicode text

# a relative path from root folder of concrete version to unix executable of application
set theRelativeExecPath to "PhpStorm.app:Contents:MacOS:phpstorm"

# --------------- main code --------------- #

tell application "Finder"
	set theVersionList to name of folders of folder theAppToLaunchPath
end tell

# converting list of strings to list of number lists
repeat with i from 1 to length of theVersionList
	set theVersionString to item i of the theVersionList
	set theVersionSplitted to splitText(theVersionString, ".")
	repeat with j from 1 to length of theVersionSplitted
		set item j of theVersionSplitted to item j of theVersionSplitted as number
	end repeat
	set item i of theVersionList to theVersionSplitted
end repeat

# sorting
set theSortedVersionList to reverse of sortVersionList(theVersionList)
set theLatestVersion to implodeList(item 1 of theSortedVersionList, ".")
set theResultingPath to POSIX path of (theAppToLaunchPath & ":" & theLatestVersion & ":" & theRelativeExecPath)

# executing
do shell script "sudo " & quoted form of theResultingPath with administrator privileges


# ---------- functions description --------- #

on splitText(theText, theDelimiter)
	set AppleScript's text item delimiters to theDelimiter
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to ""
	return theTextItems
end splitText

on implodeList(someList, delimiter)
	set prevTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delimiter
	set output to "" & someList
	set AppleScript's text item delimiters to prevTIDs
	return output
end implodeList

on sortVersionList(theList)
	set theIndexList to {}
	set theSortedList to {}
	repeat (length of theList) times
		set theLowItem to ""
		repeat with a from 1 to (length of theList)
			if a is not in theIndexList then
				set theCurrentItem to item a of theList
				if theLowItem is "" then
					set theLowItem to theCurrentItem
					set theLowItemIndex to a
				else if (item 1 of theCurrentItem < item 1 of the theLowItem) then
					set theLowItem to theCurrentItem
					set theLowItemIndex to a
				else if (item 1 of theCurrentItem is item 1 of the theLowItem and item 2 of theCurrentItem < item 2 of the theLowItem) then
					set theLowItem to theCurrentItem
					set theLowItemIndex to a
				else if (item 1 of theCurrentItem is item 1 of the theLowItem and item 2 of theCurrentItem is item 2 of the theLowItem and item 3 of theCurrentItem < item 3 of the theLowItem) then
					set theLowItem to theCurrentItem
					set theLowItemIndex to a
				end if
			end if
		end repeat
		set end of theSortedList to theLowItem
		set end of theIndexList to theLowItemIndex
	end repeat
	return theSortedList
end sortVersionList