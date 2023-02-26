echo Fix isEmpty

sed -i 's/bool isEmpty() {/bool get isEmpty {/' "..\..\..\GitHub\dotlin\packages\dotlin\lib\src\kotlin\ranges\range.dt.g.dart"
sed -i 's/@override bool isEmpty() {/@override bool get isEmpty {/' "..\..\..\GitHub\dotlin\packages\dotlin\lib\src\kotlin\ranges\ranges.dt.g.dart"
sed -i 's/\.isEmpty()/\.isEmpty/g' "..\..\..\GitHub\dotlin\packages\dotlin\lib\src\kotlin\ranges\ranges.dt.g.dart"
sed -i 's/\.isEmpty()/\.isEmpty/g' "..\..\..\GitHub\dotlin\packages\dotlin\lib\src\kotlin\ranges\ranges_ext.dt.g.dart"
