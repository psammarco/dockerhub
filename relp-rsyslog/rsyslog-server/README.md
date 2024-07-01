# RELP rsyslog server with One Way TLS Authentication

### Intro
This is a two nodes relp-rsyslog server which uses relp-openssl for One Way TLS authentication.

By using server-side authentication or one-way SSL/TLS authentication, only the server presents its certificate to the client. The client verifies the server's certificate using the CA certificate but does not provide its own certificate for verification.

This removes the complexity of having to generate and maintain keys for each and every client. Though, it may not be the best approach for production usage, especially when rsyslog-server is expected to deal with requests coming from the internet.

See *genkeys.txt* if you need help with generating the keys. 
