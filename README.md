# 利用Lambda进行Amazon CloudFront预热

## Amazon CloudFront介绍
Amazon CloudFront 是一项快速内容分发网络 (CDN) 服务，可以安全地以低延迟和高传输速度向全球客户分发数据、视频、应用程序和 API，全部都在开发人员友好的环境中完成。Amazon CloudFront 可以大幅扩容，并在全球范围内分布。CloudFront 网络拥有 225 个以上的存在点 (PoP)，这些存在点通过 AWS 主干网相互连接，为最终用户提供超低延迟性能和高可用性。

## 为什么需要预热
通过预热功能，您可以强制CDN节点回源并获取最新文件。通过预热功能您可以在业务高峰前预热热门资源，提高资源访问效率。通过本文您可以了解预热功能的配置方法。

## 功能简介
通过Lambda可以帮助您分批进行预热任务，对比本地脚本的方式，可以异步、高并发执行预热任务，也可以很容易的结合CI/CD平台提交预热作业。当您指定预热URL列表文件后，本地shell脚本读取文件列表中需要预热的文件，并发提交到Lambda进行预热，对于有需要大批量文件的预热任务可以更高效的完成。

•	预热的文件过多，本地提交效率低。

•	本地部署脚本提交预热任务，运维成本高。

## 使用说明
### 1、	创建预热资源列表
在文件列表中，加入需要预热的文件URL，假设你有三个文件需要预热，则在file.txt里面填入如下内容
```Bash
/www/a.txt

/www/b.txt

/www/c.txt
```

### 2、	在Lambda中部署预热脚本
2.1 在控制台选择创建创建函数

2.2 填入函数名称，例如：cloudfront_prewarm

2.3 运行时：选择python3.7

2.4 点击创建函数

2.5 在函数代码区域，将代码库中的cloudfront_prewarm.py内容替换lambda_function.py的内容

2.6 在基本设置中，根据实际情况编辑内存大小，例如500M，超时时间设为15分钟

2.7 完成lambda函数创建

### 3、	编写本地调度脚本
编写触发脚本，脚本中需要根据实际情况，修改CloudFront分配中提供的内置域名，如d1zi40b7x5dwgb.cloudfront.net，填入部署的lambda函数名称

### 4、	执行本地脚本开始预热并查看日志
```Bash
sh cf_prewarm.sh 
```
预热的日志可以在cloudwatch log中查看，当看到

```Bash
SUCCESS: POP:EWR50-C1 FILE:http://d1zi40b7x5dwgb.EWR50-C1.cloudfront.net/www/a.txt
```

代表在EWR50-C1的PoP点上已经预热成功

### 5、	备注
第三方CloudFront pop点列表 https://www.feitsui.com/zh-hans/article/3


