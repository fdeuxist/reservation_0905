<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ include file="../include/header.jsp"%>
<%@ page import="java.util.List, java.util.Map" %> <!-- Import required Java classes -->

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuff);
    google.charts.setOnLoadCallback(drawStuff2);

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
            width: 300,
            legend: { position: 'none' },
            chart: {
                title: 'Shop Revenue',
                subtitle: 'Revenue by Shop'
            },
            axes: {
                x: {
                    0: { side: 'bottom', label: 'Shop Name' } // X-axis label
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
  	
  	//시간대 차트
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
          width: 300,
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
          bar: { groupWidth: "50%" }
      };

      var chart2 = new google.charts.Bar(document.getElementById('top_y_div'));
      // Convert the Classic options to Material options.
      chart2.draw(data, google.charts.Bar.convertOptions(options));
  	console.log(times);
  }
</script>
<style>
	#top_x_div{margin:60px}
	#top_y_div{margin:60px,
			
	}
</style>
<div id="top_x_div" style="width: 500px; height: 300px;"></div>
<div id="top_y_div" style="width: 500px; height: 300px;"></div>
<%@ include file="../include/footer.jsp"%>
