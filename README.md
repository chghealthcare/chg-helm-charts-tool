# chg-helm-charts-tool

Thanks for using the CHG Services Chart.

Current owners are:
- Eli Baird
- Ryan Hansen
- Kevin Gwynn
- Derek Clifford



## Add helm repo
```BASH
helm repo add chg https://chghealthcare.github.io/chg-helm-charts-tool/
```

## Deployment TLDR
```
helm  upgrade -f ./values-${env}.yaml --install --force --wait \
--set image.tag='commit-hash' ${?FEATURE-PROJECT} \
--namespace=stage chg/service
```
## Test Deployment Template locally
```
helm  template -f ./values-${env}.yaml --dry-run \
--set image.tag='commit-hash' ${?FEATURE-PROJECT} \
--namespace=stage chg/service
```
## Requirements
Requirements for a helm deployment include the following:
- Values files must include a `project` value that contains the name of your repo/project `chg-example-service`.
- There must be a valid secret in Vault. The secret must be named to match the `project` value in your values file. EX: `dev/chg-example-service`. The current vault url is `https://vault.shared.aws.chgit.com/ui/vault/secrets`

## Deployment Values
There are two ways to put values into a deployment. One is with your `values-{env}.yaml` and the other is passing in your Jenkins or Github actions deployments `--set {variable path}=value`. The `--set` option should be reserved for dynamic variables that change from build to build.

Here is an example of minimalist values file
```yaml
environment: development
project: github-project-name
image:
  repository: 977624198390.dkr.ecr.us-west-2.amazonaws.com/demo-sa-java-service
  tag: f21a1fb893c3787474213fe2d126ebce227c25e0
  pullPolicy: IfNotPresent
```

## Overrides
Full list of values that you can add to your `values-{env}.yaml` and their defaults.

```yaml
# Default values for service.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

project: ''

replicaCount: 1


image:
  repository: # [REQUIRED]
  tag: stable # [REQUIRED]
  pullPolicy: IfNotPresent

feature: ''

nameOverride: ''
fullnameOverride: ''

# [REQUIRED]
# This is a required field
# options [development, stage, production]
environment: 'production'

# Database Type. Default to no database.
#
# options [neo4j, mysql, postgres]
databasetype: ''

# This is only needed if you want to implicitly override your ephemeral feature branch database
# This does not affect your production database type right now.
databaseimage:

# We include the option to overide the environment variable for backwards
# compatability, but please use the environment variable above.
# NODE_ENV: 'stage'

# These service fields are to map the container's service to the pod. Please note
# that this chart uses Istio so the virtual service also relies on these values.
service:
  type: IPCluster
  port: 8232
  target: 8080

# The health settings are used to determine whether your service is up and running.
health:
  liveness:
    path: '/liveness'
    initialDelaySeconds: 20
    periodSeconds: 20
  readiness:
    path: '/readiness'
    initialDelaySeconds: 30
    periodSeconds: 20

# [REQUIRED]
# Each deployment gets its own gateway that maps through the virtual service
# into the service and finally into the pod.
istiogateway:
  _default: 'dev.cs.aws.chgit.com'
  stage: 'dev.cs.aws.chgit.com'
  production: 'prod.cs.aws.chgit.com'

# The default values here are:
auth:
  _default:
    enabled: true
    issuer: 'https://chghealthcare.oktapreview.com/oauth2/auskmtjacfEi8ffM60h7'
    jwks: 'https://chghealthcare.oktapreview.com/oauth2/auskmtjacfEi8ffM60h7/v1/keys'
  stage:
    enabled: true
    issuer: 'https://chghealthcare.oktapreview.com/oauth2/auskmtjacfEi8ffM60h7'
    jwks: 'https://chghealthcare.oktapreview.com/oauth2/auskmtjacfEi8ffM60h7/v1/keys'
  production:
    enabled: true
    issuer: 'https://chghealthcare.okta.com/oauth2/aus46u1vjfkkTfP7d2p7'
    jwks: 'https://chghealthcare.okta.com/oauth2/aus46u1vjfkkTfP7d2p7/v1/keys'


envs: []
# - name: ENVIRONMENT
#   value: production
# - name: CAT
#   value: Man

# secrets -- Creates a secret for the application. All variables passed in env.
# Uses envFrom in the deployment specification to pass these all through.
secretRefs: []
# - global-one

secretKeyRefs: []
# - name: YOUR_ENV_VAR
#   secret: secret-store-name
#   key: secret-key

configMaps: []
# - some-configmap-name

configMapKeys: []
# - name: YOUR_ENV_VAR
#   keymap: config-map-name
#   key: key-from-config-map

ingress:
  enabled: false
  annotations: {}
    # kubernetes.io/ingress.class: nginx
    # kubernetes.io/tls-acme: 'true'
  hosts:
    - host:
      paths: []

  tls: []
  #  - secretName: chart-example-tls
  #    hosts:
  #      - chart-example.local
# '977624198390.dkr.ecr.us-west-2.amazonaws.com/neo4j:latest'
resources: {}
  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with minimal
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
  #   memory: 128Mi

nodeSelector: {}

tolerations: []

affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: worker-type
          operator: NotIn
          values:
          - jenkins-workers

# This value is what sets the annotation on deployed resources for auto 
# clean up in our enabled environments IE: Feature Namespace. If you need
# your service to stay up longer you can set this to your needs.
cleanUpIn: 48h
```

# Contribute
If you would like to contribute, create a PR at [the project page on GitHub](https://github.com/chghealthcare/chg-helm-charts-tool).
**NOTE:** Before a branch gets merged, you have to increment the version number in the `Chart.yaml` file for the chart you want to release.
GitHub Actions will build any time 'master' branch is pushed, and a will fail unless chart has a new version.
