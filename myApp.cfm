<cfsetting showdebugoutput="no">


<!--- Check if user is logged in --->
<cfif isDefined("form") AND StructKeyExists(form, "user") >

    <!--- login to cfadminitrator using user logIn --->
    <cfset variables.obj = CreateObject("component", "myApp").init( form.user, form.pass )>

    <!--- If login was successfull create session login --->
    <cfif variables.obj.error EQ 1>
        <cfset session.login = structNew()>
        <cfset session.login.user = form.user>
        <cfset session.login.pass = form.pass>
    </cfif>

<cfelse> 
    <CFTRY>
      
        <!--- Init component using default user and pass --->
        <cfset variables.obj = CreateObject("component", "myApp").initDefault()>
        <!--- 
        <CFSET variables.sessions =  CreateObject("component", "myApp").getSessions("gttCst")  >
        <CFSET  variables.numSessions = structCount(variables.sessions) >
        <CFDUMP var="# variables.numSessions #" />
         --->

        <!--- Wrong credentials --->
        <CFIF variables.obj.error neq "0" >
            Wrong credentials
            <br><CFDUMP var="#variables.obj.error#" />
            <br><CFDUMP var="#variables.obj.message#" />
            <cfabort />
        </CFIF>

        <CFCATCH TYPE="Any">
            error
            <cfabort />    
        </CFCATCH>
    </CFTRY>

</cfif>   



<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Project</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Bootstrap css -->
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <!--- enable responsive --->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">

        <style type="text/css"> 
            #sessionDetails {
                display: none;
            }
        </style>
        
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {
                
                //event hadlers
                $( "#queryBtn" ).click(function() {
                    request();
                });
                $( "#sessionBtn" ).click(function() {
                    showSessionDetails();
                }); 
            });

            //request example...
            function request(){
                $.ajax({
                    url: 'myApp_ajax.cfm',
                    type: 'GET',
                    dataType: 'xml',
                    data: "",
                    success: function(xmlObj) {
                        //called when successful
                        var text = $(xmlObj).find('messages').text();
                        //populate div
                        $("#queryDetails").html( text );                        
                    },
                    error: function(xhr, textStatus) {
                        //called when there is an error                        
                        alert("There was an error with your request");
                    }
                });
            }

            //show hide function
            function showSessionDetails(){
                if( $("#sessionDetails").css("display") == "none"){
                    $("#sessionDetails").show("slow");
                    $("#sessionBtn").html("Hide Details");

                }else{
                    $("#sessionDetails").hide("slow");
                    $("#sessionBtn").html("Show Details");
                }
            }
        </script>
    </head>
    <body>
        <!--- header menu --->
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="brand" href="#">myApp</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <li class="active"><a  href="#home">Home</a></li>
                            <li><a href="#about">About</a></li>
                            <li><a href="#contact">Contact</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Projects <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Web...</a></li>
                                    <li><a href="#">Mibile...</a></li>
                                    <li><a href="#">Something else here</a></li>
                                    <li class="divider"></li>
                                    <li class="nav-header">Mobile</li>
                                    <li><a href="#">Android</a></li>
                                    <li><a href="#">Arduino</a></li>
                                    <li><a href="#">RaspBery Pi</a></li>
                                </ul>
                            </li>
                        </ul>                        
                        <!--- Login form --->
                        <form id="login" class="navbar-form pull-right" METHOD="POST" ACTION="myApp.cfm">
                            <input name="user" type="text" placeholder="Email">
                            <input name="pass" type="password" id="inputPassword" class="input-medium" required="required" data-error="Please give a correct password." placeholder="Password">
                            <button type="submit" class="btn">logIn</button>
                        </form>
                    </div>
                </div>
            </div>
        </div><!--- /.navbar --->
 

        <!--- main data container --->
        <div class="container">

            <CFIF variables.obj.error eq "1">
                <div class="hero-unit" id="home" >
                    <h1>ColdFusion Server Management</h1>
                    <p>Plesse Log in</p>
                    <p><CFOUTPUT>#variables.obj.message#</CFOUTPUT></p>
                </div>

            <cfelse>

                <div class="hero-unit" id="home" >
                    <h1>ColdFusion Server Management</h1>
                    <p>Access ColdFusion Administrator task through the Administrator API </p>
                    <p>In development.....</p>
                </div>
                <div class="row">
                    <div class="span4">
                        <div class="well">
                            <h2>Total Session count</h2>
                            <p>
                                <!--- Call component function --->
                                <CFOUTPUT>#variables.obj.getSessionCount()#</CFOUTPUT>
                            </p>
                            <p>
                            <!-- Button to trigger modal -->
                            <a id="sessionBtn" role="button" class="btn">View details &raquo;</a>
                          </p>
                        </div>
                    </div>

                    <div class="span4">
                        <div class="well">
                            <h2>Average Response Time</h2>
                            <p>
                                <!--- Call component funcion --->
                            <CFOUTPUT>#variables.obj.getSessionCount()#</CFOUTPUT>
                            </p>
                        </div>
                    </div>

                    <div class="span4">
                        <div class="well">
                          <h2>Memory Utilization</h2>
                            <p>
                              <!-- Button to trigger modal -->
                              <a href="#myModal" role="button" class="btn" data-toggle="modal">View details &raquo;</a>
                            </p>          
                        </div>
                    </div>                  
                </div>
                <hr>

                <!--- query dump --->
                <div class="panel">
                    <div class="panel" id="queryDetails"></div>
                </div>

                <!--- hidden div --->
                <div class="row" id="sessionDetails"> 
                    <h2>Session Details</h2>                
                    <!--- get active sessions --->
                    <cfset variables.activeSessions = variables.obj.getActiveSessions()>
                    <CFOUTPUT>
                        <cfloop from="1" to="#arraylen(variables.activeSessions)#" index="currsession">
                            <div class="span4">
                                <div class="well">
                                    <p>
                                        <ul>
                                            <li>IP: #variables.activeSessions[currsession].clientipaddress#</li>
                                            <li>Elapsed Time: #int( variables.activeSessions[currsession].elapsedtime / 1000 / 60 )#m</li>
                                            <li>Session Size: #variables.activeSessions[currsession].sessionsize#</li>
                                        </ul>
                                    </p>
                                   
                                </div>
                            </div>
                        </cfloop>
                   </CFOUTPUT>
                </div>


            </CFIF>


           
    
        </div><!--end .container --> 

        <!-- Modal tool-tips-->
        <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
              <h3 id="myModalLabel">Memory Utilization</h3>
            </div>
            <div class="modal-body">
                <p><h4>Scopes</h4>
                    <!--- get memory statistics  --->
                    <cfset variables.memorydump = variables.obj.getMemory()>
                    <CFOUTPUT> 
                        <ul>
                            <li>Application: #variables.memorydump.applicationscopessize#</li>
                            <li>Server: #variables.memorydump.serverscopesize#</li>
                            <li>Sessions: #variables.memorydump.sessionscopessize#</li>
                        </ul>
                     </CFOUTPUT>
                </p>
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
        
    </body>
</html>