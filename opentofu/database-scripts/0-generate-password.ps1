# Define the character sets
$Lower = "abcdefghijklmnopqrstuvwxyz"
$Upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$Numeric = "0123456789"
$Special = "!@#$%^&*()_+=-`~[]\{}|;':"",./<>?"

# Set the desired password length
$Length = 20

# Combine the character sets (you can adjust these)
$Chars = $Lower + $Upper + $Numeric + $Special

# Generate the random password
$Password = ""
for ($i = 0; $i -lt $Length; $i++) {
  $Password += $Chars[(Get-Random -Minimum 0 -Maximum $Chars.Length)]
}

# Output the password
Write-Host "Generated Password: $Password"