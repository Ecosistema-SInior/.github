# Ecosistema SInior — estándares de la organización

Este repositorio es **público a propósito**: GitHub solo hereda los archivos
por defecto de la organización (seguridad, cómo contribuir, plantillas de PR y
de issues) desde un `.github` público. Aquí no hay código de los proyectos ni
secretos; esos repositorios siguen privados.

| Archivo | Para qué |
|---|---|
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | Cómo se trabaja en cualquier repo: ramas, commits, PR, merge |
| [`docs/VERSIONADO.md`](./docs/VERSIONADO.md) | SemVer, CHANGELOG y Releases con release-please |
| [`SECURITY.md`](./SECURITY.md) | Cómo reportar un problema de seguridad |
| [`docs/SEGURIDAD.md`](./docs/SEGURIDAD.md) | Lo mínimo de seguridad en cada repo: secretos, dependencias, escaneo |
| [`PULL_REQUEST_TEMPLATE.md`](./PULL_REQUEST_TEMPLATE.md) | La plantilla de todos los PR |
| [`ISSUE_TEMPLATE/`](./ISSUE_TEMPLATE) | Plantillas de issues |
| [`.github/workflows/release-please.yml`](./.github/workflows/release-please.yml) | Workflow reutilizable de releases |
| [`workflow-templates/`](./workflow-templates) | El workflow que cada repo copia para usarlo |
| [`scripts/aplicar-estandares.sh`](./scripts/aplicar-estandares.sh) | Aplica la configuración común a todos los repos |

Un archivo propio en un repositorio (por ejemplo, su `CONTRIBUTING.md`)
**reemplaza** al de aquí para ese repositorio.
