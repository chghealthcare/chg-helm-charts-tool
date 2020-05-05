# chg-helm-charts-tool

Thanks for using the CHG Services Chart.

Current owners are:
- Eli Baird
- Ryan Hansen
- Kevin Gwynn

If you would like to contribute, create a PR at [the project page on GitHub](https://github.com/chghealthcare/chg-helm-charts-tool).

##Add helm repo
```BASH
helm repo add chg https://chghealthcare.github.io/chg-helm-charts-tool/
```

before a branch gets merged you have to increment the version number in the chart you want to release.
Github actions will build any time master branch is pushed, and a will fail unless chart has a new version.
