<# This sciript disables first 5 AD Accounts from accounts dept.
But if the title of the AD account is CFO, it skips that account. 
#>

<#
For example, suppose you’ve retrieved a bunch of Active Directory user objects
and put them into the variable $users. You want to check their Department property,
and if it’s “Accounting,” you want to disable the account (hah, that’ll teach those bean
counters). Once you’ve done that to five accounts, though, you don’t want to do any
more (no sense in upsetting too many folks). You also don’t want to disable any account
that has a “Title” attribute of “CFO” (you’re mean, not stupid). Here’s one way to do
that (again assuming that $users is already populated):
Granted, this might not be the most efficient way to code this particular task, but it’s a
good example of how Continue and Break work. If the current user’s title is “CFO,”
Continue will skip to the end of the ForEach loop—bypassing your disabling and
everything else and continuing on with the next potential victim. Once $disabled
equals 5, you’ll just abort, exiting the ForEach loop entirely.
#>
$Users = Get-ADUser
$disabled = 0
ForEach ($user in $users) {
    If ($user.department –eq 'accounting') {
        If ($user.title –eq 'cfo') {
            Continue
        }
        $user | Disable-ADAccount
        $disabled++
    }
    If ($disabled –eq 5) {
        Break
    }
}