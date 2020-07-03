package app

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"strings"
)

func RunGitHTTPRouter() {
	go func() {
		if err := runGitHTTPRouter(); err != nil {
			panic(err)
		}
	}()
}

func runGitHTTPRouter() error {
	fmt.Println("git http router running...")
	defer fmt.Println("git http router exit..")
	return http.ListenAndServe(":8011", &GitHttpRouter{})
}

type GitHttpRouter struct {
}

func (w *GitHttpRouter) ServeHTTP(resp http.ResponseWriter, req *http.Request) {
	branch := BranchByHost(req.Host)
	isGitURL := strings.HasSuffix(req.URL.Path, ".git")
	if isGitURL {
		w.location(branch, resp, req)
	} else {
		resp.WriteHeader(http.StatusInternalServerError)
	}
}

// api路由到后端
func (w *GitHttpRouter) location(branch string, resp http.ResponseWriter, req *http.Request) {
	log.Printf("url: %s, client: %s", req.URL.String(), req.RemoteAddr)

	uri, err := url.Parse(fmt.Sprintf("http://services_%s:8080", branch))
	if err != nil {
		panic(errors.New("parse url was err: " + err.Error() + " branch:" + branch))
	}
	reverseProxy := httputil.NewSingleHostReverseProxy(uri)
	reverseProxy.ModifyResponse = func(response *http.Response) error {
		response.Header.Set(HeaderID, HeaderLabel)
		return nil
	}
	reverseProxy.ServeHTTP(resp, req)
}
