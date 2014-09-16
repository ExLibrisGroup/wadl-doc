<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" version="1.0" />
	<xsl:template match="/xs:schema">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>

<html>
		<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Exlibris Developer Network</title>
<meta name="viewport" content="width=device-width"/>

	<link href="http://support.exlibris.co.il/alma/restws/exlab.css" rel="stylesheet" type="text/css" />
	<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'/>
	<link href="http://alexgorbatchev.com/pub/sh/current/styles/shCore.css" rel="stylesheet" type="text/css" />
	<link href="http://alexgorbatchev.com/pub/sh/current/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
	<script src="http://alexgorbatchev.com/pub/sh/current/scripts/shCore.js" type="text/javascript"></script>
	<script src="http://alexgorbatchev.com/pub/sh/current/scripts/shAutoloader.js" type="text/javascript"></script>
	<script src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushXml.js" type="text/javascript"></script>
	<script src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushJScript.js" type="text/javascript"></script>
	<script src="http://support.exlibris.co.il/alma/restws/jquery-latest.js"></script>
        <script src="http://support.exlibris.co.il/alma/restws/jquery.xml2json.js"></script>
        <script src="http://support.exlibris.co.il/alma/restws/api-platform-doc.js"></script>

			<script>
			$(document).ready(function () {
				handleDebug();
				loadSamples("1.xml");
				hideRows();
				loadCodeTables();
			});
			</script>
		</head>
		<body>
<div id="wrapper">
  <!--content-->
  <div id="InnerTemplateContainer">
    <div id="InnerTemplateContent">
      <!-- <div class="menu">      </div> -->
      <div class="menuGutter"></div>
      <div class="columnContent">
        <h3>xsd_file_name.xsd</h3>
        <div class="articleContentIndex">
          <h4>Contents</h4>
          <ul>
            <li><a href="#Overview">Overview</a></li>
            <li><a href="#Dictionary">Data Dictionary</a>
              <ol>
<!--              <xsl:for-each select="xs:element">
	                <xsl:variable name="nameV"><xsl:value-of select="@name"/></xsl:variable>
	                <xsl:variable name="typeV"><xsl:value-of select="@type"/></xsl:variable>
	              	<xsl:apply-templates select="//xs:complexType[@name=$typeV]" mode="debug_mode"/>
	              </xsl:for-each> -->
	              <xsl:for-each select="xs:element">
	                <xsl:variable name="nameV"><xsl:value-of select="@name"/></xsl:variable>
	                <xsl:variable name="typeV"><xsl:value-of select="@type"/></xsl:variable>
	              	<xsl:apply-templates select="//xs:complexType[@name=$typeV]" mode="index_mode"/>
	              </xsl:for-each>
              </ol>
            </li>
            <li><a href="#Samples">Samples</a>
              <ol>
                <li><a href="#XML">XML</a></li>
                <li><a href="#JSON">JSON</a></li>
              </ol>
            </li>
          </ul>
        </div>
        <h4 id="Overview">Overview</h4>
        <p>
        	<xsl:value-of select="xs:annotation/xs:documentation"/>
		</p>
        <h4 id="Dictionary">Data Dictionary</h4>
        Click here to download <a href="xsd_file_name.xsd">xsd_file_name.xsd</a>
        <xsl:for-each select="xs:element">
          <xsl:variable name="nameD"><xsl:value-of select="@name"/></xsl:variable>
          <xsl:variable name="typeD"><xsl:value-of select="@type"/></xsl:variable>
        	<xsl:apply-templates select="//xs:complexType[@name=$typeD]" mode="dictionary_mode"/>
        </xsl:for-each>

        <h4 id="Samples">Samples</h4>
        <h5 id="XML">XML</h5>
        <div class="codeSample" style="max-width:1600px;">
          <pre class="brush: xml" id="xml_sample" style="white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap;  white-space: -o-pre-wrap; word-wrap: break-word;"></pre>
        </div>
        <h5 id="JSON">JSON</h5>
        <div class="codeSample" style="max-width:1600px;">
          <pre class="brush: js" id="json_sample" style="white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap;  white-space: -o-pre-wrap; word-wrap: break-word;"></pre>
        </div>
      </div>
    </div>
  </div>
