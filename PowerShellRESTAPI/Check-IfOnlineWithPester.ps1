Describe "Invoke-RestMethod Responses" {
    Context "Internet Connectivity" {
        It "Google Works" {
            $online = Invoke-WebRequest -Uri "https://google.com"
            $online.StatusCode | Should Be "200"
        }
        It "Plex SSO works" {
            $Plex = Invoke-RestMethod -Uri "https://status.plex.tv/api/v2/status.json"
            $Plex.status.description | Should Be "All Systems Operational"
        }
    }
}