#!/usr/bin/env python3

architectures = ["arm32", "arm64", "x64", "x86"]

import subprocess, os
from argparse import ArgumentDefaultsHelpFormatter, ArgumentParser
from pathlib import Path

def parse_args():
    parser = ArgumentParser(formatter_class=ArgumentDefaultsHelpFormatter)
    parser.add_argument("walrus", help="Path to walrus", type=Path)

    parser.add_argument(
        "-s", "--setup", default=False, help="Setup (build containers)", action="store_true")
    
    parser.add_argument(
        "-n", "--no-cache", default=False, help="No cache at setup (build containers)", action="store_true")
    
    parser.add_argument(
        "-l", "--no-log-prefix", default=False, help="No container name prefix at run", action="store_true")
    
    parser.add_argument(
        "-m", "--mode", help="Mode", choices=["release", "debug"], default="release")
    
    parser.add_argument(
        "-a", "--arch", help="Architecture", choices=architectures+["all"], default="all")
    
    parser.add_argument(
        "-c", "--compile-anyway", help="Compile anyway (delete build folder)", action="store_true", default=False)
    
    parser.add_argument(
        "-p", "--perf", help="Build with Perftool compatibility", action="store_true", default=False)

    parser.add_argument('-o', '--output', help="WALRUS_OUTPUT", choices=["static_lib", "shared_lib", "shell", "api_test"], default="shell")

    args = parser.parse_args()

    return args


if __name__ == "__main__":
    args = parse_args()

    env = os.environ.copy()


    env["MODE"] = args.mode

    env["VOLUME_WALRUS"] = args.walrus

    env["COMPILE_ANYWAY"] = '1' if args.compile_anyway else '0'


    env["USER_ID"] = str(int(subprocess.check_output(["id", "--user"])))

    env["GROUP_ID"] = str(int(subprocess.check_output(["id", "--group"])))

    env["PERF"] = '1' if args.perf else '0'

    env["OUTPUT"] = args.output

    if args.setup:
        subprocess.run(["docker", "compose", "build"] + (['--no-cache'] if args.no_cache else []), env=env)

    else: 
        if args.arch=="all":
            subprocess.run(["docker", "compose", "up"] + (["--no-log-prefix"] if args.no_log_prefix else []), env=env)
            exit()
        
        subprocess.run(["docker", "compose", "up"] + (["--no-log-prefix"] if args.no_log_prefix else []) + [args.arch], env=env)
