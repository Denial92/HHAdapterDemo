# HHAdapterDemo
适配器学习demo

适配器模式主要有四个角色：Target、Adaptee、Adapter、Client

标抽象角色(Target) : 定义客户所期待要使用的接口，我们把手机当做客户端，客户端所需要使用充电器是大陆标准
客户端（Client）：使用目标接口，与和目标接口一致的对象合作
被适配者（Adaptee）：一个现存需要适配的接口
适配器（Adapter）：负责将Adaptee的接口转换为Target的接口

分类：适配器分为类适配器和对象适配器
因为适配器继承自被适配者，耦合性高，不建议使用，推荐使用对象适配器


