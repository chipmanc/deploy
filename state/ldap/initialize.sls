database:
  file.managed:
    - name: /root/.database.ldif
    - source: salt://ldap/files/database.ldif
    - template: jinja
  cmd.run:
    - name: >
        ldapmodify -Y EXTERNAL -H ldapi:/// -f /root/.database.ldif;
        ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f /etc/openldap/schema/cosine.ldif;
        ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f /etc/openldap/schema/nis.ldif;
        ldapadd -Y EXTERNAL -H ldapi:/// -D "cn=config" -f /etc/openldap/schema/inetorgperson.ldif
    - onchanges:
      - file: database
