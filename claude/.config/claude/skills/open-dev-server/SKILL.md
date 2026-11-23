---
name: open-dev-server
description: "When asked to open the dev server host in the browser, this skill finds the host (https://<name>-runner.p.dbt.se) that runs the branch this conversation is about and opens its hub URL. It does not create hosts."
---

Open the hub URL of the dev server host for the branch this conversation is
about. Hosts run one pushed branch each, at `https://<name>-runner.p.dbt.se`
(hub) and `https://<name>-runner-api.p.dbt.se` (api). Open the hub unless
the user asks for the api.

1. Work out the host, in this order, and stop at the first clear answer:
   - A host URL or name the user gives, or one that appeared earlier in the
     conversation (e.g. printed by `repo dev-server-host create`).
   - The host whose branch is the branch this session works on
     (`git branch --show-current`, or a branch named in the conversation).
     List each host's branch, hub URL and status from the monorepo clone,
     under `direnv exec .` so AWS gets the clone's region and profile:

     ```bash
     direnv exec . aws cloudformation describe-stacks --query "Stacks[?Tags[?Key=='dbt:role' && Value=='dev-server-host']].[Parameters[?ParameterKey=='Branch'].ParameterValue|[0], Outputs[?OutputKey=='HubUrl'].OutputValue|[0], StackStatus]" --output text
     ```

     Don't build the URL from the branch name yourself: the host's name
     often differs from its branch (branch `p-dev-234-host` has the host
     `p-dev-234`).

2. If there's exactly one match, open it with `open <url>` and reply with
   one line giving the URL. If several hosts match, list them and ask
   which one. If none does, say which branch you looked for, list the
   running hosts, and stop. Don't create a host.

If the stack's status is not `CREATE_COMPLETE`, say so along with the URL,
because the host may still be booting or be on its way down.
