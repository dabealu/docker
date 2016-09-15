#!/usr/bin/env python

from docker import Client
import os
import subprocess

def cert_gen(project_name):
  '''
  get project name from env variable PROJECT_NAME
  check cert files existence and create or renew it
  '''
  certfile = ['/etc/letsencrypt/live/' + project_name + '/fullchain.pem', '/etc/letsencrypt/live/' + project_name + '/privkey.pem']
  create_cert_cmd = 'certbot certonly --webroot -w /app/public -d ' + project_name + ' --agree-tos -m infra@webgears.ru -q'
  create_cert_lst = create_cert_cmd.split()
  renew_cert_cmd = 'certbot renew -q'
  renew_cert_lst = renew_cert_cmd.split()
  if os.path.isfile(certfile[0]) == True and os.path.isfile(certfile[1]) == True:
    subprocess.call(renew_cert_lst)
  else:
    subprocess.call(create_cert_lst)

def reload_nginx(project_name, cmd_str='nginx -s reload'):
  '''
  exec nginx reload inside container through docker API
  container name must be 'projectname_nginx_1'
  '''
  ct_prefix = project_name.translate(None, '-.')
  ct_name = ct_prefix+'_nginx_1'
  #connect to docker socket and execute command
  cli = Client(base_url='unix://var/run/docker.sock')
  ct_cmd = cli.exec_create(container=ct_name, cmd=cmd_str)
  ct_exec = cli.exec_start(exec_id=ct_cmd['Id'], tty=True)

if __name__ == '__main__':
  # define project_name and call functions
  project_name = os.environ['PROJECT_NAME']
  cert_gen(project_name)
  reload_nginx(project_name)

'''
handle multidomain names ?
'''
