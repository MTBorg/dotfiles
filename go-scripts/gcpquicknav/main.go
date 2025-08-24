/*
Small script to quickly open different GCP pages.
Meant for use with CLI programs (e.g. choose-gui) that read options from STDIN,
lets the user select an option and spits it out on STDOUT.

This program has two modes:
Output - outputs all the selectable options.
Input - reads the selected option and maps it to an output URL that can be opened in the browser.

Example fish alias using choose-gui to open an option in the browser:
alias gcp-dev "gcpquicknav --project=dev | choose | xargs -I _ gcpquicknav --project=dev --mode=input _ | xargs -I _ open _"
*/
package main

import (
	"flag"
	"fmt"
	"strings"
)

var (
	mode    = flag.String("mode", "output", "Mode of operation")
	project = flag.String("project", "", "GCP project ID")
)

var options = map[string]string{
	"App Engine":      "https://console.cloud.google.com/appengine?serviceId=default&hl=en&project=%s",
	"GKE":             "https://console.cloud.google.com/kubernetes/workload/overview?hl=en&project=%s",
	"Cloud Run":       "https://console.cloud.google.com/run?hl=en&project=%s",
	"Cloud functions": "https://console.cloud.google.com/functions/list?referrer=search&hl=en&project=%s",
	"Secret Manager":  "https://console.cloud.google.com/security/secret-manager?hl=en&project=%s",
	"Cloud build":     "https://console.cloud.google.com/cloud-build/builds?hl=en&project=%s",
	"Pubsub":          "https://console.cloud.google.com/cloudpubsub/topic/list?hl=en&project=%s",
	"IAM":             "https://console.cloud.google.com/iam-admin/iam?hl=en&project=%s",
}

func getOptionNames() []string {
	var names []string
	for name := range options {
		names = append(names, name)
	}
	return names
}

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	flag.Parse()
	switch *mode {
	case "output":
		return runOutput()
	case "input":
		return runInput()
	default:
		return runOutput()
	}
}

func runOutput() error {
	optionsList := getOptionNames()
	for _, option := range optionsList {
		fmt.Println(option)
	}
	return nil
}

func runInput() error {
	args := flag.CommandLine.Args()
	optionName := strings.Join(args, " ")

	optionURL, exists := options[optionName]
	if !exists {
		return fmt.Errorf("option %s does not exist", optionName)
	}

	url := fmt.Sprintf(optionURL, *project)

	fmt.Println(url)

	return nil
}
