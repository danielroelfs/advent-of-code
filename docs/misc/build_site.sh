#!/bin/bash

echo "Building site..."

Rscript -e "rmarkdown::render_site()"

echo "Site build!"