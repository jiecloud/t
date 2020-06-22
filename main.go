package main

import (
	"net/http"
	"io"
	"os"
	"log"
	"time"
)

type helloHandler struct{}

func (c *helloHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	loc, _ := time.LoadLocation("Local")

	log.Println("local-time:", time.Now().In(loc).String())
	log.Println("Host -->", w.Header().Get("Host"))
	io.WriteString(w, "name: "+os.Getenv("HOSTNAME"))
}

func main() {
	mux := http.NewServeMux()

	mux.Handle("/", &helloHandler{})

	if err := http.ListenAndServe(":8080", mux); err != nil {
		panic(err)
	}
}
