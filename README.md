# foobar-api

Tiny Go webserver that prints OS information and HTTP requests to output.

This Tiny Go webserver was deployed on two Linodes: 
one cluster is in the US (Texas) and the other in the EU (France).
DNS management is handled by Cloudflare.
Load balancing and health checks are performed at the DNS level by Cloudflare.
We are using the ACME protocol to obtain certificates,
and Traefik handles SSL termination.
Traefik and its dashboard are the only services exposed.
We are using the Traefik basic auth middleware that leverages MD5 hash encryption.
