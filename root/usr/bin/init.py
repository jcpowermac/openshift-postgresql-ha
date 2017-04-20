#!/usr/bin/python

import sys
import os
#import json
#import logging
import subprocess
import socket
#import time

#logger = logging.getLogger(__name__)

def main():
    #logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', level=logging.INFO)
    #logging.info("Changing the pod's role to %s" % sys.argv[2] )

    returncode = subprocess.call(['/opt/rh/rh-postgresql95/root/usr/bin/createdb',
        '-U', 'postgres', '-h', '127.0.0.1',
        '-O', os.environ.get('POSTGRESQL_USER'), os.environ.get('POSTGRESQL_DATABASE')])

    print("init.py createdb return code %d" % returncode )

if __name__ == "__main__":
    main()
