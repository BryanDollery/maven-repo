build:
	docker build --tag bryandollery/maven-repo .

run:
	docker run -it --rm bryandollery/maven-repo bash
