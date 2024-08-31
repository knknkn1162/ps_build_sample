```pwsh
Install-Module Invoke-Build
```

```pwsh
Invoke-Build -Directory ../resources/
Invoke-Build clean
```

## dev

```
Name           : clean
Error          : 
Started        : 
Elapsed        : 
Jobs           : {
                   Remove-Item -Recurse -Force ${OUTPUT_DIR}
                 }
After          : 
Before         : 
If             : (Test-Path $OUTPUT_DIR)
Inputs         : 
Outputs        : 
Data           : 
Done           : 
Partial        : False
InvocationInfo : System.Management.Automation.InvocationInfo
```