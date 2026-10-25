# CLAUDE.md

Este arquivo é a memória do projeto: toda sessão do Claude Code neste repositório o lê ao começar.
Mantenha-o curto e atualizado. Quando algo importante for decidido ou aprendido, registre em "Notas".

## Sobre o repositório

- Repositório: `flaviodubiel/projects`. Branch padrão: `main`.
- Por enquanto guarda só a configuração do Claude Code (`.claude/settings.json`).
- As sessões costumam rodar na nuvem, em containers apagados no fim de cada sessão.
  O que não for commitado e enviado ao GitHub se perde.
- O usuário fala português: responda em português.

## Plugins ativos (`.claude/settings.json`)

| Plugin | Marketplace | Para que serve |
| --- | --- | --- |
| `ecc@ecc` | `https://github.com/affaan-m/ECC.git` | Agentes, skills, hooks e fluxos de trabalho (TDD, revisão de código, segurança) |
| `chrome-devtools-mcp@claude-plugins-official` | `anthropics/claude-plugins-official` | Controlar e inspecionar o Chrome (performance, rede, console, acessibilidade) |
| `claude-mem@thedotmack` | `thedotmack/claude-mem` | Memória entre sessões, guardada localmente no container |
| `superpowers@claude-plugins-official` | `anthropics/claude-plugins-official` | Brainstorming, planos, TDD, depuração sistemática e revisão de código |

- `/plugin` não funciona nas sessões na nuvem. Use a linha de comando:
  `claude plugin marketplace add <origem> --scope project` e `claude plugin install <plugin>@<marketplace> --scope project`.
  Depois, commite `.claude/settings.json` e envie para `main`.
- ECC: perfil de hooks `minimal`, definido por `ECC_HOOK_PROFILE` no bloco `env` de `.claude/settings.json`.
  Ele desliga o GateGuard e mantém os hooks essenciais e de segurança.
  (As opções do plugin, `hook_profile` e `hooks_enabled`, só podem ser salvas em `~/.claude`, que se perde com o container.)
- `claude-mem`: a memória fica em `~/.claude-mem/`, dentro do container, e se perde ao fim da sessão.
  A sincronização na nuvem (skill `cloud-sync`) exige conta paga cmem.ai Pro e não está configurada.

## Notas

Registre aqui decisões, preferências e o que for aprendido, com a data.

- 2026-10-25: plugins ECC, `chrome-devtools-mcp` e `claude-mem` instalados; branch padrão passou a ser `main`.
