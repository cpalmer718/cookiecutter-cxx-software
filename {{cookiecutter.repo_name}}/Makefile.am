bin_PROGRAMS = {{ cookiecutter.repo_name }}.out

AM_CXXFLAGS = {%- if cookiecutter.include_finter == "yes" %} -I$(srcdir)/finter -I$(srcdir)/finter/include {%- endif %} {%- if cookiecutter.require_boost_headers == "yes" %} $(BOOST_CPPFLAGS) {%- endif %} -ggdb -Wall -std=c++17

{{ cookiecutter.repo_name }}_out_SOURCES = {%- if cookiecutter.require_boost_program_options == "yes" %} {{ cookiecutter.repo_name }}/cargs.cc {{ cookiecutter.repo_name }}/cargs.h {%- endif %} {{ cookiecutter.repo_name }}/main.cc
{{ cookiecutter.repo_name }}_out_LDADD = {%- if cookiecutter.require_boost_headers == "yes" %} $(BOOST_LDFLAGS) {%- endif %} {%- if cookiecutter.include_finter == "yes" %} -lfinter -lz -lbz2 {%- endif %} {%- if cookiecutter.require_boost_program_options == "yes" %} -lboost_program_options {%- endif %} {%- if cookiecutter.require_boost_filesystem == "yes" %} -lboost_system -lboost_filesystem {%- endif %} {%- if cookiecutter.require_boost_iostreams == "yes" %} -lboost_iostreams {%- endif %} {%- if cookiecutter.require_yaml_cpp == "yes" %} -lyaml-cpp {%- endif %}
dist_doc_DATA = README
ACLOCAL_AMFLAGS = -I m4
{%- if cookiecutter.testing_with_TAP == "yes" %}
## TAP support
TEST_LOG_DRIVER = env AM_TAP_AWK='$(AWK)' $(SHELL) \
                  $(top_srcdir)/tap-driver.sh
TESTS = tests/placeholder.test
EXTRA_DIST = $(TESTS)
{%- endif %}
