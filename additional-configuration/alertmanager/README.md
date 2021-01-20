# OpenShift 4: Prometheus AlertManager with Microsoft Teams Configuration

## Purpose:

The purpose of this document is to deploy and configure components to allow alerts from Prometheus Alertmanager to be received in Microsoft Teams.

## Audience:
 Cluster Administrators looking to add Microsoft Teams integration to their OCP 4 monitoring stack.

## Steps:

1. Make sure monitoring is deployed
2. Deploy prometheus-msteams: [github repo](https://github.com/prometheus-msteams/prometheus-msteams)  [quay.io](https://quay.io/repository/prometheusmsteams/prometheus-msteams?tab=tags)
  - Create a new project to deploy to.
  - Create the configmap used to set the connectors and paths. `msteams-config.yaml` can be used as a template.  (How to create a webhook [here](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook#add-an-incoming-webhook-to-a-teams-channel))
  - Deploy prometheus-msteams (`oc create -f prometheus-msteams-template.yaml`)

  - Test the routes
    - Create the json file and test your routes using the following steps [here](https://github.com/prometheus-msteams/prometheus-msteams#simulating-a-prometheus-alerts-to-teams-channel)
    - The URL you will curl is <route>/hook_path>. If successful you should see an example alert appear in your Microsoft Teams channel where you have generated the webhook from.

3. Set receivers in Alertmanager
  - Administration - cluster settings - global config - alertmanager - edit or create receivers
  - Edit existing receivers (Default, Critical, Watchdog) with the routes you see fit.
  - Create new receivers with new matchers if necessary.

4. For dev monitoring
  - To enable developer monitoring, follow the steps outlined [here](https://docs.openshift.com/container-platform/4.5/monitoring/monitoring-your-own-services.html#enabling-monitoring-of-your-own-services_monitoring-your-own-services)
  - Add a new connector to the configmap for prometheus-msteams with the webhook provided by the developer team.
  - Add a new receiver in Alertmanager with a matcher corresponding to the teams alerts.

5. Once you have created the receivers and alerts you should now see them appear into your Microsoft Teams channels.
