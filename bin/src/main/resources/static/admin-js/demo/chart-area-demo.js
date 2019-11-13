Highcharts.chart('container', {

    title: {
        text: null
    },
    
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },    
    yAxis: {
        title: {
            text: 'Money'
        },
	    labels: {
	        formatter: function () {
	            return this.value + '원';
	        }
	    }    
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    series: [{
        name: '수입',
        data:[
        	<%
        	for(int i=0 ; i<yearProfit.size(); i++){
        		if(i==11){
        			%><%=yearProfit.get(i)%><%
        		}
        		else{
        			%><%=yearProfit.get(i)%>,<%
        		}
        	}
        	%>
        	]
    }, {
        name: '지출',
        data: [
        	<%
        	for(int i=0 ; i<yearSpend.size(); i++){
        		if(i==11){
        			%><%=yearProfit.get(i)-yearSpend.get(i)%><%
        		}
        		else{
        			%><%=yearProfit.get(i)-yearSpend.get(i)%>,<%
        		}
        	}
        	%>
        	]
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
