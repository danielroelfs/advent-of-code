default: render

current := `date '+%Y'`

test:
	quarto --version

preview:
	quarto preview --port 3685

render-all:
	quarto render

render:
	quarto render ${current}.qmd