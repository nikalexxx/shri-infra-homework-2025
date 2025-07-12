# Релиз ${{ env.RELEASE_VERSION }}

**Дата релиза:** ${{ steps.date.outputs.date }}
**Автор релиза:** ${{ github.actor }}
**Версия:** ${{ env.RELEASE_VERSION }}

## Список изменений (коммиты с предыдущего релиза)

${{ steps.commits.outputs.commits }}

## Docker-образ

cr.yandex/<ID_реестра>/app:${{ env.RELEASE_VERSION }}

---

_Этот Issue создан автоматически workflow релиза._
