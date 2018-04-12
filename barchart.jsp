<!DOCTYPE html>
<head>
<meta charset="utf-8">
    <%@ page import= "Servletwright.servlet,net.sf.json.JSONArray,
net.sf.json.JSONObject;"%>
<title>Charts</title>
</head>
<body>
	<canvas id="myChart" style="width:74px; height:20px"></canvas>
	<script src="Chart.js"></script>
	<script src="jquery-3.2.1.js"></script>
	<script src="esl.js"></script>
	<script type="text/javascript">
	function drawLineChart() {

	      // 格式化时间数据
	     Date.prototype.formatMMDDYYYY = function() {
	          return (this.getMonth() + 1) +
	          "/" +  this.getDate() +
	          "/" +  this.getFullYear();
	      } 
	      //使用Ajax获取json数据
	      var jsonData = $.ajax({
	        url: 'http://localhost:8080/danpianji/Servletwright.servlet',
	        dataType: 'json',

	      }).done(function (results) {

	    // 将获取到的json数据分别存放到两个数组中
	        var labels = [], data=[];
	       // alert(results);
	        for(var one in results)
	        {
	          //labels.push(results[one].myid);
	          // labels.push(new Date(results[one].currenttime).formatMMDDYYYY());
	           labels.push(results[one].currenttime);
	            data.push(parseFloat(results[one].voltage));
	        } 
	        
	        
	      

	        // 设置图表的数据
	        var tempData = {
	          labels : labels,
	          datasets : [{
	              label: "voltage",
	                fill: true,
	                lineTension: 0.1,
	                backgroundColor: "rgba(75,192,192,0.4)",
	                borderColor: "rgba(75,192,192,1)",
	                borderCapStyle: 'butt',
	                borderDash: [],
	                borderDashOffset: 0.0,
	                borderJoinStyle: 'miter',
	                pointBorderColor: "rgba(75,192,192,1)",
	                pointBackgroundColor: "#fff",
	                pointBorderWidth: 1,
	                pointHoverRadius: 5,
	                pointHoverBackgroundColor: "rgba(75,192,192,1)",
	                pointHoverBorderColor: "rgba(220,220,220,1)",
	                pointHoverBorderWidth: 2,
	                pointRadius: 1,
	                pointHitRadius: 10,
	                data: data,
	                spanGaps: false,
	          }]
	        };

	        // 获取所选canvas元素的内容
	        var ctx = document.getElementById("myChart").getContext("2d");
	        //设置图表高度
	        ctx.height=9;                                  
	        // 初始化一个新的雷达图
	        var myLineChart = new Chart(ctx, {
	            type: 'radar', 
	            data: tempData,
	            options: {
	                maintainAspectRatio: true,
	            }
	        });
	      });
	      
	    }
	drawLineChart();
	/* function myrefresh()
	{
	window.location.reload();

	}
	setTimeout('myrefresh()',5000); //指定5秒刷新一次 */
	    </script>
	
</body>