</div>
<span id="show_debug" style="color:white">__</span><span id="debug"></span><BR/>
</body>
</html>

	</xsl:template>

	<!-- function for displaying the menu with links to each complexType -->
	<xsl:template match="xs:complexType" mode="index_mode">
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:variable name="href" select="@name"/>
				<li><a href="#{$href}"><xsl:value-of select="@name"/></a></li>
			</xsl:when>
		</xsl:choose>

		<!--  this xs:complexType might have a name, or not -->
		<xsl:for-each select="(xs:sequence|xs:all|xs:choice)/xs:element">
			<xsl:choose>
				<xsl:when test="xs:complexType/xs:simpleContent/xs:extension/@base">
					<!-- element which has an attribute is defined in the XSD with "base" -->
					<!-- it doesn't need to display in the menu, and not recursion needed -->
				</xsl:when>
				<xsl:when test="@type">
					<!-- regular elements, with a type -->
					<xsl:choose>
						<xsl:when test="@type='xs:string'"></xsl:when>
						<xsl:when test="@type='xs:date'"></xsl:when>
						<xsl:when test="@type='xs:time'"></xsl:when>
						<xsl:when test="@type='xs:dateTime'"></xsl:when>
						<xsl:when test="@type='xs:int'"></xsl:when>
						<xsl:when test="@type='xs:long'"></xsl:when>
						<xsl:when test="@type='xs:decimal'"></xsl:when>
						<xsl:when test="@type='xs:float'"></xsl:when>
						<xsl:when test="@type='xs:boolean'"></xsl:when>
						<xsl:otherwise>
							<!-- Example: <xs:element name="instructors" type="Instructors" /> -->
							<xsl:variable name="typeV2"><xsl:value-of select="@type"/></xsl:variable>
							<!--  RECURSION -->
							<xsl:apply-templates select="//xs:complexType[@name=$typeV2]" mode="index_mode"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="xs:complexType">
					<!-- no type bu has xs:complexType inside it - we need to drill down. Example:
					      <xs:element minOccurs="1" name="course_information"> -->
					<xsl:variable name="nameV2"><xsl:value-of select="@name"/></xsl:variable>
					<li><a href="#{$nameV2}"><xsl:value-of select="@name"/></a></li>
					<!--  RECURSION -->
					<xsl:apply-templates select="xs:complexType" mode="index_mode" />
				</xsl:when>
				<xsl:otherwise>
					<!--  ...  -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- function for the acctual data-dictionary -->
	<xsl:template match="xs:complexType" mode="dictionary_mode">
		<xsl:choose>
			<xsl:when test="@name">
				<xsl:variable name="id" select="@name"/>
				<h5 id="{$id}"><xsl:value-of select="@name"/></h5>
			</xsl:when>
		</xsl:choose>

		<xsl:apply-templates select="." mode="show_table_mode" />

		<!--  this xs:complexType might have a name, or not -->
		<xsl:for-each select="(xs:sequence|xs:all|xs:choice)/xs:element">
			<xsl:choose>
				<xsl:when test="xs:complexType/xs:simpleContent/xs:extension/@base">
					<!-- element which has an attribute is defined in the XSD with "base" -->
					<!-- it is dislpayed as a regular element -->
				</xsl:when>
				<xsl:when test="@type">
					<!-- regular elements, with a type -->
					<xsl:choose>
						<xsl:when test="@type='xs:string' or @type='xs:date' or @type='xs:time' or @type='xs:dateTime' or @type='xs:int'
									 or @type='xs:integer' or @type='xs:long' or @type='xs:decimal' or @type='xs:float' or @type='xs:boolean'">
							<!-- not a special type - no recursion needed -->
						</xsl:when>
						<xsl:otherwise>
							<!-- example: <xs:element name="instructors" type="Instructors" /> -->
							<xsl:variable name="typeD2"><xsl:value-of select="@type"/></xsl:variable>
							<!--  RECURSION -->
							<xsl:apply-templates select="//xs:complexType[@name=$typeD2]" mode="dictionary_mode"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="xs:complexType">
					<!-- no type but has xs:complexType inside it - we need to drill down. Example:
					      <xs:element minOccurs="1" name="course_information"> -->
					<xsl:choose>
						<xsl:when test="@name">
							<xsl:variable name="id2" select="@name"/>
							<h5 id="{$id2}"><xsl:value-of select="@name"/></h5>
							<!-- <xsl:apply-templates select="xs:complexType" mode="show_table_mode" /> -->
						</xsl:when>
					</xsl:choose>
					<!--  RECURSION -->
					<xsl:apply-templates select="xs:complexType" mode="dictionary_mode" />
				</xsl:when>
				<xsl:otherwise>
					<!-- ... -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- showing a table for a specific complexType.  No recursion here... -->
	<xsl:template match="xs:complexType" mode="show_table_mode">
        <table cellpadding="0" cellspacing="0">
          <caption>
          Description: <xsl:value-of select="xs:annotation/xs:documentation"/>
          </caption>
          <tr>
            <th scope="col">Field</th>
            <th scope="col">Type</th>
            <th scope="col">Description</th>
          </tr>

		<!--  this xs:complexType might have a name, or not -->
		<xsl:for-each select="(xs:sequence|xs:all|xs:choice)/xs:element">

		<!-- <xs:annotation> <xs:appinfo> <xs:tags> allows hiding a row according to the requested method by JS according to a URL parameter-->
			<xsl:choose>
			 <xsl:when test="xs:annotation/xs:appinfo/xs:tags">
			  <xsl:text disable-output-escaping="yes">&lt;</xsl:text>tr data-tags="<xsl:value-of select="xs:annotation/xs:appinfo/xs:tags"/>"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			 </xsl:when>
			 <xsl:otherwise>
			 <xsl:text disable-output-escaping="yes">&lt;</xsl:text>tr<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			 </xsl:otherwise>
			</xsl:choose>
				<td>
					<xsl:value-of select="@name" />
				</td>
	            <td>
			<xsl:choose>
				<xsl:when test="xs:complexType/xs:simpleContent/xs:extension/@base">
