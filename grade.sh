CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

# Copy the tests files
cp ../TestListExamples.java ./
cp -r ../lib/ ./lib

if [[ ! -f ListExamples.java ]] 
then
    echo "Missing file ListExamples.java"
    exit 1
fi

javac -cp lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java

if [[ ! $? -eq 0 ]] 
then
    echo "Code did not compile"
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > results.txt
NUMTESTS=3
TEST0=`grep "testMergeRightEnd(TestListExamples)" results.txt | wc -l`
TEST1=`grep "testMergeLeftEnd(TestListExamples)" results.txt | wc -l`
TEST2=`grep "testFilter(TestListExamples)" results.txt | wc -l`
echo $TEST0 $TEST1 $TEST2
TOTALFAIL=`expr $TEST0 + $TEST1 + $TEST2`
TOTALRIGHT=`expr $NUMTESTS - $TOTALFAIL`

if [[ $TEST0 -eq 1 ]]
then
    echo "FAILED testMergeRightEnd"
fi
if [[ $TEST1 -eq 1 ]]
then
    echo "FAILED testMergeLeftEnd"
fi
if [[ $TEST2 -eq 1 ]]
then
    echo "FAILED testFilter"
fi

echo $TOTALRIGHT / $NUMTESTS tests passed

if [[ $TOTALRIGHT == 0 ]] 
then
    echo "F"
fi

if [[ $TOTALRIGHT == 1 ]]
then 
    echo "C"
fi

if [[ $TOTALRIGHT == 2 ]]
then 
    echo "B"
fi

if [[ $TOTALRIGHT == 3 ]]
then
    echo "A"
fi
exit 0
