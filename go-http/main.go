package main

import (
  "fmt"
  "net/http"
  "io/ioutil"
)

func HandleTerraformOutput(w http.ResponseWriter, r *http.Request) {
  fmt.Println("Received Request=%v",r)
  if r.Method == "GET" {
    content,err:=ioutil.ReadFile("terraform.tfstate")
    if err !=nil {
      fmt.Fprintln(w, err)
    } else {
      fmt.Fprintln(w,string(content))
    }
  } else if r.Method == "POST" {
     body,_:=ioutil.ReadAll(r.Body)
     ioutil.WriteFile("terraform.tfstate",body,0644)
     fmt.Fprintln(w,"Request Body = ", string(body))
  }
}

func main() {
  http.HandleFunc("/", HandleTerraformOutput)
  http.ListenAndServe(":8080",nil)
  fmt.Println("Server is started at port 8080 successfully.")
}
