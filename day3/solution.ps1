$schematic = Get-Content -Path .\input.txt

# Part 1
$i = 0
$engine_part_num_sum = 0
$symbols_reg = "[^A-Za-z0-9\.]"
foreach ($line in $schematic) {
    $engine_part_details = ($line | Select-String -Pattern '(\d+)' -AllMatches | ForEach-Object { $_.Matches })
    foreach ($engine_part in $engine_part_details) {
        $engine_part_num = $engine_part.Value
        $engine_part_start_index = $engine_part.Index
        $engine_part_end_index = $engine_part.Index + $engine_part_num.Length

        if ($engine_part_start_index -gt 0) { $engine_part_start_index = $engine_part_start_index - 1  } # Account for Symbol Before
        if ($engine_part_end_index -lt $line.Length) { $engine_part_end_index += 1 } # Account for Symbol After

        $to_check = ""
        $to_check += $line.Substring($engine_part_start_index,1)
        $to_check += $line.Substring($engine_part_end_index-1,1)
        if ($i -gt 0) {
            $to_check += $schematic[$i-1].Substring($engine_part_start_index,$engine_part_end_index - $engine_part_start_index)
        }
        if ($i -lt $schematic.Length - 1) {
            $to_check += $schematic[$i+1].Substring($engine_part_start_index,$engine_part_end_index - $engine_part_start_index)
        }

        if ($to_check | Select-String -Pattern $symbols_reg -Quiet) {
            $engine_part_num_sum += $engine_part_num
        }
    }
    $i += 1
}

Write-Host "Part 1: $engine_part_num_sum"
