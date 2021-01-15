#Cloudfront url: d1zi40b7x5dwgb.cloudfront.net
#Lambda function name: cloudfront_prewarm
#Need aws cli

for file in `cat file.txt`
do
echo $file
payload="{\"filename\":\"$file\",\"cloudfront_url\":\"d1zi40b7x5dwgb.cloudfront.net\"}"
aws lambda invoke --function-name cloudfront_prewarm --invocation-type Event --payload $payload o.out
done
