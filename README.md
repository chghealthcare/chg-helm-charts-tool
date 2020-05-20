# chg-helm-charts-tool

Thanks for using the CHG Services Chart.

Current owners are:
- Eli Baird
- Ryan Hansen
- Kevin Gwynn

If you would like to contribute, create a PR at [the project page on GitHub](https://github.com/chghealthcare/chg-helm-charts-tool).

## Add helm repo
```BASH
helm repo add chg https://chghealthcare.github.io/chg-helm-charts-tool/
```

**NOTE:** Before a branch gets merged, you have to increment the version number in the chart you want to release.
GitHub Actions will build any time 'master' branch is pushed, and a will fail unless chart has a new version.

```
helm upgrade -f ./deployment/values-stage.yaml --install --force --wait --set image.repository='<image_repo>/${PROJECT}' 
--set image.tag='${GIT_COMMIT}' ${PROJECT} 
--namespace=stage chg/service"
```
## Requirements 
Requirements for a helm deployment include the following: 
- Values files must include a `project` value that contains the name of you
- There must be a valid secret in Vault. The secret must be named to match the `project` value in your values file.