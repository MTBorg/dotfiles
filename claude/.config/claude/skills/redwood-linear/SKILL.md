---
name: redwood-linear
description: "When asked to create or delete a new redwood worktree for a Linear issue, this skill will do so."
---

When asked to create a new redwood worktree for a Linear issue, retrieve the
issue's identifier, title and description (using whatever Linear tooling is
already available in this repo), and use that information to create a new
worktree in the `~/src/monorepo` git repo. The command to create a new
worktree is as follows:

```bash
redwood new ~/src/monorepo <worktree-name>
```

Always use `~/src/monorepo` as the repo; do not prompt for it.
`<worktree-name>` is the name of the worktree to be created. Always prompt for
the value of this, but the default value for these should be
`<issue-identifier>-<summary>`, where `<issue-identifier>` is the Linear
issue's identifier (e.g. `ENG-123`) and `<summary>` is a summary of the Linear
issue's title and description.

If the ticket is unassigned, prompt if you should assign the ticket to me.

Similarly, when asked to delete a redwood worktree for a Linear issue,
retrieve the issue's identifier, title and description, and use that
information to delete the appropriate worktree in the `~/src/monorepo` git
repo. The command to delete a worktree is as follows:

```bash
redwood delete <path-to-worktree>
```
