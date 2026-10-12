# Versionado: SemVer, CHANGELOG y Releases

Decisión del 12/10/2026, para todos los repositorios del Ecosistema SInior.

## La regla

- **SemVer** (`MAYOR.MENOR.PARCHE`), con tags `vX.Y.Z` en `main`.
  - **MAYOR**: rompe algo que otros usan (una ruta de la API, un contrato, un
    formato de datos). Mientras un proyecto esté en `0.x`, un cambio que rompe
    sube la MENOR.
  - **MENOR**: algo nuevo (`feat`).
  - **PARCHE**: una corrección (`fix`, `perf`).
- **GitHub Releases es la fuente de verdad.** La versión de un componente es su
  último Release publicado. La Consola (Ecosistema → Versiones) la lee de ahí.
- **Cada repositorio tiene su `CHANGELOG.md`**, generado: nadie lo edita a mano.

## Cómo se publica: release-please

[release-please](https://github.com/googleapis/release-please) lee los
commits convencionales de `main` (los títulos de los PR, ver
[`CONTRIBUTING.md`](../CONTRIBUTING.md)) y:

1. Después de cada merge, abre o actualiza un **PR de release**
   («chore(main): release 1.34.0») con la versión nueva y el CHANGELOG.
2. **Cuando alguien hace merge de ese PR**, crea el tag `v1.34.0` y el
   Release en GitHub, con las notas del CHANGELOG.

Así se decide **cuándo** sale una versión (al hacer merge del PR de release),
pero no **qué número** lleva ni qué dice: eso sale de los commits.

### Lo que tiene cada repositorio

| Archivo | Qué es |
|---|---|
| `.github/workflows/release.yml` | Llama al workflow reutilizable de la organización (copiado de `workflow-templates/release.yml`) |
| `release-please-config.json` | Tipo de proyecto y dónde vive la versión |
| `.release-please-manifest.json` | La versión actual. Lo actualiza release-please |
| `CHANGELOG.md` | Generado |

### Dónde vive la versión, según el proyecto

| Tipo | `release-type` | Archivos que actualiza |
|---|---|---|
| Node (API, consola, panel) | `node` | `package.json` |
| App Expo (Care+, Mi Voz Viva) | `node` + `extra-files` | `package.json` y `app.json` (`$.expo.version`) |
| Worker de Elena | `simple` + `version-file: VERSION` | `VERSION` |
| Plugin de WordPress | `simple` + `extra-files` | La cabecera `Version:` del plugin |
| Documentación | `simple` + `version-file: VERSION` | `VERSION` |

En las apps, el número de compilación de Android (`versionCode`) no lo
maneja release-please: lo incrementa EAS (`autoIncrement`).

### Secciones del CHANGELOG

`feat` → **Novedades** · `fix` → **Correcciones** · `perf` → **Rendimiento** ·
`revert` → **Reversiones**. El resto (`docs`, `chore`, `test`, `ci`…) no
aparece: no le cambia nada a quien usa el proyecto.

## Componentes y proyectos

Un **proyecto** (Care+, Mi Voz Viva, Elena, el Club) tiene uno o más
**componentes**, y cada componente es un repositorio con su propia versión:
la app, su API, su panel. El registro de qué componente pertenece a qué
proyecto está en siavi-api (`src/consola/componentes.ts`); la Consola lo
muestra con la versión y la fecha del último Release de cada uno.

## Lo que había antes

- `sinior-careplus` ya tenía un `CHANGELOG.md` escrito a mano y tags: se
  conserva como historia.
- `elena-bot` llevaba la versión en `VERSION` y su historia en `docs/log.md`:
  `docs/log.md` queda como bitácora detallada; el CHANGELOG generado es el
  resumen por versión.
- El resto tenía la versión de `package.json` sin mantener. Se partió desde
  ella con un primer Release el 12/10/2026.
