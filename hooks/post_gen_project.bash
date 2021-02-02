#!/usr/bin/env bash

autoconf_archive_github="https://raw.githubusercontent.com/autoconf-archive/autoconf-archive/master/m4"

function download_file {
    wget "$autoconf_archive_github/$1" -P "$2" > /dev/null 2>&1
    if [[ "$?" != "0" ]] ; then
	echo "post_gen_project: failed to download \"$1\""
	exit 1
    fi
}

{%- if cookiecutter.require_boost_headers == "yes" %}
download_file "ax_boost_base.m4" "m4"
{%- endif %}

{%- if cookiecutter.require_boost_iostreams == "yes" %}
download_file "ax_boost_iostreams.m4" "m4"
{%- endif %}

{%- if cookiecutter.require_boost_filesystem  == "yes" %}
download_file "ax_boost_filesystem.m4" "m4"
{%- endif %}

{%- if cookiecutter.require_boost_program_options == "yes" %}
download_file "ax_boost_program_options.m4" "m4"
{%- else %}
rm {{ cookiecutter.repo_name }}/cargs.*
{%- endif %}

{%- if cookiecutter.include_finter == "yes" %}
download_file "ax_check_zlib.m4" "m4"
cp m4/ax_check_zlib.m4 finter/m4
{%- endif %}

{%- if cookiecutter.git_tracking == "yes" %}

git init -b default > /dev/null 2>&1
git add -f {{ cookiecutter.repo_name }}/* \
    generate.bash environment.yaml \
    configure.ac {{ cookiecutter.repo_name }}.doxyfile \
    {{ cookiecutter.repo_name }}-{{ cookiecutter.version }}.pc.in \
    m4/ax* README README.md NEWS \
    Makefile.am INSTALL ChangeLog COPYING AUTHORS \
    .gitignore

{%- if cookiecutter.testing_with_TAP == "yes" %}
git add -f tap-driver.sh
{%- endif %}

{%- if cookiecutter.linting_support_for_CXX == "yes" %}
git add -f .pre-commit-config.yaml
{%- endif %}

{%- else %}
rm .gitignore
{%- endif %}

{%- if cookiecutter.testing_with_TAP == "no" %}
rm tap-driver.sh
rm -Rf tests
{%- endif %}

{%- if cookiecutter.linting_support_for_CXX == "no" %}
rm .pre-commit-config.yaml
{%- endif %}

exit 0
