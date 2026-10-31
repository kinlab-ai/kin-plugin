# Kin

Kin's MCP server is `kin`. It connects the person's accounts at other services, even two of one service, and applies the rule they set for each account and action: Allow, Ask me or Block.

Find an action with `search`, run reads with `read` and changes with `execute` (a new `requestKey` and a one-sentence `reason` for each change). An answer of `approval_required` waits for the person in Kin: share its `reviewUrl`, then make the same call with the same key to get the outcome. When `ambiguity` lists more than one account, ask the person which to use.

The `kin` and `kin-accounts` skills in this extension have the details.
