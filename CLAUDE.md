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
| `watch@claude-video` | `bradautomates/claude-video` | Assistir vídeos (URL ou arquivo): baixa com yt-dlp, extrai quadros com ffmpeg e transcreve |
| `claude-code-setup@claude-plugins-official` | `anthropics/claude-plugins-official` | Analisa o projeto e recomenda hooks, skills, subagentes e MCPs |
| `headroom@headroom-marketplace` | `headroomlabs-ai/headroom` | Compressão de contexto via proxy local; inativo nas sessões na nuvem (ver abaixo) |
| `task-observer@one-skill-to-rule-them-all` | `rebelytics/one-skill-to-rule-them-all` | Observa as sessões e propõe melhorias de skills (log em `skill-observations/`) |

- `/plugin` não funciona nas sessões na nuvem. Use a linha de comando:
  `claude plugin marketplace add <origem> --scope project` e `claude plugin install <plugin>@<marketplace> --scope project`.
  Depois, commite `.claude/settings.json` e envie para `main`.
- Num container novo, nenhum plugin vem instalado. O hook `SessionStart` roda `scripts/install-plugins.sh`,
  que instala os plugins ativados que faltam (uns 30 s na primeira vez) e o `yt-dlp`/`deno` do `watch`.
  Se algum plugin não aparecer, rode `bash scripts/install-plugins.sh` e reinicie a sessão.
- ECC: perfil de hooks `minimal`, definido por `ECC_HOOK_PROFILE` no bloco `env` de `.claude/settings.json`.
  Ele desliga o GateGuard e mantém os hooks essenciais e de segurança.
  (As opções do plugin, `hook_profile` e `hooks_enabled`, só podem ser salvas em `~/.claude`, que se perde com o container.)
- `claude-mem`: a memória fica em `~/.claude-mem/`, dentro do container, e se perde ao fim da sessão.
  A sincronização na nuvem (skill `cloud-sync`) exige conta paga cmem.ai Pro e não está configurada.

- `watch`: modo Gemini. Lê `GEMINI_API_KEY` das variáveis de ambiente da nuvem (nunca no repositório).
  **Para assistir a vídeos, sempre invoque a skill `watch:watch`.** Não rode `yt-dlp` direto: o YouTube é
  bloqueado pela rede do container, mas no modo Gemini o plugin manda o link do YouTube direto ao Google,
  sem baixar. Só use o vidIQ (gasta créditos) se o usuário pedir ou se o `watch` falhar.
- `headroom`: só tem efeito em processos `claude` iniciados com `ANTHROPIC_BASE_URL` apontando para o proxy.
  Na nuvem o provedor é controlado pelo host: o `env` do `settings.json` não redireciona a sessão principal
  (testado em 2026-10-25), então o plugin fica inativo aqui. Se usar o proxy, rode com `HEADROOM_BEACON=off`.

## Notas

Registre aqui decisões, preferências e o que for aprendido, com a data.

- 2026-10-25: OmniRoute não é plugin (é um gateway separado que redireciona o Claude Code para outros provedores); não foi instalado na nuvem.
- 2026-10-25: plugins ECC, `chrome-devtools-mcp` e `claude-mem` instalados; branch padrão passou a ser `main`.
