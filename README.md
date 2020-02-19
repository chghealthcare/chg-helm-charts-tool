# chg-helm-charts-tool

Thanks for using the CHG Services Chart.

Current owners are:
- Eli Baird
- Ryan Hansen
- Kevin Gwynn

If you would like to contribute, create a PR at [the project page on GitHub](https://github.com/chgdev/chg-helm-charts-tool).

##Add helm repo
```BASH
helm repo add chg https://chgdev.github.io/chg-helm-charts-tool/
```

Note that this chart requires Istio to run

`helm package ./service`
`helm repo index .`
