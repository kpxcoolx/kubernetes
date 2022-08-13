export NAMESPACE=argocd

for app in $(kubectl get -n argocd applications | awk '(NR>1) {print $1}')
do
  export APP_NAME=$app
  kubectl patch app $APP_NAME -n $NAMESPACE -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-succeeded.slack":"<your-channel-name>"}}}' --type merge
  kubectl patch app $APP_NAME -n $NAMESPACE -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-failed.slack":"<your-channel-name>"}}}' --type merge
  kubectl patch app $APP_NAME -n $NAMESPACE -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-sync-status-unknown.slack":"<your-channel-name>"}}}' --type merge
  kubectl patch app $APP_NAME -n $NAMESPACE -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-health-degraded.slack":"<your-channel-name>"}}}' --type merge
  kubectl patch app $APP_NAME -n $NAMESPACE -p '{"metadata": {"annotations": {"notifications.argoproj.io/subscribe.on-deployed.slack":"<your-channel-name>"}}}' --type merge
done