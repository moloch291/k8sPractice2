from subprocess import PIPE, run
import sys
import os


def evaluate_pods(pods_info):
    for line in pods_info:
        if sys.argv[2] in line:
            os.system(
                f"kubectl port-forward {sys.argv[2]} 8080:8080 --namespace={sys.argv[1]}"
            )
    print("Pod does not exist in this namespace!")


def out(command):
    result = run(
        command, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True
    )
    return result.stdout


def main():
    pods_info = out("kubectl get pods --namespace=" + sys.argv[1]).split("\n")
    evaluate_pods(pods_info)


if __name__ == "__main__":
    main()
