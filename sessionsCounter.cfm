<html>
<head>
	<meta http-equiv="refresh" content="5">
</head>
<body>

<CFSET VARIABLES.tick = GetTickCount()>

<CFSCRIPT>
	function getSessions(appName) {
	    var tracker = createObject("java", "coldfusion.runtime.SessionTracker");
	    return tracker.getSessionCollection(appName);
	}
	
	variables.numSessions = 0;
	// variables.sessions = getSessions(application.applicationName);
	variables.sessions = getSessions("gttCst");		
	variables.numSessions = structCount(variables.sessions);
</CFSCRIPT>

<CFSET VARIABLES.sessionCounter = "0">
<CFSET VARIABLES.inValidSession = "0">


<!--- 
<TABLE BORDER="1" CELLPADDING="4" CELLSPACING="0">
<TR><TD>
	Client
</TD><TD>
	User
</TD><TD>
	Portal
</TD><TD>
	Res In Progress
</TD><TD>
	UrlToken
</TD><TD>
	SessionId
</TD></TR>

<CFOUTPUT>
	<!--- Loop througt all client active sessions --->
	<CFLOOP COLLECTION="#variables.sessions#" ITEM="key">
		<CFSET VARIABLES.currSession = VARIABLES.sessions[key]>
		
		<CFIF StructKeyExists(VARIABLES.currSession, "cstData") AND StructKeyExists(VARIABLES.currSession["cstData"], "sessionPortal")>
			<CFSET VARIABLES.sessionCounter = IncrementValue(VARIABLES.sessionCounter)>

			<CFSET VARIABLES.cstData = VARIABLES.currSession.cstData>
					
			<!--- Init Vars --->
			<CFSET VARIABLES.clientId = VARIABLES.cstData.cstId>
			<CFSET VARIABLES.clientPortal = VARIABLES.cstData.sessionPortal>

			<CFIF VARIABLES.clientPortal EQ "1">
				<CFSET VARIABLES.clientPortalName = "Intranet">
			<CFELSEIF VARIABLES.clientPortal EQ "2">
				<CFSET VARIABLES.clientPortalName = "Extranet">
			<CFELSEIF VARIABLES.clientPortal EQ "3">
				<CFSET VARIABLES.clientPortalName = "Internet">
			<CFELSE>
				<CFSET VARIABLES.clientPortalName = "">
			</CFIF>

			<CFIF StructKeyExists(VARIABLES.cstData, "cstName")>
				<CFSET VARIABLES.clientName = VARIABLES.cstData.cstName>
			<CFELSE>
				<CFQUERY NAME="getCstName" DATASOURCE="gttApps">
					SELECT cstName FROM customers WHERE cstId = #VARIABLES.cstData.cstId#
				</CFQUERY>

				<CFSET VARIABLES.clientName = getCstName.cstName>
			</CFIF>
								
			<CFIF StructKeyExists(VARIABLES.currSession, "res")>
				<CFSET VARIABLES.clientResInProgress = VARIABLES.currSession.res.resId>
			<CFELSE>
				<CFSET VARIABLES.clientResInProgress = "">
			</CFIF>		

						
			<CFIF StructKeyExists(VARIABLES.cstData, "pagId")>
				<CFQUERY NAME="getTprData" DATASOURCE="#VARIABLES.cstData.ds#">
					SELECT p.pagFName, p.pagLName, t.tprName
					FROM parAgents p
						INNER JOIN trvPartner t ON t.tprId = p.tprId
					WHERE p.pagId = 20
				</CFQUERY>

				<CFSET VARIABLES.usrName = "#getTprData.pagFName# #getTprData.pagLName# - #getTprData.tprName#">
				<CFSET VARIABLES.usrId = VARIABLES.cstData.pagId>			
			<CFELSE>			
				<CFSET VARIABLES.usrName = VARIABLES.cstData.iusName>
				<CFSET VARIABLES.usrId = VARIABLES.cstData.iusId>
				
				<CFIF VARIABLES.cstData.iusId EQ "0">
					<CFSET VARIABLES.usrName = "Self">
				</CFIF>
			</CFIF>

            <CFIF StructKeyExists(VARIABLES.currSession, "urltoken")>
				<CFSET VARIABLES.urltoken = VARIABLES.currSession.urltoken>
            <CFELSE>
				<CFSET VARIABLES.urltoken = "">
            </CFIF>

            <CFIF StructKeyExists(VARIABLES.currSession, "sessionid")>
				<CFSET VARIABLES.sessionid = VARIABLES.currSession.sessionid>
            <CFELSE>          
				<CFSET VARIABLES.sessionid = "">
            </CFIF>
			
			<TR><TD>
				<CFIF VARIABLES.clientId NEQ "">
					#VARIABLES.clientId# - #VARIABLES.clientName#
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD><TD>
				<CFIF VARIABLES.usrName NEQ "">
					#VARIABLES.usrName# (#VARIABLES.usrId#)
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD><TD>
				<CFIF VARIABLES.clientPortalName NEQ "">
					#VARIABLES.clientPortalName#
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD><TD>
				<CFIF VARIABLES.clientResInProgress NEQ "">
					#VARIABLES.clientResInProgress#
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD><TD>
				<CFIF VARIABLES.urltoken NEQ "">
					#VARIABLES.urltoken#
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD><TD>
				<CFIF VARIABLES.sessionid NEQ "">
					#VARIABLES.sessionid#
				<CFELSE>
					&nbsp;
				</CFIF>
			</TD></TR>
		<CFELSE>
			<CFSET VARIABLES.inValidSession = IncrementValue(VARIABLES.inValidSession)>
		</CFIF>
	</CFLOOP>
</CFOUTPUT>
</TABLE>
 --->
<CFOUTPUT>
	Total Number of Sessions: #VARIABLES.sessionCounter#<br>
	Invalid sessions: #VARIABLES.inValidSession#
</CFOUTPUT>
		
<CFSET VARIABLES.tock = GetTickCount()>
<CFSET VARIABLES.time = (VARIABLES.tock - VARIABLES.tick)>
<CFOUTPUT><br><br>time: #VARIABLES.time#</CFOUTPUT>
</body>
</html>