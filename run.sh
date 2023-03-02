set -e
javac -cp lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar GradeServer.java Server.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar GradeServer $1