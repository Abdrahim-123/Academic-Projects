SRC = CP2_PROJECT/main.c
OUT = build/main

.PHONY: all clean

all: $(OUT)

$(OUT): $(SRC)
	@mkdir -p build
	gcc $(SRC) -o $(OUT)

clean:
	rm -rf build
