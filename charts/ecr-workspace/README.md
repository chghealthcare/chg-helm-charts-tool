# Terraform ECR Workspace 

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 1.0.3](https://img.shields.io/badge/AppVersion-1.0.3-informational?style=flat-square)

Child Chart for Creating ECR Repositories using the Terraform Operator

## Source Code

* <https://github.com/chghealthcare/chg-sre-core-helm/charts/terraform-workspace>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://chartmuseum.shared.aws.chgit.com | ecr-workspace(terraform-workspace) | 1.0.3 |

## Usage

### Create a values-ecr.yaml override file with the below options

```yaml
ecr-workspace:
  workspace:
    name: my-demo-service # (this must meet the k8s resource name standard)
    config:
      version: v1  # this must meet the k8s resource name standard i.e v1 or v-1
      # ECR Config Settings example
      repos:
      - name: demo-service
        # Optional options
        maxImageCount: 10
        scanImagesOnPush: false
        tags:
        - key: pxt
          value: gear
```
## Add helm repo
```BASH
helm repo add chg https://chghealthcare.github.io/chg-helm-charts-tool/
```

## Deployment TLDR
```
helm  upgrade -f ./values-ecr.yaml --install chg/ecr-workspace --namespace=tf-operator
```
## Test Deployment Template locally
```
helm  template -f ./values-ecr.yaml chg/ecr-workspace
```

