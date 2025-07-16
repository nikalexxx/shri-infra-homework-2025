---
title: Release {{ env.RELEASE_NUMBER }}
labels: release
---
Date: {{ date | date('D MMM YYYY') }}
Author: {{ env.AUTHOR }}
Version: {{ env.RELEASE_NUMBER }}
Docker image: `{{ env.DOCKER_IMAGE }}`
Commits:
{{ env.COMMITS }}