## Build a Star Topology Using AWS VPC
### Task:
 - Create a Virtual Private Cloud (VPC) with a hub-and-spoke (star) topology.
 - Use a central EC2 instance as a router (hub) and multiple other instances (spokes) in different subnets.
### Instructions:
### Design a VPC with:
- One central EC2 instance (hub) in a public subnet.
- At least 3 EC2 instances (spokes) in separate private subnets.
- Configure the central hub to act as a NAT instance for spoke instances.
- Test connectivity by sending pings or transferring files from spoke instances via the hub.
- (Optional) Use AWS Transit Gateway instead of a NAT instance for scalable hub-and-spoke architecture.
### Objective:
- Understand the concepts of star topology.
- Learn about routing and NAT in AWS.

## Implement a Mesh Topology Using Peering Connections
### Task:
- Create a fully connected mesh network using AWS VPC peering between multiple VPCs.
### Instructions:
- Create 3-5 VPCs in different regions or availability zones.
- Establish VPC Peering between each pair of VPCs to form a fully meshed network.
- Launch EC2 instances in each VPC and configure them to communicate with each other.
- Document the routes and changes required in the route tables.
### Objective:
- Explore the concept of mesh topology and inter-VPC communication.
- Learn about VPC peering, route tables, and cross-region networking.

### Result:
### Cloud Formation template and schema:

```json
Resources:
  MyVPC:
    Type: 'AWS::EC2::VPC'
    Properties:
      CidrBlock: '10.0.0.0/16'
      EnableDnsSupport: true
      EnableDnsHostnames: true
      Tags:
        - Key: 'Name'
          Value: 'MyVPC'

  MySubnetA:
    Type: 'AWS::EC2::Subnet'
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: '10.0.1.0/24'
      AvailabilityZone: 'eu-central-1a'

  MySubnetB:
    Type: 'AWS::EC2::Subnet'
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: '10.0.2.0/24'
      AvailabilityZone: 'eu-central-1b'

  MySubnetC:
    Type: 'AWS::EC2::Subnet'
    Properties:
      VpcId: !Ref MyVPC
      CidrBlock: '10.0.3.0/24'
      AvailabilityZone: 'eu-central-1c'

  MyRouteTable:
    Type: 'AWS::EC2::RouteTable'
    Properties:
      VpcId: !Ref MyVPC
      Tags:
        - Key: 'Name'
          Value: 'MyRouteTable'

  MyInternetGateway:
    Type: 'AWS::EC2::InternetGateway'

  AttachGateway:
    Type: 'AWS::EC2::VPCGatewayAttachment'
    Properties:
      VpcId: !Ref MyVPC
      InternetGatewayId: !Ref MyInternetGateway

  MyRoute:
    Type: 'AWS::EC2::Route'
    Properties:
      RouteTableId: !Ref MyRouteTable
      DestinationCidrBlock: '0.0.0.0/0'
      GatewayId: !Ref MyInternetGateway

  SubnetARouteTableAssociation:
    Type: 'AWS::EC2::SubnetRouteTableAssociation'
    Properties:
      SubnetId: !Ref MySubnetA
      RouteTableId: !Ref MyRouteTable

  SubnetBRouteTableAssociation:
    Type: 'AWS::EC2::SubnetRouteTableAssociation'
    Properties:
      SubnetId: !Ref MySubnetB
      RouteTableId: !Ref MyRouteTable

  SubnetCRouteTableAssociation:
    Type: 'AWS::EC2::SubnetRouteTableAssociation'
    Properties:
      SubnetId: !Ref MySubnetC
      RouteTableId: !Ref MyRouteTable

  MySecurityGroup:
    Type: 'AWS::EC2::SecurityGroup'
    Properties:
      VpcId: !Ref MyVPC
      GroupDescription: 'My Security Group'
      SecurityGroupIngress:
        - IpProtocol: 'tcp'
          FromPort: 0
          ToPort: 65535
          CidrIp: '10.0.0.0/16'  # Adjust as necessary
      Tags:
        - Key: 'Name'
          Value: 'MySecurityGroup'

  EC2InstanceA:
    Type: 'AWS::EC2::Instance'
    Properties:
      InstanceType: 't2.micro'  # Change as needed
      ImageId: 'ami-0c55b159cbfafe1f0'  # Replace with a valid AMI ID for your region
      SubnetId: !Ref MySubnetA
      SecurityGroupIds:
        - !Ref MySecurityGroup
      Tags:
        - Key: 'Name'
          Value: 'InstanceA'

  EC2InstanceB:
    Type: 'AWS::EC2::Instance'
    Properties:
      InstanceType: 't2.micro'  # Change as needed
      ImageId: 'ami-0c55b159cbfafe1f0'  # Replace with a valid AMI ID for your region
      SubnetId: !Ref MySubnetB
      SecurityGroupIds:
        - !Ref MySecurityGroup
      Tags:
        - Key: 'Name'
          Value: 'InstanceB'

  EC2InstanceC:
    Type: 'AWS::EC2::Instance'
    Properties:
      InstanceType: 't2.micro'  # Change as needed
      ImageId: 'ami-0c55b159cbfafe1f0'  # Replace with a valid AMI ID for your region
      SubnetId: !Ref MySubnetC
      SecurityGroupIds:
        - !Ref MySecurityGroup
      Tags:
        - Key: 'Name'
          Value: 'InstanceC'
```

![image](./Screenshots/Task2_CloudFormationTemplate.png)

