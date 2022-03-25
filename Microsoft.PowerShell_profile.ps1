# PowerShell parameter completion shim for the Makefile
Register-ArgumentCompleter -Native -CommandName make -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        Select-String -Path .\Makefile '^([a-zA-Z\-]+):' -AllMatches | Foreach-Object {
          $_.Matches
        } | Foreach-Object {
          $word = $_.Groups[1].Value 
          if ($commandName.Trim().Length -gt 0 -And -Not $word.StartsWith($commandName.Trim())) {
             return;
          }
          [System.Management.Automation.CompletionResult]::new($word, $word, 'ParameterValue', $word)
        }
}
