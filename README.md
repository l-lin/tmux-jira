# tmux-jira

> Calling [jira](https://github.com/ankitpokhrel/jira-cli) issues interactively with [tmux](https://github.com/tmux/tmux).

## :package: Installation
### Install through [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```bash
set -g @plugin 'l-lin/tmux-jira'
```

Hit `prefix + I` to fetch the plugin and source it.

## :rocket: Usage

`prefix + C-j` opens `jira` in a Tmux popup.

## :wrench: Configuration

Default configuration:

```bash
set -g @tmux-jira-key-binding 'C-j'
set -g @tmux-jira-width '90%'
set -g @tmux-jira-height '90%'
```

## :page_with_curl: License

[MIT](./LICENSE)

