## Installation Guide for ArgoCD
Install argocd.yaml changing the values for the ingress section 

```apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: argocd
  namespace: argocd
  labels:
    app: alb-public-argocd-service
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/group.name: argocd
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/tags:  Cluster=<name>,Environment=<name>,Created-by=k8s,Name=alb-ingress-public
    alb.ingress.kubernetes.io/subnets: <public subnet groups>
    alb.ingress.kubernetes.io/security-groups: <http/https sg and default sg>
    alb.ingress.kubernetes.io/certificate-arn: 	<acm arn>
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS": 443}]'
    alb.ingress.kubernetes.io/success-codes: "200"
    # Use kube-proxy health check
    alb.ingress.kubernetes.io/healthcheck-path: /healthz
    alb.ingress.kubernetes.io/healthcheck-port: "10256"
    alb.ingress.kubernetes.io/actions.app-redirect: '{"Type": "redirect", "RedirectConfig": { "Host":"<hostnameURL>", "Protocol": "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}'
    alb.ingress.kubernetes.io/actions.response-503: >
      {"Type":"fixed-response","FixedResponseConfig":{"ContentType":"text/plain","StatusCode":"503","Access Denied":"503 error text"}}
spec:
  rules:
    - host: <hostnameURL>
      http:
        paths:
        - backend:
            serviceName: argocd-server
            servicePort: 80
```

Install all other yaml files for ArgoCD to Slack notification following steps here https://rinseodam.medium.com/notification-argocd-to-slack-292ce01d203b and here https://argocd-notifications.readthedocs.io/en/stable/services/slack/
