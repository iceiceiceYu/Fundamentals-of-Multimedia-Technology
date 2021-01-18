# based on macOS or Linux
# if permission denied, try 'chmod 777 auto_test.sh'

make clean
make

./cjpeg

cjpeg -outfile test.jpeg test.bmp
echo "Successfully changed test.bmp to jpeg format!"

cjpeg -outfile test2.jpeg test2.bmp
echo "Successfully changed test2.bmp to jpeg format!"
