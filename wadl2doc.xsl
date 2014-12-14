<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:wadl="http://wadl.dev.java.net/2009/02"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="html" version="1.0" />

	<xsl:template match="/wadl:application">

		<xsl:variable name="ttt_resourcesBase" select="substring-after(wadl:resources/@base,'almaws')"/>
		<xsl:variable name="g_resourcesBase"><xsl:value-of select="concat('/almaws',$ttt_resourcesBase)"/></xsl:variable>
		<xsl:variable name="g_endOfResourcesBase"><xsl:value-of select="substring-after($ttt_resourcesBase,'v1/')"/></xsl:variable>

		<xsl:for-each select="//wadl:resource">

			<xsl:variable name="pathParam">
	 			<xsl:for-each select="wadl:param">
					<tr>
						<td><xsl:value-of select="@name"/></td>
						<td><xsl:value-of select="@type"/></td>
						<td><xsl:value-of select="wadl:doc"/></td>
					</tr>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="resourcePath" select="@path"/>
			<br/>
			<xsl:for-each select="wadl:method">

		<!-- <Generating the name of the output file> -->
		<xsl:variable name="wadlDocFileName1">
			<xsl:call-template name="getFullResourcePath">
				<xsl:with-param name="base" select="$g_resourcesBase" />
				<xsl:with-param name="path" select="$resourcePath" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="wadlDocFileName2" select="substring-after( translate(  concat($wadlDocFileName1,'.wadl.html')  ,'/{}','_') , '_almaws_v1_')"/>
		<xsl:variable name="wadlDocFileName3">
			<xsl:call-template name="string-replace-all">
				<xsl:with-param name="text" select="$wadlDocFileName2" />
				<xsl:with-param name="replace" select="'_.'" />
				<xsl:with-param name="by" select="'.'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:text>__beginning of:</xsl:text>
		<xsl:value-of select="@name" />_<xsl:value-of select="$wadlDocFileName3"/>
		<xsl:text>__</xsl:text>
		<!-- </Generating the name of the output file>  -->

		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html>
			<head>
				<META http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<title>Exlibris Developer Network</title>
				<meta name="viewport" content="width=device-width" />

				<!-- TODO move all css files to local disk -->
				<link href="http://support.exlibris.co.il/alma/restws/exlab.css" rel="stylesheet" type="text/css" />
				<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
			</head>
			<body>
				<div id="wrapper">
					<!--content -->
					<div id="InnerTemplateContainer">
						<div id="InnerTemplateContent">
							<!-- <div class="menu"> </div> -->
							<div class="menuGutter"></div>
							<div class="columnContent">
								<h3>
									APIs
									<span> / </span>
									<xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
									<xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
									<xsl:value-of select="concat(translate(substring($g_endOfResourcesBase,1,1),$vLower, $vUpper),
   													       substring($g_endOfResourcesBase, 2))"/>
									<span> / </span>
									<xsl:value-of select="@name" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="wadl:doc/@title" />
								</h3>
								<div class="articleContentIndex">
									<h4>Contents</h4>
									<ul>
										<li>
											<a href="#resourceURL">Resource URL</a>
										</li>
										<li>
											<a href="#urlParameters">URL Parameters</a>
										</li>
										<li>
											<a href="#queryParameters">Query string Parameters</a>
										</li>
										<li>
											<a href="#bodyParameters">Body Parameters</a>
										</li>
										<li>
											<a href="#output">Output</a>
										</li>
										<li>
											<a href="#errorCodes">Possible Error Codes</a>
										</li>
									</ul>
								</div>

								<div class="articleInfoGutter"></div>
								<!-- <div class="articleInfo"> <ul> <li>API Version: <a href="#">v1</a></li> <li>Response object: <a href="#">User</a></li> <li>HTTP Method:
									POST</li> </ul> </div> -->

							</div>
							<p>
								<xsl:variable name="with_new_lines">
									<xsl:call-template name="string-replace-all">
										<xsl:with-param name="text" select="wadl:doc" />
										<xsl:with-param name="replace" select="'&#xA;'" />
										<xsl:with-param name="by" select="'new_line'" />
									</xsl:call-template>
								</xsl:variable>
								<xsl:variable name="with_links">
									<xsl:call-template name="create-links">
										<xsl:with-param name="text" select="$with_new_lines" />
									</xsl:call-template>
								</xsl:variable>
								<xsl:copy-of select="$with_links" />
							</p>

        					<h5 id="resourceURL">Resource URL</h5>
							<pre>
								<xsl:value-of select="@name" />
								<xsl:text> </xsl:text>
								<xsl:call-template name="getFullResourcePath">
									<xsl:with-param name="base" select="$g_resourcesBase" />
									<xsl:with-param name="path" select="$resourcePath" />
								</xsl:call-template>
	    			        </pre>
	    			        <p>
		    			        The full <a href="http://en.wikipedia.org/wiki/Web_Application_Description_Language">WADL</a> documentation
		    			        is available
		    			        <!-- TODO: fix link to wadl file once we switch to the platform: -->
		    			        <xsl:variable name="linkToWadl" select="concat($g_resourcesBase,'?_wadl')"/>
		    			        <xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="$linkToWadl"/></xsl:attribute>here</xsl:element>.
							</p>
							<!-- <a href="#" class="linkBlock">Try it now! </a> -->
					<p class="captionStyle">
					<strong id="urlParameters">URL Parameters</strong>
				<xsl:choose>
					<xsl:when test="$pathParam != ''">
					<table class="" cellpadding="0" cellspacing="0">
						<tr>
							<th scope="col">Parameter</th>
							<th scope="col">Type</th>
							<th scope="col">Description</th>
						</tr>
						<xsl:copy-of select="$pathParam"/>
					</table>
					</xsl:when>
					<xsl:otherwise>
						None
					</xsl:otherwise>
				</xsl:choose>
					</p>

					<p class="captionStyle">
					<strong id="queryParameters">Query string Parameters</strong>
				<xsl:choose>
				<xsl:when test="wadl:request/wadl:param">
							<table class="tableMinMargin" cellpadding="0" cellspacing="0">

								<tr>
									<th scope="col">Parameter</th>
									<th scope="col">Type</th>
									<!-- <th scope="col">Required</th>  removed see note below-->
									<th scope="col">Description</th>
								</tr>
					<xsl:for-each select="wadl:request/wadl:param">
								<tr>
									<td><xsl:value-of select="@name"/></td>
									<td> <xsl:value-of select="@type"/></td>
									<!--  removed because sometimes a parameter is optional, but we don't have a default for it.
									<td>
										<xsl:choose>
											<xsl:when test="@default">
												Optional.
												Default: <xsl:value-of select="@default"/>
											</xsl:when>
											<xsl:otherwise>
												Required
											</xsl:otherwise>
										</xsl:choose>
									</td>
									 -->
									<td><xsl:value-of select="wadl:doc"/></td>
								</tr>
					</xsl:for-each>
							</table>
				</xsl:when>
				<xsl:otherwise>
					None
				</xsl:otherwise>
				</xsl:choose>
					</p>

							<p class="captionStyle">
								<strong id="bodyParameters">Body Parameters</strong>
				<xsl:choose>
					<xsl:when test="wadl:request/wadl:representation/wadl:doc">
								<xsl:value-of select="wadl:request/wadl:representation/wadl:doc"/>
								<br/>
								For detailed documentation see
								<xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="wadl:response/wadl:representation/wadl:doc"/>.html?tags=<xsl:value-of select="@name"/></xsl:attribute>here</xsl:element>.
					</xsl:when>
					<xsl:otherwise>
								None
					</xsl:otherwise>
				</xsl:choose>
							</p>

							<p class="captionStyle">
								<strong id="output">Output</strong>
				<xsl:choose>
					<xsl:when test="@name = 'DELETE'">
								This method returns HTTP 204 (No Content) which means that the server successfully processed the request, but is not returning any content.
					</xsl:when>
					<xsl:otherwise>
								This method returns a
								<xsl:value-of select="wadl:response/wadl:representation/wadl:doc/@title"/>
								object.<br/>
								For detailed documentation see
		    			        <xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="wadl:response/wadl:representation/wadl:doc"/>.html?tags=<xsl:value-of select="@name"/></xsl:attribute>here</xsl:element>.
					</xsl:otherwise>
				</xsl:choose>
							</p>


							<table class="tableMinMargin" cellpadding="0" cellspacing="0">
								<caption id="errorCodes">Possible Error Codes</caption>
								<tr>
									<th scope="col">Code</th>
									<th scope="col">Message</th>
								</tr>
							 <xsl:for-each select="wadl:response/wadl:doc">
								<tr>
									<td><xsl:value-of select="@title"/></td>
									<td><xsl:value-of select="."/></td>
								</tr>
							 </xsl:for-each>
							</table>

						</div>
					</div>
				</div>
			</body>
		</html>
			</xsl:for-each>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="getFullResourcePath">
	    <xsl:param name="base"/>
	    <xsl:param name="path"/>
	    <xsl:choose>
	        <xsl:when test="substring($base, string-length($base)) = '/'">
	            <xsl:value-of select="$base"/>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="concat($base, '/')"/>
	        </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	        <xsl:when test="starts-with($path, '/')">
	            <xsl:value-of select="substring($path, 2)"/>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$path"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>

