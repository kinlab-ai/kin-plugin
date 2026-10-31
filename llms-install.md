# Installing Kin in an MCP client

Kin is a hosted MCP server. There is nothing to clone, build or run locally.

1. The person needs a Kin account (free at https://kinlab.ai) with at least one account connected in Kin.
2. Add Kin as a remote MCP server that uses Streamable HTTP at `https://app.kinlab.ai/mcp`. In Cline's MCP settings that looks like:

```json
{
  "mcpServers": {
    "kin": {
      "type": "streamableHttp",
      "url": "https://app.kinlab.ai/mcp"
    }
  }
}
```

3. Connect. Kin answers with an OAuth sign-in. The person signs in to Kin in their browser and chooses what this app may use.
4. If the client cannot sign in with OAuth, the person can create a token in Kin under AI apps, with Connect an AI app and then Paste a token (advanced), and the client sends it as the header `Authorization: Bearer <token>`.

No API keys or environment variables are needed. Setup guides for each app: https://kinlab.ai/docs/ai-apps
