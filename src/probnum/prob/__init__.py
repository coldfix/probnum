"""
Probability and statistics.

This package implements functionality related to probability theory and statistics such as random variables and
distributions. Random variables are the primary in- and outputs of probabilistic numerical methods. A generic signature
of such methods looks like this:

.. highlight:: python
.. code-block:: python

    randvar_out, info = probnum_method(problem, randvar_in, **kwargs)

"""

from .randomvariable import *
from .distributions import *

# Public classes and functions. Order is reflected in documentation.
__all__ = ["RandomVariable", "Distribution", "Dirac", "Normal", "asrandvar"]

# Set correct module paths. Corrects links and module paths in documentation.
RandomVariable.__module__ = "probnum.prob"
Distribution.__module__ = "probnum.prob"
