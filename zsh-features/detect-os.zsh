# Detect OS and export the OS Type for subsequent processes
UNAME_OUTPUT=$(uname -s)
case "$UNAME_OUTPUT" in
  Linux*)   OS=LINUX;;
  Darwin*)  OS=DARWIN;;
  *)        OS=UNSUPPORTED;;
esac

export OS
