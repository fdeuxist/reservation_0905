<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="../include/header.jsp"%>
<%@ page import="java.util.List, java.util.Map" %> <!-- Import required Java classes -->

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawStuff);
    google.charts.setOnLoadCallback(drawStuff2);
    google.charts.setOnLoadCallback(productVariance);
	//업체별 매출액
    function drawStuff() {
    	  var data = new google.visualization.DataTable();
          data.addColumn('string', 'Shop Name');
          data.addColumn('number', 'Revenue');
        // Convert JSP data to JavaScript array
        var shopRevenue = [
        	<% 
            List<Map<String, Object>> dtos = (List<Map<String, Object>>) request.getAttribute("dtos");
        	//System.out.println(dtos);
        	if (dtos != null) {
                for (Map<String, Object> revenue : dtos) {
                	//System.out.println(revenue);
                    String vendorName = (String) revenue.get("VENDOR_NAME");
                    Number totalServicePrice =(Number) revenue.get("TOTAL_PRICE");
            		//System.out.println("["+vendorName+","+totalServicePrice+"]");
            %>
            ['<%= vendorName %>', <%= totalServicePrice %>],
            <% 
                }
            } else { 
            %>
            ['No Data', 0]  // Default value if no data is available
            <% 
            } 
            %>
            // Add any additional static data if needed
        ];
		console.log(shopRevenue)
        data.addRows(shopRevenue);

        var options = {
            width: 480,
            legend: { position: 'none' },
            chart: {
                title: 'Shop Revenue',
                subtitle: 'Revenue by Shop'
            },
            axes: {
                x: {
                    0: { side: 'bottom', 
                    	label: 'Shop Name', 
                   		slantedText: true,
                        slantedTextAngle: 45,
                        textStyle: { fontSize: 10 }
                    } // X-axis label
                }
            },
            bar: { groupWidth: "50%" }
        };

        var chart = new google.charts.Bar(document.getElementById('top_x_div'));
        // Convert the Classic options to Material options.
        chart.draw(data, google.charts.Bar.convertOptions(options));
    	console.log(shopRevenue);
    }
    function drawStuff2() {
  	  var data = new google.visualization.DataTable();
        data.addColumn('string', 'Time Name');
        data.addColumn('number', 'Total Time');
  	
  	//예약시간 밀집도
  	var times = [
      	<% 
          List<Map<String, Object>> times = (List<Map<String, Object>>) request.getAttribute("times");
      	System.out.println(times);
      	if (times != null) {
              for (Map<String, Object> time : times) {
              	System.out.println(time);
                  String timeTerm = (String) time.get("TIMES_HHMM");
                  Number totalTimes =(Number) time.get("TIMES_TOTAL");
          		//System.out.println("["+vendorName+","+totalServicePrice+"]");
          %>
          ['<%= timeTerm %>', <%= totalTimes %>],
          <% 
              }
          } else { 
          %>
          ['No Data', 0]  // Default value if no data is available
          <% 
          } 
          %>
          // Add any additional static data if needed
      ];
		console.log(times)
      data.addRows(times);

      var options = {
          width: 480,
          legend: { position: 'none' },
          chart: {
              title: 'Booking density',
              subtitle: 'Focused reservation time'
          },
          axes: {
              x: {
                  0: { side: 'bottom', label: 'Time zone' } // X-axis label
              }
          },
          bar: { groupWidth: "80%" }
      };

      var chart2 = new google.charts.Bar(document.getElementById('top_y_div'));
      // Convert the Classic options to Material options.
      chart2.draw(data, google.charts.Bar.convertOptions(options));
  	console.log(times);
  }
    function productVariance() {
    	  var data = new google.visualization.DataTable();
          data.addColumn('string', 'product');
          data.addColumn('number', 'The number of Usage');
    	
    	//상품별 예약 수
    	var serviceNames = [
        	<% 
            List<Map<String, Object>> serviceNames = (List<Map<String, Object>>) request.getAttribute("serviceNames");
        	System.out.println(serviceNames);
        	if (serviceNames != null) {
                for (Map<String, Object> serviceName : serviceNames) {
                	System.out.println(serviceName);
                    String service = (String) serviceName.get("TOTAL_SERVICE_NAME");
                    Number amount =(Number) serviceName.get("AMOUNT");
            		//System.out.println("["+vendorName+","+totalServicePrice+"]");
            %>
            
            ['<%= service %>', <%= amount %>],
            <% 
                }
            } else { 
            %>
            ['No Data', 0]  // Default value if no data is available
            <% 
            } 
            %>
            // Add any additional static data if needed
        ];
  		console.log(serviceNames)
        data.addRows(serviceNames);
        var options = {
            width: 480,
            title: 'Product Variance',
            legend: { position: 'label'},
            pieSliceText:'label',
           chartArea: { left:50, top: 100, width: '100%', height: '60%' },
        }
        var chart3 = new google.visualization.PieChart(document.getElementById('top_z_div'));
        // Convert the Classic options to Material options.
        chart3.draw(data, options);
    	console.log(serviceNames);
    }
</script>
<style>
   .chart-container {
       display: flex;
       justify-content: space-around;
       align-items: center;
       padding:10px;
       gap: 0px;
   }
   .chart-container > div {
  		margin:auto;
       width: 500px;
       height: 500px;
   }
</style>
<div class="chart-container">
    <div id="top_x_div"></div>
    <div id="top_y_div"></div>
    <div id="top_z_div"></div>
</div>
<%@ include file="../include/footer.jsp"%>
