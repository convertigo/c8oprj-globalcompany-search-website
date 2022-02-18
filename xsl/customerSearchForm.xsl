<?xml version="1.0" encoding="UTF-8"?>

<!--
 * Copyright (c) 2001-2011 Convertigo SA.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see<http://www.gnu.org/licenses/>.
 *
 * $URL: file:///var/svn/twinsoft/CEMS_opensource/branches/6.0.x/Studio/tomcat/webapps/convertigo/xsl/customsheet.xsl $
 * $Author: fabienb $
 * $Revision: 28392 $
 * $Date: 2011-09-28 17:03:35 +0200 (mer., 28 sept. 2011) $
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt">
	
<xsl:output encoding="UTF-8" media-type="text/html" method="html"/>

<xsl:template match="document">
	<head>
		<title>Global Company Search</title>
		<link href="css/custom.css" type="text/css" rel="stylesheet"/>
	</head>
	<body>
		<div id="centrage">
			
			<!-- header -->
			<div id="header">
				<div class="centerbloc">
					<!-- page title and subtitle -->
					<xsl:call-template name="header">
						<xsl:with-param name="subtitle">Customer Search</xsl:with-param>
					</xsl:call-template>
					
					<!-- top button (Logout) -->
					<xsl:if test="authenticated">
						<div id="loginForm">
							<form id="accountSettings" action=".cxml" method="POST">
								<input type="hidden" id="settings_sequence" name="__sequence" value="accountSettings"/>
								<input type="submit" id="settings_button" name="button" value="Account settings"/>
							</form>
							<form id="logout" action=".cxml" method="POST">
								<input type="hidden" id="logout_sequence" name="__sequence" value="logout"/>
								<input type="submit" id="logout_button" name="button" value="Logout"/>
							</form>
						</div>
					</xsl:if>
				</div>
			</div>
			
			<!-- page content -->
			<div id="content">
				<div class="centerbloc">
					<xsl:choose>
						<xsl:when test="authenticated">
							<!-- Liens -->
							<p>
								<!-- Lien back to menu -->
								<a href=".cxml?__sequence=menu" id="backToMenu">Back to menu</a>
							
								<!-- Lien Advanced search -->
						        <a href=".cxml?__sequence=searchCustomerAdvancedForm" id="advancedSearch">Advanced search</a>
							</p>
							
							<!-- search form -->
							<form id="search" action=".cxml" method="POST">
								<p><span>Keyword: </span><input type="text" id="search_keyword" name="keyword"/></p>
								<input type="submit" id="search_button" name="button" value="Search"/>
								<input type="hidden" id="search_sequence" name="__sequence" value="searchCustomer"/>
								<input type="hidden" id="search_start" name="start" value="0"/>
					        </form>
			    			<p class="info">This keyword is searched among the customers name, firstname or company names.</p>
			    			
						</xsl:when>
						<xsl:otherwise>
							<!-- error message : not authenticated -->
							<p class="erreur_message"><img src="img/exception_32x32.gif" title="Warning"/>You're not authorized to see this page. Please Log in.</p><br/>
							<form id="login" action=".cxml" method="POST">
								<input type="hidden" id="login_sequence" name="__sequence" value="loginForm"/>
								<input type="submit" id="login_button" name="button" value="Login"/>
							</form>
						</xsl:otherwise>
					</xsl:choose>
	   		 	</div> 
	    	</div>
	    	
	    	<!-- footer -->
			<div id="footer">copyright©2012. GlobalCompanySearchWebsite. Powered by Convertigo</div>
	    	
		</div>
	</body>
</xsl:template>

<!-- title and subtitle display template -->
<xsl:template name="header">
	<xsl:param name="subtitle"></xsl:param>
	<h2>Global Company Search</h2>
	<xsl:if test="$subtitle != ''">
		<h3><xsl:value-of select="$subtitle"/></h3>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>