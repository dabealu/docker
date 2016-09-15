#!/usr/bin/env python

from docker import Client
import os
import argparse
import sys

#parse arguments
parser = argparse.ArgumentParser(description='Execute command in container (like docker exec).', add_help=True)
parser.add_argument('-s', action='store', dest='socket_path', help='path to docker.sock (default: unix://var/run/docker.sock)')
parser.add_argument('-c', action='store', dest='command', help='command to execute')
parser.add_argument('-n', action='store', dest='container_name', help='container name or id in which execute command')
args = vars(parser.parse_args())
 
#check arguments existence and throw error
if args['socket_path'] == None:
  socket = 'unix://var/run/docker.sock'
else:
  socket = args['socket_path']
if args['command'] == None or args['container_name'] == None:
  print('Provide container name and command: ./' + os.path.basename(__file__) + ' -n name -c command')
  sys.exit(2)
else: 
  cmd_str = args['command']
  ct_name = args['container_name']


def exec_cmd(ct_name, cmd_str, socket):
  '''
  exec command inside container 
  args:
    socket=/path/to/docker.sock (default unix://var/run/docker.sock)
    cmd_str='command to execute'
    ct_name='container_name'
  '''
  #connect to docker socket and execute command
  cli = Client(base_url=socket)
  ct_cmd = cli.exec_create(container=ct_name, cmd=cmd_str)
  ct_exec = cli.exec_start(exec_id=ct_cmd['Id'], tty=True)
  print ct_exec


if __name__ == '__main__':
  exec_cmd(ct_name, cmd_str, socket)
