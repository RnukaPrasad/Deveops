#!/bin/bash
git clone "https://$GITHUB_TOKEN@github.com/y-dxp/app-yib-yibsuite.git"
sed -i "s/\btag: 1.*.*\b/tag: $DOCKER_IMAGE_TAG/gI" app-yib-yibsuite/scripts/bdx_helmchart/app-bdx-assets/values.yaml
cd app-yib-yibsuite
git add .
git commit -m "$DOCKER_IMAGE_TAG - gitlab pipeline update"
git push "https://$GITHUB_TOKEN@github.com/y-dxp/app-yib-yibsuite.git" master
