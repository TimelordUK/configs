import unittest


class FileReader:
    def __init__(self) -> None:
        pass

    def read(self):
        with open("/home/me/dev/py/tester.py", "r") as fh:
            for l in fh:
                l = l.strip()
                print(l)


class Tester(unittest.TestCase):
    def test_read(self):
        fr = FileReader()
        fr.read()

    def test_isupper(self):
        self.assertTrue("FOO".isupper())
        self.assertFalse("Foo".isupper())


if __name__ == "__main__":
    unittest.main()
