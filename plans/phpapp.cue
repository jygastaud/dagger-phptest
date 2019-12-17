package phpapp

import (
  "github.com/jygastaud/dagger/php/composer"
  "alpha.dagger.io/os"
  "alpha.dagger.io/docker"
)

app: composer.#Package

// package the static HTML from yarn into a Docker image
image: os.#Container & {
    image: docker.#Pull & {
        from: "php:8.0-apache"
    }

    // app.build references our app key above
    // which infers a dependency that Dagger
    // uses to generate the DAG
    copy: "/var/www/html": from: app.output
}
