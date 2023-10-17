FROM dtzar/helm-kubectl as base

# Configure the application user variables
ENV USER=kubescape-updater
ENV UID=1000
ENV GROUP=kubescape-updater
ENV GID=1000
ENV HOMEDIR=/home/kubescape-updater

# Configure Helm directories
ENV HELM_CACHE_HOME=/home/kubescape-updater/helm/.cache
ENV HELM_CONFIG_HOME=/home/kubescape-updater/helm/.config
ENV HELM_DATA_HOME=/home/kubescape-updater/helm/.data

# Create the updater user
RUN addgroup \
    --gid "$GID" \
    $GROUP \
    && adduser \
        --disabled-password \
        --gecos "" \
        --home "$HOMEDIR" \
        --ingroup "$GROUP" \
        --uid "$UID" \
        "$USER"

USER $USER
WORKDIR $HOMEDIR

COPY entrypoint.sh $HOMEDIR/entrypoint.sh

ENTRYPOINT ["/home/kubescape-updater/entrypoint.sh"]
