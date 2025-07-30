Import-Module -name Terminal-Icons
$THEME = "$HOME\.config\oh-my-posh\theme\velvet.omp.json"
oh-my-posh init pwsh --config $THEME| Invoke-Expression
clear
fastfetch
