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
						<xsl:with-param name="subtitle">
							<xsl:choose>
								<xsl:when test="authenticated">Menu</xsl:when>
								<xsl:otherwise>Login</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
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
						<!-- message display + menu -->
							<xsl:if test="@sequence = 'loginForm'">
								<p class="message">Welcome '<xsl:value-of select="authenticated"/>', you are already logged in.</p>
							</xsl:if>
							<xsl:if test="@sequence = 'login'">
								<p class="message">Welcome '<xsl:value-of select="authenticated"/>', you are now logged in.</p>
							</xsl:if>
							<xsl:call-template name="menu"/>
						</xsl:when>
						<xsl:otherwise>
						<!-- login form and possibly error message -->	
							<xsl:apply-templates/>
								
							<!-- login form -->
							<form id="login" action=".cxml" method="POST">
								<p><span>Username: </span><input type="text" id="login_username" name="username"/></p>
								<p><span>Password: </span><input type="password" id="login_password" name="password"/></p>
							    <input type="submit" id="login_button" name="button" value="Login"/>
								<input type="hidden" id="login_sequence" name="__sequence" value="login"/>
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

<!-- error message display template -->
<xsl:template match="erreur">
	<p class="erreur_message"><img src="img/exception_32x32.gif" title="Warning"/><xsl:value-of select="."/></p><br/>
</xsl:template>

<!-- elements that do not have to be displayed -->
<xsl:template match="inputVars"></xsl:template>

<!-- title and subtitle display template -->
<xsl:template name="header">
	<xsl:param name="subtitle"></xsl:param>
	<h2>Global Company Search</h2>
	<xsl:if test="$subtitle != ''">
		<h3><xsl:value-of select="$subtitle"/></h3>
	</xsl:if>
</xsl:template>

<!-- menu display template -->
<xsl:template name="menu">
	<div id="menu">
		<a href=".cxml?__sequence=searchCustomerForm" id="menuCustomerSearch" class="menuItem">Customer Search</a>
		<a href=".cxml?__sequence=searchBusinessForm" id="menuBusinessSearch" class="menuItem">Business Search</a>
	</div>
</xsl:template>

</xsl:stylesheet>