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
    print(sys.argv)
    print(os.environ)
#    patch = '{"metadata":{"labels":{"role": "%s"}}}' % sys.argv[2]

#    returncode = subprocess.call(['/usr/bin/oc', 'patch','pod', socket.gethostname(), '-p', patch])
#    print("return code %d" % returncode )

if __name__ == "__main__":
    main()
