#!/usr/bin/env bash

# Automatically updates Kubescape to the latest available release
#
# Assumes the following:
# - The script runs in a container with access to Kubectl, Helm an jq.
# - The container is scheduled by a CronJob.
# - The CronJob is part of a Kubescape Helm chart.
# - The CronJob does NOT get cleaned up in the cluster and might run even when
# there is no Kubescape release.
# - The release is configured to connect to the ARMO Platform.


# Check if a Kubescape release exists.
if helm status kubescape ; then
	# Updating makes sense only when Helm installed a Kubescape release
	echo "Kubescape is installed, starting update..."
else
	# If there is no Kubescape release to install, there is nothing to
	# upgrade. So exit silently to not fail the CronJob and avoid pointless
	# retries.
	echo "Kubescape Helm release not found, exiting silently."
	exit 0
fi

# Fetch latest Kubescape chart version and upgrade to it
helm repo add kubescape https://kubescape.github.io/helm-charts/
helm repo update

upgrade_command="helm upgrade kubescape kubescape/kubescape-operator -n kubescape"
eval ${upgrade_command}
