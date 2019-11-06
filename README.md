# AWS에서 Lambda 이용하여 EC2 Stop

### **CDK** 버전의 현대 애플리케이션 구축 워크샵에 오신걸 환영합니다!

### 애플리케이션 아키텍처

![Application Architecture](/images/Lambda_EC2_Stop.png)

EC2 서버의 상태를 확인(running)하여 정한 시간(Cron 이용)에 Stopped.
이용한 기능 : IAM(정책, 역할), Lambda, CloudWatch, 

## 워크샵 시작

### [모듈 1 진행](/module-1)


### IAM 정책 생성

### IAM 역할 생성

### Lambda 함수 생성

## 전체 EC2에 대해 상태를 stop으로 변경하는 함수
## lambda_function.py
import json
import boto3
ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    print(event)
    ec2.Instance(event["detail"]["instance-id"]).stop()
    print("Instnace ID: "+event["detail"]["instance-id"]+" Stopped!")
    

### CloudWatch Event 생성



[모듈 1 진행](/module-1)



