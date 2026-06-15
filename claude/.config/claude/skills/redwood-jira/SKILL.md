---
name: redwood-jira
description: "When asked to create, delete or list a new redwood worktree for a Jira issue, this skill will do so."
---

When asked to create a new redwood worktree for a Jira ticket, use the Jira MCP
to retrieve the ticket's title and description, and use that information to
create a new worktree(s) in the appropriate git repo(s). The command to create
a new worktree is as follows:

```bash
redwood new <path-to-repo> <worktree-name>
```

`<path-to-repo>` is the path to a local git repo. A list of all local git repos
can be retrieve by running `redwood list`.
`<worktree-name>` is the name of the worktree to be created. Always prompt for
the value of this, but the default value for these should be
`<ticket-number>-<summary>`, where `<summary>` is a summary of the Jira
ticket's title and description.

NB: A Jira ticket may need several worktrees in different repos, so prompt for
`<path-to-repo` as it was an array and repeat the command once for each entry.


Similarly, when asked to delete a redwood worktree for a Jira ticket, use the Jira MCP to retrieve the ticket's title and description, and use that information
to delete the appropriate worktree(s) in the appropriate git repo(s). The command to delete a worktree is as follows:

```bash
redwood delete <path-to-worktree>
```
