<cfcomponent output="false" hint="Define application settings and event handlers.">
 
<!--- Define the application settings. --->
<cfset this.name = myApp />
<cfset this.sessionManagement = true />

<cffunction
	name="onSessionStart"
	access="public"
	returntype="void"
	output="false"
	hint="I initialize the session.">
		 
	<!--- Set up a hit count variabl --->
	<cfset session.hitCount = 0 />
	 
	<!--- Return out. --->
	<cfreturn />
</cffunction>
 
 
<cffunction
	name="onRequestStart"
	access="public"
	returntype="boolean"
	output="false"
	hint="I initialize the page request.">
		 
	<!--- Increment hit count. --->
	<cfset session.hitCount++ />
	 
	<!--- Return true so the page can process. --->
	<cfreturn true />
</cffunction>
 
  
 
</cfcomponent>