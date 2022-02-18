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
						<xsl:with-param name="subtitle">Account settings</xsl:with-param>
					</xsl:call-template>
					
					<!-- top button (Logout) -->
					<xsl:if test="authenticated">
						<div id="loginForm">
							<form id="searchMenu" action=".cxml" method="POST">
								<input type="hidden" id="searchMenu_sequence" name="__sequence" value="menu"/>
								<input type="submit" id="searchMenu_button" name="button" value="Search menu"/>
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
							<p>
								<!-- Lien back to Account settings -->
								<a href=".cxml?__sequence=accountSettings" id="backToAccountSettings">Back to account settings</a>
							</p>
								
							<!-- Content title -->
							<h3>Details of user "<xsl:value-of select="inputVars/username"/>"</h3>
							
							<!-- page content with data -->
							<xsl:apply-templates/>
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

<!-- content template for employee data -->
<xsl:template match="employee">
	<div id="employee_{@id}" class="employeeResult">
		<p class="name"><span class="title">Name: </span><xsl:value-of select="name"/></p>
		<p class="firstname"><span class="title">Firstname: </span><xsl:value-of select="firstname"/></p>
		<p class="email"><span class="title">Email: </span><xsl:value-of select="email"/></p>
		<p class="department"><span class="title">Department: </span><xsl:value-of select="department"/></p>
	</div>
	<br/>
</xsl:template>

<!-- elements that do not have to be displayed -->
<xsl:template match="inputVars"></xsl:template>
<xsl:template match="authenticated"></xsl:template>

<!-- message display template -->
<xsl:template match="message">
	<p class="message"><xsl:value-of select="."/></p><br/>
</xsl:template>

<!-- error message display template -->
<xsl:template match="erreur">
	<p class="erreur_message"><img src="img/exception_32x32.gif" title="Warning"/><xsl:value-of select="."/></p><br/>
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