release:
	rm -rf build && jpm build
css:
	npx tailwindcss -i ./src/styles.css -o ./docs/styles.css
run:
	janet main.janet
all: run css
