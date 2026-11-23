---
name: claude-comments
description: "When asked to handle, process or pick up @claude comments (or the user runs /claude-comments), this skill finds every `@claude` marker comment in the current worktree, acts on it, and reloads the user's Neovim buffers."
---

The user leaves instructions for you as code comments containing the marker
`@claude`, in any language and comment syntax, e.g.:

```go
// @claude: extract this into a helper and add a test
```

`~/.config/claude/skills/claude-comments/nvim-worktree.sh '<cmd>'` runs an Ex
command in every Neovim instance whose cwd is inside this worktree (it prints
nothing when none is running, which is fine).

1. Save the user's open buffers so unsaved comments are included:

   ```bash
   ~/.config/claude/skills/claude-comments/nvim-worktree.sh 'silent! wall'
   ```

2. Find all markers in the worktree, including untracked files:

   ```bash
   git grep -n -I --untracked -E '@claude([^-[:alnum:]_]|$)' -- ':!*/claude-comments/*'
   ```

   Ignore hits that are not comments (e.g. string literals). If there are
   none, say so in one line and stop.

3. Read the surrounding code of each marker before acting. A marker applies
   to the code right below it (or on the same line), unless its text says
   otherwise. A multi-line comment continues the same instruction.

4. Handle each marker:
   - **Instruction** → make the change, then delete the marker comment.
   - **Question** (ends with `?` or asks why/what/how) → answer it in chat,
     then delete the marker comment.
   - **Unclear or risky** → leave the marker in place and ask about it.

   Keep all other comments and surrounding code untouched.

5. Reload the user's buffers and any open Diffview:

   ```bash
   ~/.config/claude/skills/claude-comments/nvim-worktree.sh 'checktime | redraw! | silent! DiffviewRefresh'
   ```

6. Finish with a short list: `file:line` — what you did, for each marker.
