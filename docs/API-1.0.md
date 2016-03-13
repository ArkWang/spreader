# 接口文档
### 返回数据通用字段
| 参数   	| 数据类型	| 描述     	|
| ---------	| ---------	| ---------	|
| errorCode	| int      	| 错误码，0为succee，其他代表不同类型错误|
| errorMsg	| string   	| 错误信息，可以为空""|
| result 	| dictionary| 返回结果，可以为空{}|

##### 示例
	{"errorCode": 0,
	"errorMsg": "",
	"result": {}
	}
  
***
### 登陆 user/login
##### 参数
| 字段 		| 数据类型	| 描述 	| 是否必须 	|
| ---------	| -------- 	| -----	| ---------	|
| mobile	| string 	| 手机号	| Y		  	|
| password	| string	| 密码	| Y	      	|

##### 返回结果
| 字段  	 	| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
|sessionId 	| string   	| 用户校验id | Y			|

##### 请求示例
	user/login?mobile=18100001111&password=123456

##### 返回结果示例
	{"errorCode": 0,
	 "errorMsg": "",
	 "result": {
	 "sessionId": "abcd1234"
	 }
	}
	
***
### 重设密码 user/resetPwd
##### 参数
| 字段		| 数据类型	| 描述	| 是否必须	|
| ---------	| ---------	| -----	| ---------	|
| mobile	| string	| 手机号	| Y    		|
| password 	| string	| 密码 	| Y    		|
| code		| string 	| 验证码	| Y    		|

##### 返回结果
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| sessionId	| string	| 用户校验id	| Y			|

##### 请求示例
	user/resetPwd?mobile=18100001111&password=123456&code=233233
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {
     "sessionId": "abcd1234"
     }
    }
    
***
### 注册-发送验证码 user/registerCode
##### 参数
| 字段		| 数据类型	| 描述	| 是否必须	|
| ---------	| ---------	| -----	| ---------	|
| mobile	| string	| 手机号	| Y    		|

##### 返回结果
是否成功

##### 请求示例
	user/registerCode?mobile=18100001111
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {}
    }
    
***
### 注册 user/register
##### 参数
| 字段		| 数据类型	| 描述	| 是否必须	|
| ---------	| ---------	| -----	| ---------	|
| mobile	| string	| 手机号	| Y   	 	|
| password 	| string	| 密码 	| Y   	 	|
| code		| string 	| 验证码	| Y   	 	|

##### 返回结果
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| sessionId	| string	| 用户校验id	| Y			|

##### 请求示例
	user/register?mobile=18100001111&password=123456&code=233233
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {
     "sessionId": "abcd1234"
     }
    }

***
### 退出登陆 user/logout
##### 参数
| 字段 		| 数据类型	| 描述 	| 是否必须 	|
| ---------	| -------- 	| -----	| ---------	|
| sessionId	| string 	| 用户校验id	| Y		|

##### 返回结果
是否成功

##### 请求示例
	user/logout?sessionId=asdf1234

##### 返回结果示例
	{"errorCode": 0,
	 "errorMsg": "",
	 "result": {}
	}

***
### 列表 list/getList
##### 参数
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| sessionId	| string	| 用户校验id	| Y   	 	|
| type		| string	| 列表类型	| Y    		|
| offset 	| int		| 起始位置 	| Y    		|
| size		| int 		| 传几条数据，默认15条 | Y	|
| location	| string	| 位置信息	| N			|

> ##### type 类型定义
> ```
> 0: main
> 1: positive only
> 2: negative only
> 3: my focus
> 4: my publish
> 5: friends focus
> 6: nearby hot
> ```

##### 返回结果
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| list		| array		| 列表数据	| Y			|
| newsId	| string 	| 发言id，唯一标识一条发言 | Y |
| name		| string 	| 花名		| Y			|
| time		| string	| 发言时间	| Y			|
| isPositive | bool		| 红黑 		| Y			|
| focus		| int		| 关注数		| Y			|
| isMyFocus	| bool		| 是否已关注	| Y			|
| content 	| string	| 发言内容	| Y 		|

##### 请求示例
	list/getList?sessionId=asdf1234&type=0&offset=0&size=15
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {
     	"list": [
     		{"newsId": "1001",
     		 "name": "dog",
     		 "time": "2016.01.01",
     		 "isPositive": 1,
     		 "focus": 233,
     		 "isMyFocus": 1,
     		 "content": "i love sunrise"
     		},
     		{"newsId": "1002",
     		 "name": "cat",
     		 "time": "2016.03.10",
     		 "isPositive": 0,
     		 "focus": 23,
     		 "isMyFocus": 0,
     		 "content": "i hite dogs"
     		},
     		{"newsId": "1003",
     		 "name": "rabbit",
     		 "time": "2016.02.21",
     		 "isPositive": 1,
     		 "focus": 10,
     		 "isMyFocus": 0,
     		 "content": "i love carrot"
     		}
     	]
     }
    }

***
### 关注 list/focus
##### 参数
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| sessionId	| string	| 用户校验id	| Y	    	|
| newsId 	| string	| 发言id 	| Y	    	|
| isFocus	| bool	 	| 关注/取消关注 | Y		|

##### 返回结果
是否成功

##### 请求示例
	list/focus?sessionId=asdf1234&newsId=1001&isFocus=1
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {}
    }
    
***
### 发言 post/send
##### 参数
| 字段		| 数据类型	| 描述		| 是否必须	|
| ---------	| ---------	| ---------	| ---------	|
| sessionId	| string	| 用户校验id	| Y	    	|
| location	| string	| 位置信息	| N			|
| isPositive | bool		| 红黑 		| Y	    	|
| content	| string 	| 内容		| Y			|

##### 返回结果
是否成功

##### 请求示例
	post/send?sessionId=asdf1234&isPositive=1&content=helloworld
	
##### 返回结果示例
	{"errorCode": 0,
     "errorMsg": "",
     "result": {}
    }
    
***
