<cfcomponent displayname="myApp cfc" output="false">
    
<!--- Login credentials to colfusion admin --->
  <!---   
    <CFSET this.user = "admin">
    <CFSET this.pass = "qwerty"> 
   
    <CFSET this.user = "gttuser">
    <CFSET this.pass = "p4t4n15c45&">
--->
<CFSET this.user = "arturg">
    <CFSET this.pass = "G0nc4lves4">
    
    
    <cfset this.error = 1>
    <cfset this.message = "message">

    <!--- Login to admin API --->
    <cffunction name="init" returntype="any" access="public">
        <cfargument name="user" type="string" required="yes">
        <cfargument name="pass" type="string" required="yes">
        
        <cftry>
            <!--- login to coldfusion administrator --->
            <cfinvoke component="cfide.adminapi.administrator" method="login" returnvariable="result">
                <cfinvokeargument name="adminuserid" value="#arguments.user#">
                <cfinvokeargument name="adminpassword" value="#arguments.pass#">
            </cfinvoke>

            <!--- update error flag --->
            <cfif result EQ true>
                 <cfset this.error = 0>
                 <cfset this.message = "User logged in">
            <cfelse>
                <cfset this.error = 1>
                 <cfset this.message = "Wrong credentials">                 
            </cfif>

            <cfcatch type = "all">
                <!--- catch error --->
                <cfset this.error = 1>
                <cfset this.message = "There was an error with the request">
            </cfcatch>
        </cftry>

        <!--- return self --->
        <cfreturn this>
    </cffunction>

    <!--- Login to admin API usgin the default login --->
    <cffunction name="initDefault" returntype="any" access="public">
        <cftry>
            <!--- login to coldfusion administrator --->
            <cfinvoke component="cfide.adminapi.administrator" method="login" returnvariable="result">
                <cfinvokeargument name="adminuserid" value="#this.user#">
                <cfinvokeargument name="adminpassword" value="#this.pass#">    
            </cfinvoke>

            <!--- update error flag --->
            <cfif result EQ true>
                 <cfset this.error = 0>
                 <cfset this.message = "User logged in">
            <cfelse>
                <cfset this.error = 1>
                 <cfset this.message = "Wrong credentials  #result#">                 
            </cfif>

            <cfcatch type = "all">
                <!--- catch error --->
                <cfset this.error = 1>
                <cfset this.message = "There was an error with the request">
            </cfcatch>
        </cftry>
        <!--- return self --->
        <cfreturn this>        
    </cffunction>
 
    <!--- servermonitoring functions --->

    <cffunction name="getSessionCount" returntype="any" access="public">
        <!--- Returns the number of current sessions on the server --->
        <cfinvoke component="cfide.adminapi.servermonitoring" method="getActiveSessionCount" returnvariable="result">
        
        <cfset this.out = "Total session count: #result#">        

        <cfreturn this.out>        
    </cffunction>   


    <cffunction name="getActiveSessions" returntype="any" access="public">
        <!--- Returns details of all active sessions --->
        <cfinvoke component="cfide.adminapi.servermonitoring" method="getActiveSessions" returnvariable="result">
 
        <cfreturn result>        
    </cffunction>   


    <cffunction name="getAverageResponseTime" returntype="any" access="public">
        <!--- Returns average response time the for server --->
        <cfinvoke component="cfide.adminapi.servermonitoring" method="getAverageResponseTime" returnvariable="result">
 
        <cfreturn "Average response time: #result#">
        
    </cffunction>

    <cffunction name="getMemory" returntype="any" access="public">
        <!--- Returns a summary of memory utilization across the different scopes  --->
        <cfinvoke component="cfide.adminapi.servermonitoring" method="getMemoryUtilizationSummary" returnvariable="result">
 
        <cfreturn result>        
    </cffunction>  
 
    <cffunction name="getLoggedInuserCount" returntype="any" access="public">
        <!--- Returns the number of concurrent users logged in via CFLOGINUSER --->
        <cfinvoke component="cfide.adminapi.servermonitoring" method="getLoggedInuserCount" returnvariable="result">
 
        <cfreturn "logged in users: #result#">
    </cffunction>  

    <!--- data source functions --->

    <cffunction name="getDataSources" returntype="array" access="public">
     
        <!--- Returns a structure containing all data sources --->
        <cfinvoke component="cfide.adminapi.datasource" method="getDataSources" returnvariable="dataSources">

        <cfset variables.dsarray = []>
        <!--- create an array from the structure --->
        <cfloop collection="#dataSources#" item="key">            
            <cfset arrayappend(variables.dsarray, dataSources["#key#"]["name"]) />
        </cfloop>
        
        <!--- sort array --->
        <cfset arraysort(variables.dsarray, "text") />

        <cfreturn variables.dsarray />
    </cffunction>

    <cffunction name="getQuery" returntype="any" access="public">
        <cftry>
            <!--- query cold fusion demo data bases --->
            <cfquery name="getMessages" datasource="cfdocexamples">
                select SUBJECT, *
                from messages
            </cfquery>
            <!--- build xml object --->
            <cfxml variable="xmlObject" casesensitive="yes">
                <root>
                    <output query="getMessages">
                        <messages>#SUBJECT#</messages>
                    </output>
                </root>
            </cfxml> 
 
            <cfcatch type = "database">
                <!--- threat error... just return empty string --->
                <cfset variables.xmlObject = "">
            </cfcatch>
        </cftry>
        <!--- return --->
        <cfreturn variables.xmlObject>
    </cffunction>

 

    <CFSCRIPT>
        function getSessions(appName) {
            var tracker = createObject("java", "coldfusion.runtime.SessionTracker");
            return tracker.getSessionCollection(appName);
        }
      </CFSCRIPT>  
      <!--- 
              variables.numSessions = 0;
              // variables.sessions = getSessions(application.applicationName);
              variables.sessions = getSessions("gttCst");     
              variables.numSessions = structCount(variables.sessions);
          
       --->
 



</cfcomponent>