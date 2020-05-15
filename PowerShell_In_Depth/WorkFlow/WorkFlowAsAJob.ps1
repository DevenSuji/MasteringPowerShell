workflow Test-MyWorkflow {
    get-service -name w*
    start-sleep -seconds 30
    get-process -name powershell*
}

Test-MyWorkflow -AsJob


Suspend-Job 9