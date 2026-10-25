#!/usr/bin/env bash
# Instala os plugins ativados em .claude/settings.json que faltam neste container,
# além das ferramentas que o plugin watch usa. Seguro de rodar várias vezes.
# Chamado pelo hook SessionStart; também pode ser rodado à mão.
set -u
cd "$(dirname "$0")/.."
SETTINGS=.claude/settings.json

command -v yt-dlp >/dev/null || uv tool install -q "yt-dlp[default,curl-cffi]"
command -v deno >/dev/null || uv tool install -q deno

command -v claude >/dev/null || exit 0
[ -f "$SETTINGS" ] || exit 0

installed=$(claude plugin list 2>/dev/null)
known=$(claude plugin marketplace list 2>/dev/null)

# Linhas "nome<TAB>origem" dos marketplaces e "plugin@marketplace" dos plugins ativados.
node -e '
const s = require(process.argv[1]);
for (const [name, m] of Object.entries(s.extraKnownMarketplaces || {})) {
  const src = m.source || {};
  console.log("M\t" + name + "\t" + (src.repo || src.url || src.path || ""));
}
for (const [id, on] of Object.entries(s.enabledPlugins || {})) if (on) console.log("P\t" + id);
' "$PWD/$SETTINGS" | while IFS=$'\t' read -r kind a b; do
  if [ "$kind" = M ]; then
    grep -qw -- "$a" <<<"$known" || claude plugin marketplace add "$b" --scope user >/dev/null 2>&1
  else
    grep -qF -- "$a" <<<"$installed" || claude plugin install "$a" --scope user >/dev/null 2>&1
  fi
done
exit 0
