---
name: redwood-jira-orphan
description: "When asked to find or list redwood worktrees that do not have a corresponding Jira ticket assigned to the current user, this skill will do so."
---

When asked to find redwood worktrees without a corresponding Jira ticket assigned
to you, do the following:

1. Run `redwood list` to get all existing worktrees. Worktrees are named
   `<ticket-number>-<summary>` (e.g. `PROJ-123-fix-login`).

2. Use the Jira MCP to fetch all Jira issues currently assigned to you.

3. Compare the two lists. A worktree is considered orphaned if no Jira ticket
   assigned to you matches the ticket number prefix in the worktree name.

4. For each orphaned worktree, get the timestamp of the latest commit on its
   branch by running `git -C <path-to-worktree> log -1 --format=%ci`.

5. Report the orphaned worktrees to the user, grouped by repo if possible,
   including the latest commit timestamp for each.
