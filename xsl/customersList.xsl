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
	<!-- variables declaration to be used in pagination -->
	<xsl:variable name="prevStart" select="number(inputVars/start) - 3"/>
	<xsl:variable name="nextStart" select="number(inputVars/start) + 3"/>
	
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
							<p>
								<!-- Lien back to menu -->
								<a href=".cxml?__sequence=menu" id="backToMenu">Back to menu</a>
							
								<!-- Lien back to search -->
								<xsl:choose>
									<xsl:when test="inputVars/name">
										| <a href=".cxml?__sequence=searchCustomerAdvancedForm" id="backToSearch">Back to search</a>
									</xsl:when>
									<xsl:otherwise>
										| <a href=".cxml?__sequence=searchCustomerForm" id="backToSearch">Back to search</a>
									</xsl:otherwise>
								</xsl:choose>
							</p>
							
							<!-- Content title -->
							<xsl:choose>
								<xsl:when test="inputVars/keyword">
									<h3>Customers for "<xsl:value-of select="inputVars/keyword"/>" <xsl:if test="nbResults">(<xsl:value-of select="nbResults"/>)</xsl:if></h3>
								</xsl:when>
								<xsl:when test="inputVars/name">
									<h3>Customers for "<xsl:value-of select="inputVars/name"/>" / "<xsl:value-of select="inputVars/firstname"/>" / "<xsl:value-of select="inputVars/company"/>" <xsl:if test="nbResults">(<xsl:value-of select="nbResults"/>)</xsl:if></h3>
								</xsl:when>
							</xsl:choose>
							
							<!-- page content with data -->
							<xsl:apply-templates/>
					
							<!-- Pagination -->
							<div id="pagination">
								<!-- Pagination previous -->
								<xsl:if test="$prevStart >= 0">
									<form id="prev_search" action=".cxml" method="POST">
										<xsl:choose>
											<xsl:when test="inputVars/keyword">
												<input type="hidden" id="prev_keyword" name="keyword" value="{inputVars/keyword}"/>
												<input type="hidden" id="prev__sequence" name="__sequence" value="searchCustomer"/>
								        	</xsl:when>
											<xsl:when test="inputVars/name">
									        	<input type="hidden" id="prev_name" name="name" value="{inputVars/name}"/>
											    <input type="hidden" id="prev_fisrtname" name="firstname" value="{inputVars/firstname}"/>
											    <input type="hidden" id="prev_company" name="company" value="{inputVars/company}"/>
											    <input type="hidden" id="prev__sequence" name="__sequence" value="searchCustomerAdvanced"/>
											</xsl:when>
										</xsl:choose>
										<input type="hidden" id="prev_start" name="start" value="{$prevStart}"/>
										<input type="submit" id="prev_search" name="button" value="Prev"/>
							        </form>
						        </xsl:if>
						        
								<!-- Pagination next -->
								<xsl:if test="number(nbResults) > $nextStart ">
									<form id="next_search" action=".cxml" method="POST">
										<xsl:choose>
											<xsl:when test="inputVars/keyword">
												<input type="hidden" id="next_keyword" name="keyword" value="{inputVars/keyword}"/>
												<input type="hidden" id="next__sequence" name="__sequence" value="searchCustomer"/>
								        	</xsl:when>
											<xsl:when test="inputVars/name">
									        	<input type="hidden" id="next_name" name="name" value="{inputVars/name}"/>
											    <input type="hidden" id="next_fisrtname" name="firstname" value="{inputVars/firstname}"/>
											    <input type="hidden" id="next_company" name="company" value="{inputVars/company}"/>
											    <input type="hidden" id="next__sequence" name="__sequence" value="searchCustomerAdvanced"/>
											</xsl:when>
										</xsl:choose>
										<input type="hidden" id="next_start" name="start" value="{$nextStart}"/>
										<input type="submit" id="next_search" name="button" value="Next"/>
							        </form>
								</xsl:if>
							</div>
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

<!-- content template for each row of data -->
<xsl:template match="row">
	<div id="customer_{@idcustomer}" class="customerResult">
		<p class="name"><span class="title">Name: </span><xsl:value-of select="@name"/></p>
		<p class="firstname"><span class="title">Firstname: </span><xsl:value-of select="@firstname"/></p>
		<p class="company"><span class="title">Company: </span><xsl:value-of select="@company"/></p>
		<p class="phone"><span class="title">Phone: </span><xsl:value-of select="@phone"/></p>
		<p class="email"><span class="title">Email: </span><xsl:value-of select="@email"/></p>
		
		<!-- adding details button -->
		<form id="customerDetails_{@idcustomer}" action="index.html" method="GET">
			<input type="hidden" id="customerDetails_{@idcustomer}_sequence" name="__sequence" value="getCustomerDetails"/>
			<input type="hidden" id="customerDetails_{@idcustomer}_idCustomer" name="idCustomer" value="{@idcustomer}"/>
			<input type="hidden" id="customerDetails_{@idcustomer}_name" name="name" value="{@name}"/>
			<input type="hidden" id="customerDetails_{@idcustomer}_firstname" name="firstname" value="{@firstname}"/>
			<input type="hidden" id="customerDetails_{@idcustomer}_company" name="company" value="{@company}"/>
			<xsl:choose>
				<xsl:when test="/document/inputVars/keyword">
					<input type="hidden" id="customerDetails_{@idcustomer}_backQuery" name="backQuery" value="__sequence=searchCustomer&amp;keyword={/document/inputVars/keyword}&amp;start={/document/inputVars/start}"/>
				</xsl:when>
				<xsl:when test="/document/inputVars/name">
					<input type="hidden" id="customerDetails_{@idcustomer}_backQuery" name="backQuery" value="__sequence=searchCustomerAdvanced&amp;name={/document/inputVars/name}&amp;firstname={/document/inputVars/firstname}&amp;company={/document/inputVars/company}&amp;start={/document/inputVars/start}"/>
				</xsl:when>
				<xsl:otherwise>
					<input type="hidden" id="customerDetails_{@idcustomer}_backQuery" name="backQuery" value="__sequence=searchCustomerForm"/>
				</xsl:otherwise>
			</xsl:choose>
			<input type="submit" id="customerDetails_{@idcustomer}_button" name="button" value="Businesses" class="btn_businessdetail"/>
		</form>
	</div>
	<br/>
</xsl:template>

<!-- message display template -->
<xsl:template match="message">
	<p class="message"><xsl:value-of select="."/></p><br/>
</xsl:template>

<!-- elements that do not have to be displayed -->
<xsl:template match="inputVars"></xsl:template>
<xsl:template match="nbResults"></xsl:template>
<xsl:template match="authenticated"></xsl:template>

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