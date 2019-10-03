#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. www.mysite.com"
  exit;
fi

DOMAIN=$1
COMMON_NAME=${2:-*.$1}
SUBJECT="/C=BR/ST=SP/L=Sao Paulo/O=gilbarbara/CN=$DOMAIN/emailAddress=gilbarbara@gmail.com"
NUM_OF_DAYS=999
EXT="authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN"

openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem -subj "$SUBJECT"

if [ ! -f rootCA.pem ]; then
  echo "rootCA.pem couldn't be created. try again!"
  exit;
fi

# Create a new private key if one doesnt exist, or use the xeisting one if it does
if [ -f device.key ]; then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

echo "$EXT" > /tmp/__v3.ext

openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT device.key -subj "$SUBJECT" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days $NUM_OF_DAYS -sha256 -extfile /tmp/__v3.ext 

# move output files to final filenames
mv device.key "$DOMAIN.key"
mv device.csr "$DOMAIN.csr"
mv device.crt "$DOMAIN.crt"

rm rootCA.key
rm rootCA.pem
rm rootCA.srl

echo 
echo "###########################################################################"
echo Done! 
echo "###########################################################################"
echo "To use these files on your server, simply copy both $DOMAIN.csr and"
echo "$DOMAIN.key to your webserver, and use like so (if Apache, for example)"
echo 
echo "    SSLCertificateFile    /path_to_your_files/$DOMAIN.crt"
echo "    SSLCertificateKeyFile /path_to_your_files/$DOMAIN.key"
echo
echo "Remember to trust the generated certificate"
echo "In Mac OS X, run:"
echo "sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /path/to/$DOMAIN.crt"
