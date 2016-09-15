#!/usr/bin/python

#docker-py module required, install it with 'pip install docker-py'
#usage: pass project directory with docker-compose.yml as first arg or current dir will be used by default

import os
import sys
import re
from docker import Client
from time import sleep

#some time for containers up
sleep(10)

cli = Client(base_url='unix://var/run/docker.sock')

#change workdir if its specified as a first arg
if len(sys.argv) == 2:
  os.chdir(sys.argv[1])

#get container prefix from current workdir, e.g. for dir name exam-ple.com prefix would be 'examplecom'
ct_basename = os.path.basename(os.getcwd())
ct_prefix = ct_basename.translate(None, '-.')

#ct_list - list of dicts (dict per container)
ct_list = cli.containers(all='true')

result_code = 0

#ct - dict with container parameters
for ct in ct_list:
  # convers names list to string in ct_names
  ct_names = ' '.join(ct[u'Names'])
  ct_state = ct[u'State']
  ct_match = re.match('^/'+ct_prefix+'.*', ct_names)
  # check containers status
  if ct_match != None:
    if ct_state != 'running':
      print ' '+ct_names[1:]+' '+ct_state
      result_code = 1

sys.exit(result_code)

