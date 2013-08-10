#Benchmarking tests harness
**Mobile App Performance Challenge: Native vs. HTML5 Hybrid Apps**

The tests harness is a Ruby on Rails(RoR) application that fills three functions:

1. **A REST API on top of a Postgres database:**<br>
Executions of self-timing tests POST to the API to store the results. The RoR app POSTs to the API the CDT timeline results after processing (See below). It also has visualizations that send GET requests to the API to retrieve the self-testing or CDT timeline data.<br> 
`Note:` We created the API using rails' Scafffold generator.

2. **Processing CDT timeline JSON dump files:**<br>
The RoR app presents a view for uploading timeline JSON dump files (path: <domain>/timelines/new) to create timeline resources. Upon file upload, a helper script parses the JSON dump string to compose a digest containing only the speed metrics for each of the test iterations captured in the dump. The relevant metrics are the speeds of: style calculation, layout, paint, and total frame rendering time. Finally the composed digest is added as a JSON string to the new timeline resource in the database.

3. **Visualizations:**<br>
The RoR app has views of charts summarizing the benchmarking results data. The charts are implemented with the [Hightcharts JS](http://www.highcharts.com/) library.<br> 
**Below are the paths of the different charts:**
	- List of operations tested using the CDT timeline; each link goes to the chart of the operation's timings across all devices: ***\<domain\>/timelines/tests/all***
	- List of devices; each link goes to the chart of all operations' timings on the particular device:
***\<domain\>/timelines/devices/all***
	- List of devices tested using self-timing; each link in the user agent column goes to the charts of the results of all tests on the particular device:
***\<domain\>/environments***
	- List of tests; each link goes to the charts of the particular test's results across al devices:
***\<domain\>/selftests***



