---
name: pr-briefing
description: "Help me understand a PR before I review it: background on what it touches, why it exists, how behavior changes and why the author chose this approach. Input is a GitHub PR URL, a PR number, or a Linear issue. Use for \"brief me on this PR\", \"help me review PR X\", \"what is this PR about\". Does not auto-review, post comments, or approve."
---

The goal is to get me (the reviewer) up to speed so *I* can review the PR.
It is not an automated code review. Give background and context first; don't
show code until I ask for it.

## 1. Resolve the PR

- **GitHub URL:** use it directly.
- **PR number:** resolve it against the current repo (`gh pr view <n>`). If
  the current directory isn't a GitHub repo, ask which repo.
- **Linear issue** (identifier like `ENG-123` or a Linear URL): fetch the
  issue with the Linear MCP and look for linked GitHub PRs among its
  attachments. If there are none, try `gh search prs "ENG-123"`. If several PRs
  match, list them and ask which one. If none match, say so and stop.

## 2. Gather context (read only)

Read everything remotely with `gh`. Don't clone or check out anything.

- PR metadata: `gh pr view <pr> --repo <owner/repo> --json
  title,body,author,baseRefName,baseRefOid,headRefOid,files,commits,comments,reviews,closingIssuesReferences`
- Review threads: `gh api repos/<owner>/<repo>/pulls/<n>/comments`
- Diff: `gh pr diff <pr> --repo <owner/repo>`
- File contents *before* the PR:
  `gh api "repos/<owner>/<repo>/contents/<path>?ref=<baseRefOid>" -H "Accept: application/vnd.github.raw"`
  Also read surrounding files that aren't in the diff (callers, config
  consumers, READMEs) when you need them to explain how things work.
- Linked tickets: the Linear issue (if the input was one, or if one is
  referenced in the PR title/body/branch name), plus any GitHub issues it closes.
- External tools/libraries the PR touches (for example a config file for some
  CLI): look up what the tool is and what the changed settings do in its
  official docs (WebFetch/WebSearch).

If the research is broad (many unfamiliar modules or tools), hand it to an
`Explore` or `general-purpose` subagent so the raw file dumps stay out of
the main context.

## 3. Deliver one briefing, then stop

Scale the length to the PR: a one-line version bump gets a few sentences
per section, not an essay. Use these sections in this order:

1. **Summary:** one or two sentences saying what the PR does and why, so I'm
   oriented before the detail.
2. **Why this PR exists:** the problem or goal, in plain terms, taken from
   the ticket, the PR description and any discussion.
3. **Background:** for each thing the PR touches (tool, library, service,
   internal module, config file), first say what it is *in general* (for
   example "drizzle is a TypeScript ORM"), then what it's used for in this
   repo and how it fits in. Assume I don't know it, and never define a thing
   by restating its name.
4. **Before:** how things worked (or didn't) before the PR, at the level of
   behavior rather than code.
5. **After:** how behavior changes with the PR, including side effects and
   anything else that's affected.
6. **Why this approach:** the reasons behind the author's choices, and the
   alternatives they didn't take.
7. **Open questions:** behavioral and design questions only (scope,
   compatibility, rollout, product impact), ranked most important first.
   Save implementation-level concerns (null handling, error paths, specific
   code choices) for the code walkthrough.

Rules:
- **Label every claim** about intent, rationale or behavior with one of:
  - *stated*, with its source (PR body, ticket, commit message, review
    comment)
  - *verified*: you checked it yourself against the code or data (say what
    you checked)
  - *inferred*: your own reasoning or speculation

  Never present an inference as fact.
- **Prefer visuals over prose** wherever they explain something better:
  ASCII/box-drawing diagrams for architecture, data flow and call chains;
  before/after diagrams side by side for behavior changes; tables for
  comparisons (for example config options, old vs new values). The output is a
  terminal, so no Mermaid or images. Keep diagrams to 80 columns or fewer,
  and back each one with a sentence or two of text.
- No code snippets or line-by-line discussion in the briefing. At most,
  refer to files by name when it helps explain something.
- End by saying you can do a code walkthrough next, then **stop and wait**.

## 4. Code walkthrough (only when asked)

When I ask for it, give:
- a suggested order for reading the files, and what to focus on in each
- the risky spots (edge cases, error handling, backwards compatibility,
  missing tests), each tied to `file:line`
- concrete questions or comments I might want to raise

Everything is a suggestion for me to evaluate. Never post comments, request
changes, approve, or modify the PR or its ticket unless I explicitly ask.