<!-- Changing [here|http://a.com] to <a href="http://a.com">here</a> and
		[http://a.com] to <a href="http://a.com">http://a.com</a>
		Note that only one link can be used-->
	<xsl:template name="create-links">
		<xsl:param name="text" />
		<xsl:choose>
			<xsl:when test="contains($text, 'http')">

				<xsl:copy-of select="substring-before($text,'[')" />

				<xsl:variable name="the_link_and_after">
					<xsl:copy-of select="substring-after($text,'[')" />
				</xsl:variable>

				<xsl:variable name="the_link">
					<xsl:value-of select="substring-before($the_link_and_after,']')" />
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="contains($the_link,'|')">
						<xsl:variable name="the_url">
							<xsl:value-of select="substring-after($the_link,'|')" />
						</xsl:variable>
						<a href="{$the_url}">
							<xsl:value-of select="substring-before($the_link,'|')" />
						</a>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$the_link}">
							<xsl:value-of select="$the_link" />
						</a>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:copy-of select="substring-after($text,']')" />

			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <!-- Replace all. To replace \n by <br> use: replace="'&#xA;'" by="'new_line'" -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />

		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:copy-of select="substring-before($text,$replace)" />

				<xsl:choose>
					<xsl:when test="$by='new_line'">
						<br />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$by" />
					</xsl:otherwise>
				</xsl:choose>

				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text"
						select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
