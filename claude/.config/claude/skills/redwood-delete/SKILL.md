---
name: redwood-delete
description: "When asked to delete or remove a git worktree (not tied to a specific Jira/Linear ticket), this skill finds it and deletes it with redwood."
---

When asked to delete a worktree, delete it with redwood:

```bash
redwood delete <path-to-worktree>
```

1. Resolve which worktree is meant. The user may give a full path, a branch
   name, a ticket key (e.g. `DEV-1234`) or a fuzzy description. Find
   candidates by running `redwood list` and, for the parent repo,
   `git -C <repo> worktree list`. If there's exactly one clear match, use it;
   if there are several (or none), show the candidates and ask. Never pick
   silently.

2. Never delete a repo's main worktree (the first entry in
   `git worktree list`, e.g. `~/src/monorepo` itself) — only linked
   worktrees.

3. Before deleting, check the worktree's state and show it to the user:
   - `git -C <worktree> status --short` (uncommitted/untracked files)
   - `git -C <worktree> log --oneline @{upstream}..HEAD` (unpushed commits;
     if there's no upstream, say so — the branch may only exist locally)

4. Confirm with the user before running `redwood delete`, naming the exact
   path. Several worktrees can be deleted in one confirmation/command by
   passing multiple paths.

5. If redwood refuses because of modified or untracked files, report that and
   only re-run with `--force` if the user explicitly agrees — it discards
   their changes.

Deleting the worktree doesn't delete its branch. Don't delete the branch
unless the user asks.
