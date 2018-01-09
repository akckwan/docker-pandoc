# build
docker build -t pandoc .

# execute commands in docker
docker run -it --entrypoint /bin/bash pandoc

# compile markdown file
docker run -v `pwd`:/source pandoc --pdf-engine=xelatex -f markdown ./src/test.md --toc -o ./src/test.pdf

* to compile with listings, add the --listing flag
