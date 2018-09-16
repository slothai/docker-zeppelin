build:
	docker build --tag slothai/zeppelin:dev .
debug:
	docker run -it -p 8080:8080 slothai/zeppelin:dev /bin/sh
