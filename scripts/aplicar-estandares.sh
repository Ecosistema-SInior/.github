#!/usr/bin/env bash
# Aplica la configuración común (docs/SEGURIDAD.md) a todos los repositorios
# no archivados de la organización. Sin argumentos solo muestra lo que haría.
#
#   bash scripts/aplicar-estandares.sh            # ver
#   bash scripts/aplicar-estandares.sh --aplicar  # aplicar
#
# Requiere `gh` con una cuenta administradora de los repositorios.
set -euo pipefail
ORG="Ecosistema-SInior"
APLICAR=false
[ "${1:-}" = "--aplicar" ] && APLICAR=true

repos=$(gh repo list "$ORG" --limit 200 --no-archived --json name -q '.[].name' | sort)

for r in $repos; do
  actual=$(gh api "repos/$ORG/$r" -q '"borrar-rama=\(.delete_branch_on_merge) squash=\(.allow_squash_merge) merge=\(.allow_merge_commit) rebase=\(.allow_rebase_merge) titulo=\(.squash_merge_commit_title)"')
  echo "· $r — $actual"
  $APLICAR || continue

  # Un PR = un commit en main, con el título del PR (alimenta el CHANGELOG).
  gh api -X PATCH "repos/$ORG/$r" \
    -F delete_branch_on_merge=true \
    -F allow_squash_merge=true -F allow_merge_commit=false -F allow_rebase_merge=false \
    -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY \
    -F allow_auto_merge=true >/dev/null

  # Dependabot: alertas y PR de arreglos de seguridad.
  gh api -X PUT "repos/$ORG/$r/vulnerability-alerts" >/dev/null
  gh api -X PUT "repos/$ORG/$r/automated-security-fixes" >/dev/null

  # release-please abre PR con GITHUB_TOKEN: las Actions tienen que poder crear PR.
  gh api -X PUT "repos/$ORG/$r/actions/permissions/workflow" \
    -f default_workflow_permissions=read -F can_approve_pull_request_reviews=true >/dev/null \
    || echo "  ⚠ no pude permitir que Actions cree PR (¿lo bloquea la organización?)"

  echo "  ✓ aplicado"
done
