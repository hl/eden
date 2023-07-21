release:
	rm -rf build && jpm build
css:
	npx tailwindcss -i ./src/styles.css -o ./dist/styles.css
run:
	janet main.janet
all: run css