<!--               element which has an attribute is defined in the XSD with "base"
						<xs:element name="status" minOccurs="0">
							<xs:annotation...
							<xs:complexType>
								<xs:simpleContent>
									<xs:extension base="xs:string">
										<xs:attribute name="desc" type="xs:string" use="optional" /> -->
					<xsl:variable name="typeV" select="xs:complexType/xs:simpleContent/xs:extension/@base"/>
					<xsl:value-of select="substring-after($typeV,'xs:')"/>

					<!--
					<br/>(with attribute: <xsl:value-of select="xs:complexType/xs:simpleContent/xs:extension/xs:attribute/@name"/>
					<br/>type:
					<xsl:variable name="typeV2" select="xs:complexType/xs:simpleContent/xs:extension/xs:attribute/@type"/>
					<xsl:value-of select="substring-after($typeV2,'xs:')"/>		) -->
				</xsl:when>
				<xsl:when test="@type">
					<!-- regular elements, with a type -->
					<xsl:choose>
						<xsl:when test="@type='xs:string' or @type='xs:date' or @type='xs:time' or @type='xs:dateTime' or @type='xs:int'
									 or @type='xs:integer' or @type='xs:long' or @type='xs:decimal' or @type='xs:float' or @type='xs:boolean'">
							<xsl:variable name="typeV" select="@type"/>
							<xsl:value-of select="substring-after($typeV,'xs:')"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- example: <xs:element name="instructors" type="Instructors" /> -->
							<xsl:variable name="typeD2"><xsl:value-of select="@type"/></xsl:variable>
							<xsl:choose>
								<xsl:when test="//xs:complexType[@name=$typeD2]">
									<a href="#{$typeD2}"><xsl:value-of select="@type" /></a>
								</xsl:when>
								<xsl:otherwise>
									<a href="rest_{$typeD2}.xsd.html"><xsl:value-of select="@type" /></a>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:when>
				<xsl:otherwise>
					<!-- no type - probably has inner elements. Example:
					      <xs:element minOccurs="1" name="course_information"> -->
					<xsl:choose>
						<xsl:when test="@name">
							<xsl:variable name="id2" select="@name"/>
							<a href="#{$id2}"><xsl:value-of select="@name"/></a>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>

	            </td>
	            <td>
		            <xsl:value-of select="xs:annotation/xs:documentation"/>
		            <xsl:choose>
						<xsl:when test="xs:annotation/xs:appinfo/xs:codeTable">

		              <table cellpadding="0" class="note" border="1">
		                <caption>
		                The valid values for this paramater are controlled by the
		                <span class="code">
		                	<xsl:value-of select="xs:annotation/xs:appinfo/xs:codeTable"/>
		                	</span>
		                 code-table.
		                These are the currently defined values for YOUR institition:
		                </caption>
		                <tr>
		                  <th>Code</th>
		                  <th>Description</th>
		                </tr>
		                <caption class="code-table"><xsl:value-of select="xs:annotation/xs:appinfo/xs:codeTable"/></caption>
		              </table>

						</xsl:when>
					</xsl:choose>
				</td>
			<xsl:text disable-output-escaping="yes">&lt;</xsl:text>/tr<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:for-each>
		</table>

	</xsl:template>


	<!-- function for debug only - not use in prod -->
	<xsl:template match="xs:complexType" mode="debug_mode">
		in debug_mode
		<!--  this xs:complexType might have a name, or not -->
		<xsl:for-each select="(xs:sequence|xs:all|xs:choice)/xs:element">
			<xsl:choose>
				<xsl:when test="xs:complexType/xs:simpleContent/xs:extension/@base">
