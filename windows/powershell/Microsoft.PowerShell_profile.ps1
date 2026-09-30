# ==================================================
# @file $PROFILE.CurrentUserCurrentHost
# @brief PowerShell appearance settings
# ==================================================


# --------------------------------------------------
# Administrator
# --------------------------------------------------

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]$identity
$isAdmin = $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)

if ($isAdmin) {
    return
}


# --------------------------------------------------
# Appearance
# --------------------------------------------------

# Oh My Posh
$ompConfig = "$HOME\.config\oh-my-posh\theme.yaml"

if (
    (Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and
    (Test-Path -LiteralPath $ompConfig -PathType Leaf)
) {
    oh-my-posh init pwsh --config $ompConfig | Invoke-Expression
}
