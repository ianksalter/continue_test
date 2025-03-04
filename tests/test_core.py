# tests/test_core.py
import pytest
from my_package.core import my_double

def test_my_double():
    assert my_double(2) == 4
    assert my_double(0) == 0
    assert my_double(-3) == -6
    assert my_double(2.5) == 4.0
