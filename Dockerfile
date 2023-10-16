FROM dtzar/helm-kubectl as base

COPY entrypoint.sh /kubescape-updater/entrypoint.sh

ENTRYPOINT ["/kubescape-updater/entrypoint.sh"]
