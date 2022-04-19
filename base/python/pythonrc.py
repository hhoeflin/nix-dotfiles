import sys

# check if IPython is loaded
if "IPython" in sys.modules:
    # yes it is
    try:
        get_ipython().run_line_magic("load_ext", "mkreports")
    except Exception:
        pass
