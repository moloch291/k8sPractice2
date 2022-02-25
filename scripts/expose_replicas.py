# This script only exposes a single pod via port-forwarding!
from subprocess import PIPE, run
import sys
import os


def evaluate_pods(pods_info):
    if sys.argv[1] in pods_info:
        os.system(
            f"kubectl port-forward {sys.argv[3]}/{sys.argv[1]} 8080:8080 --namespace={sys.argv[2]}"
        )
        print("\nPort-forwarding cancelled!")
        exit(0)
    print("Pods does not exist in this namespace!")


def get_output(command):
    result = run(
        command, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True
    )
    return result.stdout


def main():
    pods_info = get_output(
        f"kubectl get {sys.argv[3]}s --namespace={sys.argv[2]}"
    )
    evaluate_pods(pods_info)


if __name__ == "__main__":
    main()
