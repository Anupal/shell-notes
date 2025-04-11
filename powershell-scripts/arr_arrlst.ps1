# arrays
$myArray = @()
$myArray.GetType()
$myArray.IsFixedSize

$nameArray = @("Anupal", "Mishra")
$nameArray.Count
Write-Host $nameArray[1]

# adding new elements
$nameArray = $nameArray + "Sakshi"
$nameArray += "Dhingra"

$nameArray

# remove all elements matching to a value
$nameArray = $nameArray -ne "Dhingra"
Write-Host $nameArray

#--------------
# this creates an Array first and then casts it to an Arraylist
$myArrayList = [System.Collections.ArrayList]@()
# this is better way
$myArrayList = New-Object -Type System.Collections.ArrayList
$myArrayList.IsFixedSize

# add elements
$myArrayList.Add("test 1")
# add void so the index at which the element is added is not displayed
[void]$myArrayList.Add("test 2")
Write-Host $myArrayList

# add multiple items as an array
$myArrayList.AddRange(@("test 3", "test 4", "test 2"))
Write-Host $myArrayList

# remove elements
$myArrayList.Remove("test 2") # only first occurence
Write-Host $myArrayList
# remove at index
$myArrayList.RemoveAt(2)
Write-Host $myArrayList

$myArrayList.RemoveRange(0, 2) # remove between range
Write-Host $myArrayList