import json
import requests

domain = 'gerrit.chrischipman.com:8080'
admin_ldap = "{{ pillar['dn_gerrit_ldap_admin'] }}"
dev_ldap = "{{ pillar['dn_gerrit_ldap_devs'] }}"
user = 'gerrit_admin'
password = "{{pillar['gerrit_admin_pass'] }}"
auth = (user, password)

data = 'username={}&password={}'.format(user, password)
headers = {'Content-Type': 'application/x-www-form-urlencoded'}
requests.post('http://{}/login/'.format(domain), headers=headers, data=data)

groups = requests.get('http://{}/a/groups/'.format(domain), auth=auth)
admin_group = json.loads(groups.text[4:])['Administrators']['id']
requests.put('http://{}/a/groups/{}/groups/ldap:{}'.format(domain, admin_group, admin_ldap), auth=auth)

devs = requests.put('http://{}/a/groups/Devs'.format(domain), auth=auth)
if devs.status_code != 200:
    print('Group already exists')
else:
    dev_group = json.loads(devs.text[4:])['id']
    requests.put('http://{}/a/groups/{}/groups/ldap:{}'.format(domain, dev_group, dev_ldap), auth=auth)

