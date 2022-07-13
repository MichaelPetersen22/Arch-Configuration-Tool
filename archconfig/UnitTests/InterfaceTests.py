import unittest
from GUI.Interface import Interface
class MockInterface:
    pass


class MockInterfaceTests:
    pass

class InterfaceTests(unittest.TestCase):
    def setUp(self):
        self.TestInterface = Interface()
        
    def packagemenuTest(self):
        self.TestInterface.packagelist = ['./UnitTests/pkglist.txt', True]
        self.assertIs(['./UnitTests/pkglist.txt', True], self.TestInterface.packagelist)

unittest.main()