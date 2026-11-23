---
name: redwood-delete-current
description: "When asked to delete or close the current redwood worktree (the one this Claude session is running in), this skill deletes it with redwood, which also kills its tmux session and ends this session."
---

Delete the worktree this session is running in. `redwood delete` also kills
the worktree's tmux session, and that kills this Claude session too, so the
delete must be the last thing you do and must run outside this session.

1. Find the worktree from the session's working directory:
   - `git rev-parse --show-toplevel` gives the worktree path.
   - It must be a linked worktree, not a repo's main worktree: compare
     `git rev-parse --git-dir` with `git rev-parse --git-common-dir`. If
     they're the same, this is a main checkout. Stop and say so.

2. Check what would be lost:
   - `git status --short` (uncommitted/untracked files)
   - `git log --oneline @{upstream}..HEAD` (unpushed commits; if there's no
     upstream, say the branch may only exist locally)

   Deleting the worktree keeps its branch, so unpushed commits survive.
   Uncommitted changes do not survive, and redwood refuses to delete without
   `--force` if there are any.

3. If the worktree is clean, go straight to step 4. If it has uncommitted or
   untracked files, list them and ask whether to discard them. Add `--force`
   only if the user agrees. Otherwise stop.

4. Before deleting, write one short line naming the worktree path and saying
   this session is about to end. Then hand the delete to the tmux server so
   it keeps running after this session's tmux session is killed:

   ```bash
   tmux run-shell -b "cd ~ && redwood delete [--force] '<worktree-path>'"
   ```

   Don't run `redwood delete` directly from this shell, because it would be
   killed along with the session. Don't run anything after this command.

Don't delete the branch unless the user asks.
