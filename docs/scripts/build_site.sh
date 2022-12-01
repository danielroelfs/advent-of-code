#!/bin/bash

echo -e "\n\nBuilding site...\n"

Rscript -e "rmarkdown::render_site()"

echo -e "\n\nSite build successfully!\n"