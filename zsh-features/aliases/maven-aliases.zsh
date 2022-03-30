# Maven Aliases
alias mcc='mvn clean compile $*'
alias mcv='mvn clean verify $*'
alias mci='mvn -q clean install $*'
alias mcic='mvn -DskipSonarQualityCheck=true -Dcheck.failsOnError=false -Dskip.unit.tests=false -Dfindbugs.excludeFilterFile=quality/findbugs-exclude-rules.xml -Dopenjpa.Log=none -Dskip.integration.tests=false -Dcheck.failsOnViolation=false -DskipSonarCoverageCheck=false -Dmaven.test.failure.ignore=true -DskipWithOpenJPAEnhancer=false clean dependency:copy-dependencies install'
alias mcist='mvn -q clean install -DskipTests $*'
alias mt='mvn test $*'
alias mval='mvn validate $*'
alias mvv='mvn validate $*'
alias mvnv='mvn versions:set $*'
alias mvnvc='rm **/*.versionsBackup'
alias mdt='mvn dependency:tree'

# Special Maven Alaises
alias mqd='mvn quarkus:dev'