<!--               element which has an attribute is defined in the XSD with "base"
						<xs:element name="status" minOccurs="0">
							<xs:annotation...
							<xs:complexType>
								<xs:simpleContent>
									<xs:extension base="xs:string">
										<xs:attribute name="desc" type="xs:string" use="optional" /> -->
					name: <xsl:value-of select="@name"/> has type (base):
					<xsl:value-of select="xs:complexType/xs:simpleContent/xs:extension/@base"/>
					with attribute:
					<xsl:value-of select="xs:complexType/xs:simpleContent/xs:extension/xs:attribute/@name"/>
					of type:
					<xsl:value-of select="xs:complexType/xs:simpleContent/xs:extension/xs:attribute/@type"/>
				</xsl:when>
				<xsl:when test="@type">
					<!-- regular elements, with a type -->
					Regular element, name: <xsl:value-of select="@name"/> with type:
					<xsl:choose>
						<xsl:when test="@type='xs:string'">String</xsl:when>
						<xsl:when test="@type='xs:date'">Date</xsl:when>
						<xsl:when test="@type='xs:time'">Time</xsl:when>
						<xsl:when test="@type='xs:dateTime'">dateTime</xsl:when>
						<xsl:when test="@type='xs:int'">Int</xsl:when>
						<xsl:when test="@type='xs:integer'">Integer</xsl:when>
						<xsl:when test="@type='xs:long'">Integer</xsl:when>
						<xsl:when test="@type='xs:decimal'">Decimal</xsl:when>
						<xsl:when test="@type='xs:float'">Float</xsl:when>
						<xsl:when test="@type='xs:boolean'">Boolean</xsl:when>
						<xsl:otherwise>
							<!-- example: <xs:element name="instructors" type="Instructors" /> -->
							<xsl:variable name="typeV2"><xsl:value-of select="@type"/></xsl:variable>
							<!--  RECURSION -->
							<xsl:apply-templates select="//xs:complexType[@name=$typeV2]" mode="debug_mode"/>
						</xsl:otherwise>
					</xsl:choose>

				</xsl:when>
				<xsl:otherwise>
					<!-- no type - probably has inner elements. Example:
					      <xs:element minOccurs="1" name="course_information"> -->
					Element with no type: <xsl:value-of select="@name"/><br/>
					<xsl:variable name="nameV2"><xsl:value-of select="@name"/></xsl:variable>
					<!--  RECURSION -->
					<xsl:apply-templates select="xs:complexType" mode="debug_mode" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
