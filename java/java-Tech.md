#spreader Java 技术选型

##版本管理：github 

##第三方库管理：maven 2.3.1
  通过maven配置管理第三方引用jar包

##web框架：SpringMVC或Struts、Spring
  SpringMVC或Struts负责dispatch http请求，Spring负责后台框架衔接，生命周期管理，AOP等

##持久层：Mybatis
  持久层使用DAO调用Mapper来实现持久化，书写Mapper.xml来统一管理SQL

##数据存储DBMS：MySQL
  免费可依赖

##IDE: IDEA IntelliJ
  可以通过配置动态加载模块
