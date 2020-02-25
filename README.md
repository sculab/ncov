# 使用和更新说明

本例使用R生成js代码，结合echarts展示疫情动态。  

其中：  
地图展示的是 **确诊人数-治愈人数-死亡人数** 的数据  
死亡率的算法：**死亡人数/(死亡人数+治愈人数)**

数据和页面更新方式：  
- 从 https://raw.githubusercontent.com/canghailan/Wuhan-2019-nCoV/master/Wuhan-2019-nCoV.csv 更新 Wuhan-2019-nCoV.csv 文件
- 更改format.r 第7行中的日期
- 运行format.r 来更新 data.js 文件
- 打开 nCoV-pc.html 即可看到效果
