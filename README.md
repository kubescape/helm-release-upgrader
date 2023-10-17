# Helm Release Updater

Helm Release Updater updates the Kubescape Helm release that runs in a cluster to spare you the effort of doing it yourself.
It’s supposed to be a temporary workaround (pinky promise).

The Updater is intended to run as a part of the main Kubescape Helm chart.
Based on this, it makes some strong assumptions and doesn’t support use cases other than the original one.
See `entrypoint.sh` for details on the assumptions it makes and how it operates.

This repo contains only the Dockerfile used to build the Updater image.
The templates that deploy the Updater are in the main Kubescape [Helm chart repository](https://github.com/kubescape/helm-charts/).
