$lines = Get-Content -Path .\input.txt

# Part 1
$sum_calibration_value = 0
foreach ($line in $lines) {
    $line_digits = $line -replace "\D+"
    $calibration_value = ($line_digits[0] + $line_digits[-1])
    $sum_calibration_value += [int]$calibration_value
}
Write-Output "Part 1: $($sum_calibration_value)"

# Part 2
$sum_calibration_value = 0
$num_match_regex = "[0-9]|one|two|three|four|five|six|seven|eight|nine"
$lookahead_num_match_regex = "(?=[0-9]|one|two|three|four|five|six|seven|eight|nine)"

foreach ($line in $lines) {
    $numbers_in_line = ""
    # TODO: Better way of detecting overlaps without lookahead / having to match again to get values?
    $line_matches = ($line | Select-String -Pattern $lookahead_num_match_regex -AllMatches | ForEach-Object { $_.Matches.Index })
    foreach ($line_match in $line_matches) {
        # TODO: Investigate why this doesn't return match value -AllMatches and Iterating the Object
        $numbers_in_line += ($line.Substring($line_match) | Select-String -Pattern $num_match_regex -AllMatches | ForEach-Object { $_.Matches.Value.replace('one',1).replace('two',2).replace('three',3).replace('four',4).replace('five',5).replace('six',6).replace('seven',7).replace('eight',8).replace('nine',9)})[0]
    }
    $calibration_value = ($numbers_in_line[0] + $numbers_in_line[-1])
    $sum_calibration_value += $calibration_value
}
Write-Output "Part 2: $($sum_calibration_value)"