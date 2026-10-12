# Cómo se trabaja en el Ecosistema SInior

Vale para todos los repositorios de la organización, salvo que uno tenga su
propio `CONTRIBUTING.md`.

## 1. Siempre por PR

- **Nadie empuja directo a `main`.** Todo cambio entra por un pull request,
  aunque lo apruebe la misma persona que lo hizo. El PR es el registro de qué
  cambió, por qué y cómo se probó.
- En el plan actual de GitHub (Free, repos privados) esto **no se puede
  bloquear técnicamente**: es un acuerdo del equipo. Si la organización pasa a
  Team, se impone con un ruleset de organización.
- Una rama por cambio, con nombre corto y tipo: `feat/voz-en-la-consola`,
  `fix/sesion-vencida`, `docs/versionado`.

## 2. Commits convencionales

El **título del PR** sigue [Conventional Commits](https://www.conventionalcommits.org/es/),
porque al hacer *squash* se convierte en el commit de `main`, y de ahí sale el
CHANGELOG y la versión (ver [`docs/VERSIONADO.md`](./docs/VERSIONADO.md)).

```
tipo(ámbito opcional): descripción en minúscula, en presente
```

| Tipo | Cuándo | Versión |
|---|---|---|
| `feat` | Algo nuevo que la persona o el equipo puede usar | MENOR |
| `fix` | Corrige un error | PARCHE |
| `perf` | Mejora el rendimiento | PARCHE |
| `docs`, `test`, `refactor`, `style`, `build`, `ci`, `chore` | El resto | — |
| `feat!:` o `BREAKING CHANGE:` en el cuerpo | Rompe algo que otros usan (una ruta, un contrato) | MAYOR |

El idioma de los mensajes es el del repositorio (en el ecosistema, español
latinoamericano neutro, con «tú»).

## 3. El PR

- Llena la plantilla: **qué cambia, por qué, cómo se probó, qué hay que hacer
  para desplegar** (migraciones, variables de entorno, orden de merge).
- Pruebas y verificación de tipos en verde antes de pedir merge.
- Si toca seguridad, datos personales o permisos, dilo en el PR.

## 4. Merge

- **Solo *squash merge*.** Un PR = un commit en `main`, con el título del PR.
- La rama se borra sola al hacer merge.
- Después del merge, **release-please** abre o actualiza un PR de release. Se
  publica una versión cuando se hace merge de ese PR.

## 5. Secretos

Nunca en el repositorio, ni en un commit que después se borre: una vez en el
historial, la única solución real es rotar la credencial. Ver
[`docs/SEGURIDAD.md`](./docs/SEGURIDAD.md).
