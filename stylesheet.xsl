<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />

  <!-- Identity template to copy all elements and attributes as is -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Transform XML to HTML -->
  <xsl:template match="/">
    <html>
      <head>
        <title>HRM Catalogue</title>
        <!-- Link to external style.css file -->
        <link rel="stylesheet" type="text/css" href="style/style.css" />
        <!-- Include JavaScript code -->
        <script type="text/javascript">
          <![CDATA[
            function sortTable() {
              var columnIndex = document.getElementById("sortOptions").value;
              var table, rows, switching, i, x, y, shouldSwitch;
              table = document.getElementById("employeeTable");
              switching = true;

              while (switching) {
                switching = false;
                rows = table.getElementsByTagName("tr");

                for (i = 1; i < (rows.length - 1); i++) {
                  shouldSwitch = false;
                  x = rows[i].getElementsByTagName("td")[columnIndex];
                  y = rows[i + 1].getElementsByTagName("td")[columnIndex];

                  if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                  }
                }

                if (shouldSwitch) {
                  rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                  switching = true;
                }
              }
            }

            function showEmployees() {
              document.getElementById("employeeTable").style.display = "table";
              document.getElementById("departmentsContainer").style.display = "none";
			  document.getElementById("sortingContainer").style.display = "block";
			}

            function showDepartments() {
			  document.getElementById("employeeTable").style.display = "none";
			  document.getElementById("departmentsContainer").style.display = "block";
			  document.getElementById("sortingContainer").style.display = "none";
			}

          ]]>
        </script>
      </head>
      <body>
        <h1>Human Resources Manager Catalogue</h1>

        <!-- Buttons for sorting and filtering -->
        <div id="sortingContainer">
          <select id="sortOptions" onchange="sortTable()">
            <option value="0">Sort by First Name</option>
            <option value="1">Sort by Middle Name</option>
            <option value="2">Sort by Last Name</option>
            <option value="3">Sort by ID</option>
            <option value="5">Sort by Birthday</option>
            <option value="6">Sort by Telephone Number</option>
            <option value="7">Sort by Country</option>
            <option value="8">Sort by City</option>
            <option value="9">Sort by Zip Code</option>
            <option value="10">Sort by Address</option>
            <option value="11">Sort by Department Name</option>
            <option value="12">Sort by Workweek</option>
            <option value="13">Sort by Salary</option>
            <option value="14">Sort by Employment Type</option>
            <option value="15">Sort by Position Name</option>
            <option value="16">Sort by Start Date</option>
            <!-- Add more sorting options based on employee information -->
          </select>
        </div>

        <!-- Employees and Departments buttons -->
		<div id="buttonsContainer">
		  <button id="employeesBtn" onclick="showEmployees()">Show Employees</button>
		  <button id="departmentsBtn" onclick="showDepartments()">Show Departments</button>
		</div>


        <!-- Employees table -->
        <table id="employeeTable">
          <tr>
            <th>Image</th> 
            <th>First Name</th>
            <th>Middle Name</th>
            <th>Last Name</th>
            <th>ID</th>
            <th>Birthday</th>
            <th>Telephone Number</th>
            <th>Country</th>
            <th>City</th>
            <th>Zip Code</th>
            <th>Address</th>
            <th>Department Name</th>
            <th>Workweek</th>
            <th>Salary</th>
            <th>Employment Type</th>
            <th>Position Name</th>
            <th>Start Date</th>
          </tr>
          <xsl:apply-templates select="//employee"/>
        </table>

        <!-- Departments container -->
        <div id="departmentsContainer" style="display: none;">
          <h2>Departments Information</h2>
          <table border="1">
            <tr>
              <th>Department Name</th>
              <th>Admin First Name</th>
              <th>Admin Last Name</th>
              <th>Admin Image</th>
            </tr>
            <xsl:apply-templates select="//department"/>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Transform employee elements -->
  <xsl:template match="employee">
    <tr class="employee">
      <td>
        <!-- Display employee image using ID -->
        <img src="images/{personData/id}.jpg" alt="Employee Image"/>
      </td>
      <xsl:apply-templates select="personData"/>
      <xsl:apply-templates select="employeeData"/>
    </tr>
  </xsl:template>

  <!-- Transform personData elements -->
  <xsl:template match="personData">
    <td>
      <xsl:apply-templates select="firstName"/>
    </td>
    <td>
      <xsl:apply-templates select="middleName"/>
    </td>
    <td>
      <xsl:apply-templates select="lastName"/>
    </td>
    <td>
      <xsl:apply-templates select="id"/>
    </td>
    <td>
      <xsl:apply-templates select="birthday"/>
    </td>
    <td>
      <xsl:apply-templates select="telephoneNumber"/>
    </td>
    <xsl:apply-templates select="residenceData"/>
  </xsl:template>

  <!-- Transform residenceData elements -->
  <xsl:template match="residenceData">
    <td>
      <xsl:apply-templates select="country"/>
    </td>
    <td>
      <xsl:apply-templates select="city"/>
    </td>
    <td>
      <xsl:apply-templates select="zipCode"/>
    </td>
    <td>
      <xsl:apply-templates select="address"/>
    </td>
  </xsl:template>

  <!-- Transform employeeData elements -->
  <xsl:template match="employeeData">
    <td>
      <xsl:apply-templates select="departmentName"/>
    </td>
    <td>
      <xsl:apply-templates select="workweek"/>
    </td>
    <td>
      <xsl:apply-templates select="salary"/>
    </td>
    <td>
      <xsl:apply-templates select="employmentType"/>
    </td>
    <xsl:apply-templates select="positionInCompany"/>
  </xsl:template>

  <!-- Transform positionInCompany elements -->
  <xsl:template match="positionInCompany">
    <td>
      <xsl:apply-templates select="positionName"/>
    </td>
    <td>
      <xsl:apply-templates select="startDate"/>
    </td>
  </xsl:template>

  <!-- Transform departmentsList elements -->
  <xsl:template match="departmentsList">
    <xsl:apply-templates select="department"/>
  </xsl:template>

  <!-- Transform department elements -->
  <xsl:template match="department">
    <tr>
      <td>
        <xsl:apply-templates select="departmentName"/>
      </td>
      <td>
        <xsl:value-of select="manager/@firstNameRef"/>
      </td>
      <td>
        <xsl:value-of select="manager/@lastNameRef"/>
      </td>
      <td>
        <!-- Display admin image using ID -->
        <img src="images/{manager/@idRef}.jpg" alt="Admin Image"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
