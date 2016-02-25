<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="students">
  	<!-- Use this template for the all document -->
    <html>
      <head>
        <title>Students | Compiled by Mattia A. Fritz</title>
        <link rel="stylesheet" href="students.css" type="text/css" />
      </head>
      <body>
      	<h1>List of students</h1>
      	<table>
      		<tr>
      			<th>#</th>
      			<th>Last Name</th>
      			<th>First name</th>
      			<th>Exercices</th>
      			<th>Average grade</th>
      			<th>Details</th>
      		</tr>
      		<!-- Use the XPath for-each function to iterate a first time in the xml -->
      		<xsl:for-each select="student">
      			<!-- Use sort to order the list regardless of the XML nodes' order -->
      		<xsl:sort select="last_name"></xsl:sort>
		    <tr>
		      <!-- It is possible to use position() to get the current index in the for-each loop -->
		      <td><xsl:value-of select="position()"></xsl:value-of></td>
		      <td><xsl:value-of select="last_name"/></td>
		      <td><xsl:value-of select="first_name"/></td>
		      <!-- It is possible to use functions with relative references to the current node in the for-each loop -->
		      <td><xsl:value-of select="count(grades/grade)"></xsl:value-of></td>
		      <!-- It is possible to use a if statements, and also to combine functions for example to calculate an average using sum + div + count -->
		      <td><xsl:if test="count(grades/grade) != 0"><xsl:value-of select="sum(grades/grade) div count(grades/grade)"></xsl:value-of></xsl:if></td>
		      <!-- It is possible to put node's values in html using {node_name} -->
		      <td><a href="#{first_name}_{last_name}">See details</a></td>
		    </tr>
		    </xsl:for-each>
      	</table>
      	<h1>Details</h1>
        <div class="list">
          <!-- Apply successive templates iterating through the XML nodes' order -->
          <xsl:apply-templates/>
        </div>
        <h1>Summary</h1>
        <p>Total number of students: <xsl:value-of select="count(student)"/></p>
        <p>Total number of grades: <xsl:value-of select="count(student/grades/grade)"/></p>
        <p>Total average of grades: <xsl:value-of select="sum(student/grades/grade) div count(student/grades/grade)"></xsl:value-of></p>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="student">
  	<!-- Apply this template to every student node found in the document -->
  	<section id="{first_name}_{last_name}">
  		<h2><xsl:value-of select="last_name"></xsl:value-of>, <xsl:value-of select="first_name"></xsl:value-of></h2>
  		<!-- Search for other templates for child nodes of student -->
		<xsl:apply-templates/>
  	</section>
  </xsl:template>
  
  <xsl:template match="first_name">
  	<!-- Apply to the first_name node, since there are no child node, the apply-templates will output the content of the node -->
  	<p>First name: <strong><xsl:apply-templates/></strong></p>
  </xsl:template>
  
  <xsl:template match="last_name">
  	<!-- Apply to the last_name node, since there are no child node, the apply-templates will output the content of the node -->
  	<p>Last name: <strong><xsl:apply-templates/></strong></p>
  </xsl:template>
  
  <xsl:template match="email">
  	<!-- It is possible to use the current() function to get the value of the current node, in this case the email node -->
  	<p>E-mail: <a href="mailto: {current()}"><xsl:apply-templates/></a></p>
  </xsl:template>
  
  <xsl:template match="grades">
  	<!-- It is possible to combine functions inside the current parent node using the relative reference to the node, in this case the grade nodes -->
  	<p>Average of grades : <strong><xsl:value-of select="sum(grade) div count(grade)"></xsl:value-of></strong></p>
  	<h3>List of grades:</h3>
  	<ul>
  		<!-- Apply successive templates for each grade -->
  		<xsl:apply-templates/>
  	</ul>
  </xsl:template>
  
  <xsl:template match="grade">
  	<!-- Apply this template to each grade -->
  	<li>Ex<xsl:value-of select="@exercice"></xsl:value-of> : <xsl:apply-templates/></li>
  </xsl:template>
  
</xsl:stylesheet>