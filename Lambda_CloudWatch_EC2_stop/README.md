# AWS에서 Lambda 이용하여 EC2 Stop

### 애플리케이션 아키텍처

![Lambda_EC2_Stop](/Image/Lambda_EC2_Stop.PNG)

EC2 서버의 상태를 확인(running)하여 정한 시간(Cron 이용)에 Stopped.
이용한 기능 : IAM(정책, 역할), Lambda, CloudWatch

## 자동화 실행 과정
구현이 완료 되었을 때, 다음의 절차대로 자동화가 실현이 됩니다.
1. EC2 인스턴스가 Running 상태
2. 상태 변화를 Cloudwatch Event로 전송
3. Cloudwatch Event는 해당 이벤트가 발생하면 사전에 정의된 규칙에 따라 Lambda를 실행
4. Lambda는 event 인자를 확인하여 해당 EC2 함수 시작

## 자동화구현과정
자동화를 구현하기 위해서는 아래의 절차대로 진행한다.
1. Lambda가 EC2를 실행할 수 있는 IAM 역할 생성
2. EC2를 시작하는 Lambda 생성
3. Cloudwatch Event에서 EC2가 정해진 시간에 맞춰 실행되는 규칙 작성
4. 테스트 인스턴스 생성 후 또는 기존에 있는 인스턴스의 Running 상태 확인
5. 시간에 맞춰 중단 되는 것 확인
6. Cloudwatch Logs를 통해 Lambda의 수행 확인 및 실행 시간 확인

### IAM 정책 생성
## IAM Policies에서 Create policy
- Service : Ec2
- Action : Write의 StopInstance
- Resources : All Resources

### IAM 역할 생성
## Role 생성
- Type : AWS Service
- Service : Lambda
- Policies : AWSLambdaBasicExcutionRole, EC2_Stop(위에서 만든 stop 정책)

### Lambda 함수 생성
## Function 생성
- Runtime : Python3.7
- Role : 위에서 만든 역할

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
## Rule 생성
1. Service Name: EC2
2. Event Type: ”EC2 Instance State-change Notification”
3. Specific state(s): Running
Targets에서는 Lambda function을 선택하고 Function은 앞단계에서 생성한 Function을 선택


[모듈 1 진행](/module-1)



