# Seguridad mínima en cada repositorio

## Secretos

- **Nunca en el repositorio.** Las variables van en Dokploy, en los secrets de
  Cloudflare o en los de GitHub Actions; en el repo solo `.env.example` sin
  valores.
- **gitleaks antes de cada commit** (hook de Husky), como en `sinior-consola`.
  Detiene un secreto antes de que exista en el historial.
- **GitGuardian** (GitHub App de la organización) revisa cada push y cada PR
  en todos los repositorios, también los privados. Su plan gratuito cubre
  equipos pequeños; se instala desde
  [la página de la app](https://github.com/apps/gitguardian) eligiendo la
  organización y «All repositories».
- Si un secreto llegó a un commit: **se rota primero**. Borrarlo del historial
  no sirve si ya se publicó.
- Nunca `--no-verify`.

## Dependencias

- **Alertas de Dependabot y actualizaciones de seguridad** activadas en todos
  los repositorios (las aplica `scripts/aplicar-estandares.sh`).
- Antes de agregar una dependencia, revisar que se mantenga y qué permisos o
  scripts de instalación trae.

## Código

- La sesión y los permisos se revisan **en el servidor** en cada pedido;
  esconder un botón no protege nada.
- Lo que llega del cliente no se confía: los ids de la persona salen de la
  sesión, nunca del cuerpo del pedido.
- Datos de salud y de identidad: lo mínimo necesario, y auditado.

## Configuración común de los repositorios

| Ajuste | Valor | Por qué |
|---|---|---|
| Borrar la rama al hacer merge | Sí | Sin ramas viejas confundiendo |
| Tipos de merge | Solo *squash* | Un PR = un commit en `main`, con el título del PR (alimenta el CHANGELOG) |
| Título del commit de *squash* | El título del PR | |
| Alertas de vulnerabilidades | Sí | Dependabot |
| Arreglos de seguridad automáticos | Sí | Dependabot abre el PR |
| PR obligatorio en `main` | **Acuerdo del equipo** | En GitHub Free, con repos privados, no se puede imponer. Con el plan Team se activa un ruleset de organización |

Se aplica con `scripts/aplicar-estandares.sh`.
