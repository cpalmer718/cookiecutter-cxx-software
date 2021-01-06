#!/bin/bash
if [[ "$#" -ne 1 ]] ; then
	echo "bump_version expects exactly one argument: the new version number"
fi

new_version_number = "$1"
current_pc_in = `ls *.pc.in`
current_version_number = `echo $current_pc_in | sed 's/{{ cookiecutter.repo_name }}// ; s/.pc.in$//'`

{%- if cookiecutter.git_tracking %}
git mv "$current_pc_in" "{{ cookiecutter.repo_name }}-$version_number.pc.in"
{%- else %}
mv "$current_pc_in" "{{ cookiecutter.repo_name }}-$version_number.pc.in"
{%- endif %}

sed -i 's/$current_pc_in/{{ cookiecutter.repo_name }}-$version_number.pc.in/' configure.ac
sed -i 's/, $current_version_number/,/, $new_version_number,/' configure.ac
rm -f "{{ cookiecutter.repo_name }}-$current_version_number.pc"

{%- if cookiecutter.git_tracking %}
git add configure.ac "{{ cookiecutter.repo_name }}-$version_number.pc.in"
git commit -m "chore: bump version"
{%- endif %}

exit 0
