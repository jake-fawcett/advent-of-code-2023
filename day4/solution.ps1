$scratch_cards = Get-Content -Path .\input.txt

$total_score=0
foreach ($scratch_card in $scratch_cards) {
    $winning_numbers = [Collections.Generic.HashSet[int]]@()
    $scratch_card -match ": ([\d\s]+)" > $null
    foreach ($num in $matches[1].trim() -split "\s+") { $winning_numbers.add($num) > $null }

    $my_numbers = [Collections.Generic.HashSet[int]]@()
    $scratch_card -match "\| ([\d\s]+)" > $null
    foreach ($num in $matches[1].trim() -split "\s+") { $my_numbers.add($num) > $null }

    $my_numbers.IntersectWith($winning_numbers)
    $match_count = $my_numbers.count
    if ($match_count -eq 0) {$total_score += 0} else {$total_score += [Math]::Pow(2, $match_count - 1)}
}

Write-Host "Part 1: $total_score"

$i = 0
$card_frequency = @{}
foreach ($scratch_card in $scratch_cards[$i..$scratch_cards.length]) {
    $card_frequency[$i] += 1

    $winning_numbers = [Collections.Generic.HashSet[int]]@()
    $scratch_card -match ": ([\d\s]+)" > $null
    foreach ($num in $matches[1].trim() -split "\s+") { $winning_numbers.add($num) > $null }

    $my_numbers = [Collections.Generic.HashSet[int]]@()
    $scratch_card -match "\| ([\d\s]+)" > $null
    foreach ($num in $matches[1].trim() -split "\s+") { $my_numbers.add($num) > $null }

    $my_numbers.IntersectWith($winning_numbers)

    for ($j = 1; $j -lt $my_numbers.count + 1; $j++) {
        $card_frequency[$i+$j] += (1 * $card_frequency[$i])
    }
    $i += 1
}

Write-Host "Part 2: $(($card_frequency.Values | Measure-Object -Sum).Sum)"