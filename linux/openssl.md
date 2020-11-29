```
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt
openssl x509 -in ca.crt -out ca.pem -outform PEM

openssl genrsa -out client.pem 1024
openssl req -new -key client.pem -out client.csr
```

