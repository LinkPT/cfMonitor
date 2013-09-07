<!--- List active threads --->
 
 
<!DOCTYPE HTML>
<html>
<head>
	<title>ColdFusion CFThread Listing</title>
</head>
<body>
 
	<h1>
		ColdFusion CFThread
	</h1>
	<p>	
	<cfset thr = CreateObject('java', 'java.lang.management.ManagementFactory').getThreadMXBean() >
	<cfset in = CreateObject('java', 'java.lang.Integer')>
	<cfset thrArray = thr.getThreadInfo(thr.getAllThreadIds(),in.MAX_VALUE)>
	 
<!--- 	<cfloop array="#thrArray#" index="thread">
	<CFDUMP VAR="#thread#">
		<cfdump var="#thread.getThreadName()# #thread.getThreadState()#"><BR>
<!--- 	    <cfset st = thread.getStackTrace()>
	    <cfloop array="#st#" index="stack">
		
	        <cfdump var="#thread.getThreadId()# #stack.getClassName()# - #stack.getMethodName()# - #stack.getFileName()#" /><br/>
	    </cfloop> --->
		<cfbreak>
	</cfloop>
  --->
	 
	 
 
	<cfloop array="#thrArray#" index="thread">
	    <cfset st = thread.getStackTrace()>
	    <cfloop array="#st#" index="stack">
	        <cfdump var="#thread.getThreadId()# #stack.getClassName()# - #stack.getMethodName()# - #stack.getFileName()#" /><br/>
	    </cfloop>
	</cfloop>

	</p>
 
</body>
</html>