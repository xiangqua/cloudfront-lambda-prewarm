#Cloudfront url: d1zi40b7x5dwgb.cloudfront.net
#Lambda function name: cloudfront_prewarm
#Need aws cli

for file in `cat file.txt`
do
echo $file
payload="{\"filename\":\"$file\",\"cloudfront_url\":\"d2qupf6sbg9i95.cloudfront.net\"}"
aws lambda invoke --function-name cloudfront_prewarm --invocation-type Event --cli-binary-format raw-in-base64-out --payload $payload o.out 
done
