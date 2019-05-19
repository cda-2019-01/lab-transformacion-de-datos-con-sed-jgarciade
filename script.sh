# Escriba su código aquí
file=data.csv

# Changes format date DD/MM/YYYY to DD/MM/YY for incoming modification
sed 's/\([0-9]*\)\/\([0-9]*\)\/\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);/\1\/\2\/\5\6;/' $file |\

# Changes format date DD/M/YYYY to DD/MM/YY for incoming modification
sed 's/\([0-9]*\)\/\([0-9]*\)\/\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);/\1\/\2\/\5\6;/' |\

# Changes '\' to '-'
sed 's/\([0-9]*\)\/\([0-9]*\)\/\([0-9]*\);/\3-\2-\1;/' | \

# Fills with null any value in the first row that is not in {A,B,C,a,b,c}
sed 's/;[^A,B,C,a,b,c]{1};/;\\N;/'| \

# Fills wiht null empty fields
sed 's/;;/;\\N;/' | \

# Cast from lower to upper case
sed 's/;[a,b,c];/\U&/g' | \

# Changes the char 'n' to null
sed 's/;n/;\\N/' | \

# Changes the char '\n' to null
sed 's/;\\n/;\\N/' | \

# Changes the char 'N' to null
sed 's/;N/;\\N/' | \

# Changes comma for point as decimal separator for the last row
sed 's/;\([0-9]*\),\([0-9]\)/;\1\.\2/' | \

# Deletes rows with 5 columns discarding the last one
sed 's/;\([0-9]*\);\([0-9]*\);[0-9]*/;\1;\2/' | \

# Deletes fields with nulls
sed '/\\N/d' | \

# Changes comma for semicolon as column separator
sed 's/;/,/g' # > results.csv