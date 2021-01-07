# cloudfront_prewarm
cloudfront prewarm scripts


# use shell script to invoke lambda function prewarm cloudfront

# cat a.txt

/www/a.txt

/www/b.txt

/www/c.txt

# cat prewarm.sh

for file in `cat a.txt`

do

echo $file

payload="{\"filename\":\"$file\",\"cloudfront_url\":\"d1zi40b7x5dwgb.cloudfront.net\"}"

aws lambda invoke --function-name cloudfront_prewarm --invocation-type Event --payload $payload o.out

done

# deployment lambda function 
cloudfront_prewarm.py

# setup lambda 
memory 500M~
timeout 15m

