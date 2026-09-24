#!/usr/bin/env bash
set -ex

# Folder where this script lives (NCO-bulk/code locally, /code on Code Ocean)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d /data ] && [ -d /code ]; then
    # Code Ocean capsule
    ROOT_DIR=/code
    RESULTS_DIR=/results
else
    # Local: project root is one level above the code folder
    ROOT_DIR="$(dirname "$SCRIPT_DIR")"
    RESULTS_DIR="$ROOT_DIR/Results"
fi

mkdir -p "$RESULTS_DIR"

Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/Bulk_DE_analysis.Rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"
