package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func HandleTerraformOutput(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received Request=%v", r)
	if r.Method == "GET" {
		content, err := ioutil.ReadFile("terraform.tfstate")
		if err != nil {
			fmt.Fprintln(w, err)
		} else {
			fmt.Fprintln(w, string(content))
		}
	} else if r.Method == "POST" {
		body, _ := ioutil.ReadAll(r.Body)
		ioutil.WriteFile("terraform.tfstate", body, 0644)
		fmt.Fprintln(w, "Request Body = ", string(body))
	}
}

func HandleTerraformVPCInput(w http.ResponseWriter, r *http.Request) {
	body := `
  {
    "vpc" : "vpc1",
    "vpc_cidr_block = "10.2.0.0/16"
  }`
	fmt.Fprintln(w, body)
}

func main() {
	http.HandleFunc("/", HandleTerraformOutput)
	http.HandleFunc("/vpc/input", HandleTerraformVPCInput)
	http.ListenAndServe(":8080", nil)
	fmt.Println("Server is started at port 8080 successfully.")
}
