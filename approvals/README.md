# Kin approvals for Claude Code

This plugin adds one hook to Claude Code. When Claude Code is about to ask your permission to use a tool, the hook hands the request to Kin's own permission hook on this computer, which sends it to your Kin account. You answer on your phone or in Kin, and Claude Code gets your answer.

It holds no server code. Kin's hook comes with the Kin app on a Mac, or with kin-bridge on Windows and Linux ([install Kin](https://kinlab.ai/docs/kin-apps)). The script in `scripts/kin-permission.sh` does nothing, and Claude Code asks you as usual, when neither is installed, or when Kin's hook is already in your Claude Code settings, so a request never goes to Kin twice. It downloads and installs nothing, reads no credentials, and sends nothing on its own. Claude Code's deny and ask rules still apply.

Install:

```sh
claude plugin marketplace add kinlab-ai/kin-plugin
claude plugin install kin-approvals@kin
```

Kin keeps each request in your activity log. See Kin's [privacy policy](https://kinlab.ai/privacy). Support: [support@kinlab.ai](mailto:support@kinlab.ai).
