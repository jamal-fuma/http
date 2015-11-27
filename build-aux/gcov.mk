if HAVE_GCOV
.PHONY: clean-gcda
clean-gcda:
	@echo Removing old coverage results
	-find $(abs_top_builddir) -name '*.gcda' -print | xargs -r rm
	-find $(abs_top_builddir) -name '*.gcno' -print | xargs -r rm

.PHONY: coverage-html generate-coverage-html clean-coverage-html coverage_base.info coverage_delta.info coverage.info
coverage-html:
	-$(MAKE) $(AM_MAKEFLAGS)
	$(MAKE) $(AM_MAKEFLAGS) coverage_base.info
	-$(MAKE) $(AM_MAKEFLAGS) -k check
	$(MAKE) $(AM_MAKEFLAGS) coverage_delta.info
	$(MAKE) $(AM_MAKEFLAGS) generate-coverage-html

coverage_base.info:
	@echo Collecting baseline coverage data
	$(LCOV) \
		--gcov-tool $(GCOV) \
		--capture \
		--initial \
		-b $(abs_top_builddir) \
		--directory $(abs_top_builddir) \
		--output-file $(abs_top_builddir)/coverage_base.info \
		--compat-libtool


	@echo Stripping external coverage data from baseline
	$(LCOV) \
		--remove $(abs_top_builddir)/coverage_base.info \
		"/usr*" \
		"/opt*" \
	-o $(abs_top_builddir)/coverage_base.info

coverage_delta.info:
	@echo Collecting delta coverage data
	$(LCOV) \
		--gcov-tool $(GCOV) \
		--capture \
		-b $(abs_top_builddir) \
		--directory $(abs_top_builddir) \
		--output-file $(abs_top_builddir)/coverage_delta.info \
		--compat-libtool

	@echo Stripping external coverage data from delta
	$(LCOV) \
		--remove $(abs_top_builddir)/coverage_delta.info \
		"/usr*" \
		"/opt*" \
		-o $(abs_top_builddir)/coverage_delta.info

coverage.info:
		@echo Combining baseline and delta coverage data
		$(LCOV) \
		-a $(abs_top_builddir)/coverage_base.info \
		-a $(top_builddir)/coverage_delta.info \
		-o $(top_builddir)/coverage.info

generate-coverage-html: coverage.info

	LANG=C++ $(GENHTML) \
		 --prefix $(abs_top_builddir) \
		 --output-directory $(abs_top_builddir)/coveragereport \
		 --title "Code Coverage from $(fuma_ax_build_label)" \
		 --legend \
		 --demangle-cpp \
		 --show-details \
		 $(top_builddir)/coverage.info

clean-coverage-html: clean-gcda
	-$(LCOV) --directory $(top_builddir) -z
	-rm -rf \
		$(top_builddir)/coverage.info \
		$(top_builddir)/coverage_base.info \
		$(top_builddir)/coverage_delta.info \
		$(top_builddir)/coveragereport

clean-local: clean-coverage-html
endif # HAVE_GCOV
