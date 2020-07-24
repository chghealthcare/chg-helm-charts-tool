#!/bin/bash
: ${1?'missing CN'}
cn="$1"

secret_dir="ssl"
expiration="3650"

mkdir -p ${secret_dir}

# Generate the CA cert and private key
openssl req -nodes -new -x509 \
  -days $expiration \
  -keyout ${secret_dir}/ca.key \
  -out ${secret_dir}/ca.crt \
  -subj "/CN=Admission Controller Webhook Server CA"

rm server.pem
cat ca.key ca.crt > ${secret_dir}/server.pem

# Generate the private key for the webhook server
openssl genrsa -out ${secret_dir}/tls.key 2048
# Generate a Certificate Signing Request (CSR) for the private key, and sign it with the private key of the CA.
openssl req -new \
  -days $expiration \
  -key ${secret_dir}/tls.key \
  -subj "/CN=$cn" \
| openssl x509 \
  -days $expiration -req \
  -CA ${secret_dir}/ca.crt \
  -CAkey ${secret_dir}/ca.key \
  -CAcreateserial \
  -out ${secret_dir}/tls.crt

rm $secret_dir/ca.srl $secret_dir/ca.key $secret_dir/server.pem
