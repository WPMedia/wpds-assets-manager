copy-assets-into-public-directory:
	mkdir -p public
	cp -r ./src/* ./public

svg-to-react:
	npx @svgr/cli --out-dir build src

sprite-gen:
	node icon-gen.js

build-library:
	npx svgo src/*.svg
	make sprite-gen
	make svg-to-react
	npx tsup build/*.tsx --minify --format esm,cjs --dts --sourcemap --legacy-output --outDir asset
	make copy-assets-into-public-directory
	npx next build

dev:
	make copy-assets-into-public-directory
	npx next dev