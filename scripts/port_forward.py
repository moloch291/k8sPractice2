# Usage:
# The first cl arg should be the mode (pod, replicationcontroller, etc)
# Second should be the name
# Third is the namespace
from subprocess import PIPE, run
import sys
import os


def evaluate_pods(pods_info):
    if sys.argv[2] in pods_info:
        os.system(
            f"kubectl port-forward {sys.argv[1]}/{sys.argv[2]} 8080:8080 --namespace={sys.argv[3]}"
        )
        print("\nPort-forwarding cancelled...")
        exit(0)
    print("Port-forwarding unsuccessful...")


def get_output(command):
    result = run(
        command, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True
    )
    return result.stdout


def main():
    pods_info = get_output(
        f"kubectl get {sys.argv[1]}s --namespace={sys.argv[3]}"
    )
    evaluate_pods(pods_info)


if __name__ == "__main__":
    main()
