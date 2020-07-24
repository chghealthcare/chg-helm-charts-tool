# Admission-Webhook

This chart is forked from [liangrog/admission-webhook-server](https://github.com/liangrog/admission-webhook-server). There are several changes unique to the common-svc nonprod environment, and moves from using raw environment variables in the pod to using a configmap and the reloader operator. 

### Installing

First, download the `ssl.sh` script from the repo, and run it the directory you plan to deploy from.

```bash
helm repo add chg https://chartmuseum.shared.aws.chgit.com
sh ./ssl.sh admission-webhook-server.tools.svc
helm install chg/admission-webhook admission-webhook-server -n tools
```

### Configuring

Either by using a `values.yml` file or by passing into the install command set the `podNodesSelectorConfig` to a string that matches this format

```
namespace: label_name=label_value,myOtherLabel=anothervalue; namespace2: label=values
```

Once the webhook is initially installed, updates to the configmap will automatically trigger a re-deploy of the admission-webhook with the new configuration.

