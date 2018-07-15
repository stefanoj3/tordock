<img width="200px" src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Tor_project_logo_hq.png">

## tordock

Containerized Tor SOCKS5.


#### How to
Check your current ip:
```
curl icanhazip.com
```


Start the container:
```
docker run -d -p 127.0.0.1:9150:9150 stefanoj3/tordock:latest
```


Http call using the just spawned tor socks5, you should get a different ip:
```
curl --socks5-hostname 127.0.0.1:9150 icanhazip.com
```


#### How can I use it from my favourite language?
Here is an example with golang:
```go
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"

	"golang.org/x/net/proxy"
)

func main() {
	tbProxyURL, err := url.Parse("socks5://127.0.0.1:9150")
	if err != nil {
		panic(err)
	}

	tbDialer, err := proxy.FromURL(tbProxyURL, proxy.Direct)
	if err != nil {
		panic(err)
	}

	tbTransport := &http.Transport{Dial: tbDialer.Dial}
	client := &http.Client{Transport: tbTransport}

	resp, err := client.Get("http://icanhazip.com")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	fmt.Printf("GET returned: %v\n", resp.Status)
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	fmt.Println(string(body))
}
```
