---
name: pr-watch
description: "Watch one or more PRs from the current conversation as they move through created → approved → merged → deployed, and report each change. Use for 'watch the PR', 'tell me when it's approved / merged / deployed', 'keep an eye on PR X', or /pr-watch. It does not approve, merge or deploy anything."
---

Watch PRs through the flow **open → approved → merged → deployed** and report
each stage change. Use `gh` only; never write to GitHub.

## 1. Pick the PRs

Take the first source that gives a clear answer:

- PR URLs or numbers the user names in the request.
- PRs the conversation created or worked on: `gh pr create` output, PR URLs
  pushed to, or PRs reviewed earlier. Watch all of them if the work spans
  several (e.g. one PR per repo).
- The current branch: `gh pr view --json url`.
- A ticket key from the conversation: `gh pr list --state all --search "<KEY>" --json url,title,state`.

Store each PR as its full URL. If nothing is found, say what you looked for and
ask. If the choice is between several unrelated PRs, list them and ask which to
watch.

## 2. Start the watch

Start one Monitor (`timeout_ms`: 1800000, `description`: "PR stage changes")
running this command, with the PR URLs filled in:

```bash
# The script needs bash (it uses arrays). Run it under bash explicitly, since
# the Monitor's own shell may be zsh.
bash <<'PRWATCH'
URLS=("<url1>" "<url2>")
last=()
while :; do
  open=0
  for i in "${!URLS[@]}"; do
    url=${URLS[$i]}
    s=$(gh pr view "$url" --json state,isDraft,reviewDecision,reviews,mergeCommit 2>/dev/null) || { open=1; continue; }
    state=$(jq -r .state <<<"$s")
    if [ "$state" = CLOSED ]; then
      stage=closed
    elif [ "$state" = MERGED ]; then
      repo=$(cut -d/ -f4,5 <<<"$url"); sha=$(jq -r .mergeCommit.oid <<<"$s")
      id=$(gh api "repos/$repo/deployments?sha=$sha" --jq '.[0].id' 2>/dev/null)
      if [ -z "$id" ]; then
        stage=merged-waiting-for-deploy
      else
        d=$(gh api "repos/$repo/deployments/$id/statuses" --jq '.[0].state' 2>/dev/null)
        case $d in
          success) stage=deployed ;;
          failure|error) stage=deploy-failed ;;
          *) stage=deploying ;;
        esac
      fi
    elif [ "$(jq -r .isDraft <<<"$s")" = true ]; then
      stage=draft
    else
      rd=$(jq -r .reviewDecision <<<"$s")
      if [ "$rd" = CHANGES_REQUESTED ]; then
        stage=changes-requested
      elif [ "$rd" = APPROVED ] || jq -e 'any(.reviews[]?; .state == "APPROVED")' <<<"$s" >/dev/null; then
        stage=approved
      else
        stage=open
      fi
    fi
    case $stage in deployed|deploy-failed|closed) ;; *) open=1 ;; esac
    if [ "${last[$i]:-}" != "$stage" ]; then
      last[$i]=$stage
      echo "$(date +%H:%M:%S) $url: $stage"
    fi
  done
  [ $open = 1 ] || break
  sleep 30
done
PRWATCH
```

It checks every 30 seconds and prints a line only when a PR's stage changes.
It stops by itself once every PR is deployed, failed to deploy, or closed.

If the Monitor times out (after 30 minutes) while a PR is still open, start the
same command again. Don't schedule a separate wakeup; that would double the
reports.

## 3. Report

Each Monitor line is a report. Pass them along as they come, and say which PRs
are being watched when you start. When the watch ends, give one line per PR
with its final stage and time.

If the user says stop, stop the Monitor (TaskStop) and say which PRs were being
watched.
