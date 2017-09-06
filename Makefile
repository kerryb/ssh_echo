.PHONY: clean test docs
all: clean test docs
clean:
	mix clean
test:
	mix coveralls.html
docs:
	mix docs
