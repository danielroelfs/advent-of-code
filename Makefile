default: render

date := `date '+%Y%m%d-%H%M'`

test:
	quarto --version

preview:
	quarto preview --port 3685

render:
	quarto render
