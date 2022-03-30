if [[ $OS == "DARWIN" ]];
then
  alias wifi='networksetup -setairportpower airport $*'

  alias pwdc='pwd|pbcopy'

  alias java6='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 1.6`'
  alias java7='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 1.7`'
  alias java8='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 1.8`'
  alias java9='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 9`'
  alias java11='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 11`'
  alias java15='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 15`'
  alias java16='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 16`'
  alias java16='unset JAVA_HOME; export JAVA_HOME=`/usr/libexec/java_home -v 17`'

fi
