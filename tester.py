import unittest


class NewClass(object):
    """this will do it all"""


    def myfunc(self, arg):

        

    def __init__(self, a1: int, a2: int, a3: str):
        """whatever

        :a1: TODO
        :a2: TODO
        :a3: TODO

        """
        self._a1 = a1
        self._a2 = a2
        self._a3 = a3


class FileReader:
    def __init__(self) -> None:
        pass

    def read(self):
        with open("/home/me/dev/configs/tester.py", "r") as fh:
            for line in fh:
                line = line.strip()
                print(line)


class Tester(unittest.TestCase):
    def test_read(self):
        fr = FileReader()
        fr.read()

    def test_isupper(self):
        self.assertTrue("FOO".isupper())
        self.assertFalse("Foo".isupper())


if __name__ == "__main__":
    unittest.main()
