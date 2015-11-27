if HAVE_ASTYLE
astyle:
	$(ASTYLE) -n -R $(abs_top_srcdir)/sources/*.hpp
	$(ASTYLE) -n -R $(abs_top_srcdir)/sources/*.cpp
	$(ASTYLE) -n -R $(abs_top_srcdir)/tests/*.hpp
	$(ASTYLE) -n -R $(abs_top_srcdir)/tests/*.cpp
endif # HAVE_ASTYLE
