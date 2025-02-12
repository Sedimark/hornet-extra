# SEDIMARK DLT Node Docker-compose Setup

This setup allows you to run both an IOTA Hornet node (L1) and an IOTA Wasp node (L2) along with other services to give you more monitoring options.
It uses Docker for containerisation and Traefik as a reverse proxy, so you can manage access to your nodes and ensure that your requests are sent to the correct endpoints. In particular, Traefik enables dynamic routing and handles SSL/TLS termination, simplifying the process of enabling TLS by using Let's Encrypt X.509 certificates that are automatically renewed without manual intervention.