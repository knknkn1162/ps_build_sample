param(
	[string]$Directory
)

$OUTPUT_DIR="{0}/out" -f $pwd
$TMP_CSV="{0}/out.csv" -f $OUTPUT_DIR
$LOG_PATH="{0}/out.log" -f $OUTPUT_DIR

task clean -If {Test-Path $OUTPUT_DIR} {
  Remove-Item -Recurse -Force ${OUTPUT_DIR}
}

task setup -If {-not (Test-Path $OUTPUT_DIR)} {
  New-Item $OUTPUT_DIR -ItemType Directory
}

task export -If {-not ($Directory -eq "")} -Outputs $TMP_CSV setup, {
  Get-ChildItem $Directory -Recurse -File |
    select Name, Size, LastWriteTime, {[int]($_.Name | sls "\d{1,}").Matches[0].Value} |
    export-csv -noheader $TMP_CSV
}

task import -Inputs $TMP_CSV -Outputs $LOG_PATH {
  import-csv -header @("file", "size", "time", "index") $TMP_CSV | %{"{1} -> {0}" -f $_.size, $_.index} | tee $LOG_PATH
}

task . setup, export, import

# # Synopsis: Boils a pot of water.
# task boil_water {
# 	'boiling water'
# 	$Script:Pot = @{}
# }

# # Synopsis: Adds tea bags.
# task add_tea boil_water, {
# 	'adding tea'
# 	$Script:Pot.tea = $TeaBags
# }

# # Synopsis: Adds sugar lumps.
# # task add_sugar -If { $SugarLumps -ge 1 } -Jobs boil_water, {
# task add_sugar boil_water, {
# 	'adding sugar'
# 	$Script:Pot.sugar = $SugarLumps
# }

# task . boil_water, add_tea, add_sugar