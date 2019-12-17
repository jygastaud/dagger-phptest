package phpapp

import (
  "alpha.dagger.io/docker"
  "alpha.dagger.io/dagger"
  "alpha.dagger.io/http"
)

dockerSocket: dagger.#Stream & dagger.#Input

// push the image to a registry
push: docker.#Push & {
    // leave target blank here so that different
    // environments can push to different registries
    target: string

    // the source of our push resource
    // is the image resource we declared above
    source: image
}

// run our phpapp in our local Docker engine
run: docker.#Run & {
    ref:  push.ref
    name: "phpapp"
    ports: ["8080:80"]
    socket: dockerSocket
}

// run our local registry
registry: docker.#Run & {
    ref:  "registry:2"
    name: "registry-local"
    ports: ["5042:5000"]
    socket: dockerSocket
}

// As we pushed the registry to our local docker
// we need to wait for the container to be up
wait: http.#Wait & {
    url: "localhost:5042"
}

// push to our local registry
// this concrete value satisfies the string constraint
// we defined in the previous file
push: target: "\(wait.url)/phpapp"

// Application URL
appURL: "http://localhost:8080/" & dagger.#Output
