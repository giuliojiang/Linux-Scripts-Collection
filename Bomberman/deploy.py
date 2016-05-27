#!/usr/bin/env python

import subprocess
import sys
import os
import argparse

def main(argv=None):
    
    git_source = 'https://gitlab.doc.ic.ac.uk/WebApps-Group-12/BomberMan.git'
    cloned_directory = 'out'
    
    # .........................................................................
    # load command line arguments
    if argv is None:
        argv = sys.argv[1:]

    # .........................................................................
    # parse command line arguments (argparse)
    parser = argparse.ArgumentParser()

    parser.add_argument('--output',
                        help='Output directory',
                        default='/var/www/',
                        required=True
                        )
                        
    parser.add_argument('--url',
                        help='Deploy server',
                        required=True
                        )

    args = parser.parse_args(argv)

    
    
    # .........................................................................
    # Clean out directory
    subprocess.call(['rm', '-rf', cloned_directory])
    subprocess.call(['rm', '-rf', args.output + os.sep + 'BOMBERMAN'])
    
    # .........................................................................
    # Clone from git
    subprocess.call(['git', 'clone', git_source, cloned_directory, '--depth', '1'])
    
    # .........................................................................
    # Move client to deploy folder
    subprocess.call(['mv', cloned_directory + os.sep + 'client', args.output + os.sep + 'BOMBERMAN'])
    
    # .........................................................................
    # Overwrite the address file
    filename = args.output + os.sep + 'BOMBERMAN' + os.sep + 'server_url.js'
    openfile = open(filename, 'w')
    openfile.write("socketURL = 'ws://")
    openfile.write(args.url)
    openfile.write(":1080';\n")
    openfile.close()

    # .........................................................................
    # Compile the server
    os.chdir(cloned_directory + os.sep + 'server');
    subprocess.call(['make']);
    
# ==============================================================================
# call main if executed as script
if __name__ == '__main__':
    sys.exit(main())
