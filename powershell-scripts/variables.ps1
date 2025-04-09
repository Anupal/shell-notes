$variable="Some string"
# prints the variable
$variable

# other types
$varInt=12
# $varInt.GetType()

# conditionals are computed using special flags
($varInt -eq 12)

# explictly assign type
[double]$doubleVar=1.1
$doubleVar

# save date in a variable
$date=Get-Date
$date