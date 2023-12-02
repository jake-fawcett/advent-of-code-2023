$games = Get-Content -Path .\input.txt

# Part 1
$red_cubes = 12
$green_cubes = 13
$blue_cubes = 14

$sum_possible_game_ids = 0
foreach ($game in $games) {
    $game_number = ([regex]::match($game ,'Game (\d+):').Groups[1].Value)
    $cubes = ($game | Select-String -Pattern '( \d+ [red|green|blue])' -AllMatches | ForEach-Object { $_.Matches.Value })
    $possible = $true
    foreach ($cube in $cubes) {
        Switch ($cube[-1])
        {
            r {if ([int][regex]::match($cube ,'(\d+)').Groups[1].Value -gt $red_cubes) {$possible = $false; break}}
            g {if ([int][regex]::match($cube ,'(\d+)').Groups[1].Value -gt $green_cubes) {$possible = $false; break}}
            b {if ([int][regex]::match($cube ,'(\d+)').Groups[1].Value -gt $blue_cubes) {$possible = $false; break}}
        }
    }
    if ($possible) {$sum_possible_game_ids += $game_number}
}
Write-Host "Part 1: $($sum_possible_game_ids)"

# Part 2
$power_of_sets = 0
foreach ($game in $games) {
    $cubes = ($game | Select-String -Pattern '( \d+ [red|green|blue])' -AllMatches | ForEach-Object { $_.Matches.Value })
    $min_red_cubes = 0
    $min_green_cubes = 0
    $min_blue_cubes = 0
    foreach ($cube in $cubes) {
        $cube_amount = [int][regex]::match($cube ,'(\d+)').Groups[1].Value
        Switch ($cube[-1])
        {
            r {if ($cube_amount -gt $min_red_cubes) {$min_red_cubes = $cube_amount}}
            g {if ($cube_amount -gt $min_green_cubes) {$min_green_cubes = $cube_amount}}
            b {if ($cube_amount -gt $min_blue_cubes) {$min_blue_cubes = $cube_amount}}
        } 
    }
    $power_of_sets += ($min_red_cubes * $min_green_cubes * $min_blue_cubes)
}
Write-Host "Part 2: $($power_of_sets)"