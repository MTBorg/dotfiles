---
name: open-pr
description: "When asked to open, show or pull up a pull request in the browser, this skill works out which existing PR the conversation is about and opens it with gh. It does not create PRs."
---

Open the existing PR the conversation is about in the browser:

```bash
gh pr view <number-or-url> --repo <owner/repo> --web
```

1. Work out which PR is meant, in this order, and stop at the first that
   gives a clear answer:
   - A PR the user names in their request (URL, `#123`, branch, title).
   - A PR URL or number that appeared earlier in the conversation (e.g. one
     you created, reviewed or pushed to). Prefer the most recent one that
     the conversation was actually working on.
   - A branch or worktree the conversation was working in:
     `gh pr view <branch> --json number,url,title,state` run from that repo
     (for the current branch, just `gh pr view --json ...`).
   - A ticket key from the conversation (e.g. `DEV-1234`):
     `gh pr list --state all --search "DEV-1234" --json number,url,title,state`.

2. If the PR lives in another repo than the current directory, pass
   `--repo <owner/repo>` (or run gh with `-C`/from that repo's directory).

3. If there's exactly one clear match, open it right away — no need to
   confirm. If there are several candidates, list them (number, title,
   state) and ask which one. If none is found, say what you looked for
   and ask; don't guess.

4. After opening, reply with one line: the PR number, title and URL.
