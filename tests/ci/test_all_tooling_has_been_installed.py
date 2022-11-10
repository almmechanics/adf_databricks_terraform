"""check local python tool installation"""

import shutil

def test_pylint_has_been_installed():
    """Test for the tool `pylint`"""
    assert(shutil.which('pylint')) is not None, "Run pip install in your virtual environment"

def test_yamllint_has_been_installed():
    """Test for the tool `yamllint`"""
    assert(shutil.which('yamllint')) is not None, "Run pip install in your virtual environment"

def test_pymarkdown_has_been_installed():
    """Test for the tool `pymarkdown`"""
    assert(shutil.which('pymarkdown')) is not None, "Run pip install in your virtual environment"

def test_safety_has_been_installed():
    """Test for the tool `safety`"""
    assert(shutil.which('safety')) is not None, "Run pip install in your virtual environment"
