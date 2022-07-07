# Send job state to pr 
This action publish commit statuses for a given SHA. Note: there is a limit of 1000 statuses per sha and context within a repository. Attempts to create more than 1000 statuses will result in a validation error.

## Inputs

## `state`

**Required** The state of the status. Can be one of: `error`, `failure`, `pending`, `success`. Default `success`.

## `target_url`

**Not Required** The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.
For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:
http://ci.example.com/user/repo/build/sha

## `description`

**Not Required** A short description of the status

## `context`

**Not Required** A string label to differentiate this status from the status of other systems. This field is case-insensitive. Default `default`.

## `repository`

**Required** The account owner and the repository. The name is not case sensitive. e.g. octocat/Hello-World

## `github_token`

**Required** The github token for authorization

## Example usage

Create a workflow (eg: `.github/workflows/example.yml`):

```yaml
name: Example

on:
  push:
    branches:
      - main

jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: some action
        run: echo "Hello World"

      - name: Send status to PR
        uses: jbuettnerbild/send-job-status-to-pr-action@v1
        with:
          state: "${{ job.status }}"
          target_url: "https://github.com/${{ github.repository }}/actions/runs/${{ github.run_id }}"
          description: "The build result is: ${{ job.status }}"
          context: "continuous-integration/jenkins"
          repository: "${{ github.repository }}"
          github_token: "${{ secrets.GITHUB_TOKEN }}"
          sha: "${{ github.sha }}"
```