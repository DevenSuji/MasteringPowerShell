$Headers = @{
    Accept = "application/vnd.github.v3+json"
}

$URL = "https://api.github.com"

## Getting the gists from JMOSS
$Results = Invoke-RestMethod -Uri $URL -Headers $Headers

$Results[0].url


$ps_pulls = @{
    Headers = @{
        Accept = "application/vnd.github.v3+json"
    }
    Uri = "$URL/repos/powershell/powershell/pulls"
}

$prs = Invoke-RestMethod @ps_pulls

$prs.Count