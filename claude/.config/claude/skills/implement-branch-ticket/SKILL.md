---
name: implement-branch-ticket
description: "When asked to implement the ticket the current branch is for, this skill looks up the ticket from the branch name and implements it."
---

When asked to implement "the ticket" or "the issue" for the current branch,
without being told which ticket explicitly:

1. Get the current branch name (`git branch --show-current`).

2. Extract a ticket identifier from the branch name, e.g. `PROJ-123` out of
   `martin/PROJ-123-fix-login` or `feature/eng-456-add-retry`. Ticket
   identifiers look like `<PROJECT-PREFIX>-<number>`, per the naming
   convention used when these worktrees/branches were created (see the
   redwood-jira and redwood-linear skills). If no identifier can be found in
   the branch name, ask the user for the ticket key/URL — don't guess.

3. Fetch the ticket's title, description, and acceptance criteria. Since a
   ticket key doesn't reveal whether it lives in Jira or Linear, try one, then
   the other:
   - Jira MCP: look up the issue by key.
   - Linear MCP: look up the issue by identifier.
   If neither system has a matching ticket, tell the user and ask.

4. Read the ticket content back to the user in a short summary (title +
   what's being asked) before writing any code, so a misread ticket gets
   caught early.

5. Treat the ticket description as the task request and follow normal
   workflow from there:
   - Think before coding: state assumptions, flag ambiguity in the ticket
     (missing details, unclear scope) and ask rather than guessing.
   - For non-trivial work, use plan mode to align on approach before editing.
   - Make surgical, minimal changes scoped to what the ticket asks for.
   - Verify the change (tests/build) before reporting done.

6. Don't transition the ticket's status or post comments/updates back to
   Jira/Linear unless the user asks — implementing the ticket doesn't imply
   authorization to modify it.
