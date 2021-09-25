# Create File with cat cmd

```bash
$ cat - <<-EOF | > secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: dummy-secret
type: Opaque
data:
  API_KEY: bWVnYV9zZWNyZXRfa2V5
  API_SECRET: cmVhbGx5X3NlY3JldF92YWx1ZTE=
EOF
```

```bash
# create k8s resource without reading from file
$ cat - <<-EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dummy-secret
type: Opaque
data:
  API_KEY: bWVnYV9zZWNyZXRfa2V5
  API_SECRET: cmVhbGx5X3NlY3JldF92YWx1ZTE=
EOF
secret/dummy-secret created

# coming ...
```
