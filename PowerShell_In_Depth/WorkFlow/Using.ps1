Workflow DemoNotUsing {
    Param([string]$log = "System", [int]$newest = 10)
    #creating a variable within the workflow
    $source = "Service Control Manager"
    Write-verbose -message "Log parameter is $log"
    Write-Verbose -message "Source is $source"
    InlineScript {
        <#
    What happens when we try to access
    out of scope variables?
    #>
        "Getting newest {0} logs from {1} on {2}" -f $newest, $log, $pscomputername
        get-eventlog -LogName $log -Newest $newest -Source $source
    } #inlinescript
    Write-verbose -message "Ending workflow"
} #close workflow

DemoNotUsing

##########################################################################################

Workflow DemoUsing {
    Param([string]$log = "System", [int]$newest = 10)
    #creating a variable within the workflow
    $source = "Service Control Manager"
    Write-verbose -message "Log parameter is $log"
    Write-Verbose -message "Source is $source"
    InlineScript {
        <#
    this is the way to access out of scope variables.
    #>
        "Getting newest {0} logs from {1} on {2}" -f $using:newest, $using:log,
        $pscomputername
        get-eventlog -LogName $using:log -Newest $using:newest `
            -Source $using:source
    } #inlinescript
} #close workflow

DemoUsing