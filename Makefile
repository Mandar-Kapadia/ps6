CC = g++
CFLAGS = -Wall -Werror -pedantic --std=c++17
LIBS = -lboost_unit_test_framework -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio
DEPS = RandWriter.h test.cpp TextWriter.cpp
all:test TextWriter style  
%.o: %.cpp $(DEPS)
	$(CC) $(CFLAGS) -I/opt/homebrew/Cellar/boost/1.78.0_1/include -I/opt/homebrew/Cellar/sfml/2.5.1_1/include -c $<
test: RandWriter.o test.o
	$(CC) $(CFLAGS) -L/opt/homebrew/Cellar/boost/1.78.0_1/lib -L/opt/homebrew/Cellar/sfml/2.5.1_1/lib -o $@ $^ $(LIBS)
TextWriter: RandWriter.o TextWriter.o
	$(CC) $(CFLAGS) -L/opt/homebrew/Cellar/boost/1.78.0_1/lib -L/opt/homebrew/Cellar/sfml/2.5.1_1/lib -o $@ $^ $(LIBS)
clean:
	rm -f *.o 
	rm -f test
	rm -f TextWriter
style:
	cpplint --filter=-runtime/references,-build/header_guard --extensions=cpp,hpp,h RandWriter.h
	cpplint --filter=-runtime/references,-build/header_guard --extensions=cpp,hpp,h RandWriter.cpp
	cpplint --filter=-runtime/references,-build/header_guard --extensions=cpp,hpp,h test.cpp
	cpplint --filter=-runtime/references,-build/header_guard --extensions=cpp,hpp,h TextWriter.cpp