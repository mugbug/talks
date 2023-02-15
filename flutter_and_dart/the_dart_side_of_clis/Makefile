install:
	dart pub global activate --source=path .

tests:
	very_good test \
          --coverage \
          --test-randomize-ordering-seed=random \
          --min-coverage=97

lcov:
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html
