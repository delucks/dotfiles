#!/usr/bin/env python
'''fileset.py is a simple script which performs a set-style diff of two files.
By default, each line of the file is considered an item of each file's set.
You can pass in parameters which instruct the script to treat characters or words as set elements instead.
This tool is purposefully minimal to be useful as part of a shell pipeline.

Examples:
    ./fileset.py foo bar             # Describe the relation between two files
    ./fileset.py -o union foo bar    # Output elements of the files rather than describing their relation
    ./fileset.py - bar               # "-" as an argument reads from stdin
    ./fileset.py -c foo bar          # Count characters
    ./fileset.py -w foo bar          # Count words
    ./fileset.py -w -d, foo bar      # Use comma as the word delimiter instead
'''
import sys
import argparse

supported_operations = [
    'intersect',
    'union',
    'subtract'
]


class ConciseErrorParser(argparse.ArgumentParser):
    '''do not print __doc__ twice if the user misses a required arg'''
    def error(self, message):
        sys.stderr.write(__doc__ + '\n')
        sys.stderr.write('ERROR: ' + message + '\n')
        sys.exit(1)

# Set up the cli
p = ConciseErrorParser(__doc__)
p.add_argument('files', nargs=2, help='file paths to compare. "-" is standard input', metavar='file_to_compare')
split_opts = p.add_mutually_exclusive_group(required=False)
split_opts.add_argument('-l', '--lines', action='store_true')
split_opts.add_argument('-w', '--words', action='store_true')
split_opts.add_argument('-c', '--characters', action='store_true')
p.add_argument('-d', '--delimiter', help='delimiter to split on for word split', required=False)
p.add_argument('-s', '--strip-whitespace', action='store_true')
p.add_argument('-o', '--operation', help='display the set produced by this operation on the two files', choices=supported_operations, required=False)
args = p.parse_args()

# Make sure that the user isn't instructing us to do something stupid
if all(x == '-' for x in args.files):
    print('Cannot open standard input twice! Pass a filename')
    sys.exit(1)

# Open the files or sys.stdin and prepare to get their full contents
fds = []
for fn in args.files:
    if fn == '-':
        fds.append(sys.stdin)
    else:
        try:
            fds.append(open(fn))
        except IOError as e:
            # Try to give the user a helpful error message
            errnomap = {
                1: 'Operation not permitted',
                2: 'No such file or directory',
                5: 'I/O Error',
                12: 'OOM',
                13: 'Permission denied',
                21: 'Is a directory',
                32: 'Broken pipe'
            }
            reason = errnomap.get(e.errno, 'Errno {0}'.format(e.errno))
            print('IOError: Could not open filename {0}! {1}'.format(fn, reason))
            sys.exit(1)

# Get contents of both files
contents = [f.read() for f in fds]
[f.close() for f in fds]

# Figure out how the user wants us to split their contents up and
# create sets of both the files contents.
if args.words:
    # We should split the input files by whitespace or args.delimiter
    if args.delimiter:
        if args.strip_whitespace:
            s1, s2 = [set([n.strip() for n in c.split(args.delimiter)]) for c in contents]
        else:
            s1, s2 = [set(c.split(args.delimiter)) for c in contents]
    else:
        s1, s2 = [set(c.split()) for c in contents]
elif args.characters:
    s1, s2 = [set(c) for c in contents]
else:  # args.lines
    if args.strip_whitespace:
        s1, s2 = [set([l.strip() for l in c.splitlines()]) for c in contents]
    else:
        s1, s2 = [set(c.splitlines()) for c in contents]

# Perform analysis on the resulting sets
if args.operation:
    if args.operation == 'union':
        result = s1.union(s2)
    elif args.operation == 'intersect':
        result = s1.intersection(s2)
    elif args.operation == 'subtract':
        result = s1 - s2
    else:
        # try to look up the method on the set
        possible = getattr(s1, args.operation)
        if callable(possible):
            result = possible(s2)
    for item in result:
        print(item)
else:
    f1, f2 = args.files
    if s1 == s2:
        print('The two files are equivalent')
    elif s1.issubset(s2):
        print('{0} is a subset of {1}'.format(f1, f2))
        print('Their intersection has {0} elements'.format(len(s2.intersection(s1))))
    elif s1.issuperset(s2):
        print('{0} is a superset of {1}'.format(f1, f2))
        print('Their intersection has {0} elements'.format(len(s1.intersection(s2))))
    else:
        print('The two files are disjoint')
    print('Their union has {0} elements'.format(len(s1.union(s2))))
