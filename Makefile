TEST_FILEMANAGER = testfilemanager
TEST_HTTPCLI = testhttpcli
TESTS_DIR = ./tests
build-it:
	nimble build --verbose $(SSL)
test-filemanager:
	nim c -r $(TESTS_DIR)/$(TEST_FILEMANAGER).nim && rm $(TESTS_DIR)/$(TEST_FILEMANAGER)
test-httpcli:
	nim c -r $(TESTS_DIR)/$(TEST_HTTPCLI).nim -d:ssl && rm  $(TESTS_DIR)/$(TEST_HTTPCLI)