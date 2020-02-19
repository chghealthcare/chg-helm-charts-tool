# chg-helm-charts-tool

##Thanks for using the CHG Services Chart

current owners are
 1. Eli Baird
 2. Ryan Hansen
 3. Kevin Gwynn

if you would like to contribute create a PR at 
github.com/chg/chg-helm-charts-tool

##Add helm repo
```BASH
helm repo add chg https://chgdev.github.io/chg-helm-charts-tool/
```

Note that this chart requires Istio to run

`helm package ./service`
`helm repo index .`