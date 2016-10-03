<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<openmrs:require privilege="Manage Billing Reports"
	otherwise="/login.htm" redirect="/mohbilling/cohort.orm" />
<openmrs:htmlInclude
	file="/moduleResources/@MODULE_ID@/scripts/jquery-1.3.2.js" />
<openmrs:htmlInclude
	file="/moduleResources/@MODULE_ID@/scripts/jquery.PrintArea.js" />
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<%@ taglib prefix="billingtag"
	uri="/WEB-INF/view/module/@MODULE_ID@/taglibs/billingtag.tld"%>

<%@ include file="templates/mohBillingLocalHeader.jsp"%>
<script type="text/javascript" language="JavaScript">
	var $bill = jQuery.noConflict();
	$bill(document).ready(function(){
		$bill('.meta').hide();
		$bill('#submitId').click(function() {
			$bill('#formStatusId').val("clicked");
		});
		$bill("input#print_button").click(function() {
			$bill('.meta').show();
			$bill("div.printarea").printArea();
			$bill('.meta').hide();
		});
		
		/*  $bill('#reportType').change(function(){
		        $bill('.reports').hide();
		        $bill('#' + $bill(this).val()).show();
		    }); */
	});
</script>

<script type="text/javascript">
var $j = jQuery.noConflict();
$j(document).ready(function(){
	$j('.collector').hide();
	$j('.insurances').hide();
	
	$j('.reportType').change(function () {
		  switch ($j(this).val()) {
		    case 'insurance':
		    	$j('.insurances').show();
		    	$j('.collector').hide();
		    break;
		    
		    case 'cashierReport':
		      $j('.collector').show();
		      $j('.insurances').hide();
		      $j('#cashierReport').show();
		    break;
		    case 'serviceRevenue':
			      $j('.collector').hide();
			      $j('.insurances').hide();
			      $j('#cashierReport').hide();
				  $j('#serviceReport').show();
			    break;
		    
		    
		    default:
		      $j('.reportType').show();
		      $j('.dates').show();
		    }
	});	
	$j('.insurance').change(function () {
		var insuranceId = $j(this).val();
		if(insuranceId==1){
			  $j("#rssbReport").show();
			  $j("#privateReport").hide();
			  $j('#cashierReport').hide();
		} 
		else if(insuranceId==7){
			$j("#rssbReport").hide();
			$j("#privateReport").show();
			 $j('#cashierReport').hide();
		}
	});
 	$j('.reportType').change(function () {
		var report = $j(this).val();
		if(report =='cashierReport'){
			  $j("#rssbReport").hide();
			  $j("#privateReport").hide();
			  $j('#cashierReport').show();
			  $j('#serviceReport').hide();
		} 
		if(report=='serviceRevenue'){
			  $j("#rssbReport").hide();
			  $j("#privateReport").hide();
			  $j('#cashierReport').hide();
			  $j('#serviceReport').show();
		}
	}); 

});
</script>

<h2>
	<spring:message code="@MODULE_ID@.billing.report" />
</h2>

<b class="boxHeader">Search Form(Advanced)</b>
<div class="box">
	<form method="post" action=" ">	
	<input type="hidden" name="formStatus" id="formStatusId" value="" />	
		<table>
		    <tr class="reportType">
				<td>Report Type: </td>
				<td>
				  <select name="reportType" class="reportType">
				    <option selected="selected">--select--</option>
				    <option value="insurance">Insurance</option>
				    <option value="cashierReport">Cashier Report</option>
				    <option value="serviceRevenue">Revenue By Service</option>
				  </select>
				</td>
	        </tr>
	        
			<tr class="dates">
				<td width="10%">When?</td>
				<td>
					<table>
						<tr>
							<td>On Or After <input type="text" size="11"
								value="${startDate}" name="startDate"
								onclick="showCalendar(this)" /></td>
							<td>
							<select name="startHour">
					          <option value="00">00</option>
				              <option value="01">01</option>
				              <option value="02">02</option>
				              <option value="03">03</option>
				              <option value="04">04</option>
				              <option value="05">05</option>
				              <option value="06">06</option>
				              <option value="07">07</option>
				              <option value="08">08</option>
				              <option value="09">09</option>
				              <option value="10">10</option>
				              <option value="11">11</option>
				              <option value="12">12</option>
				              <option value="13">13</option>
				              <option value="14">14</option>
				              <option value="15">15</option>
				              <option value="16">16</option>
				              <option value="17">17</option>
				              <option value="18">18</option>
				              <option value="19">19</option>
				              <option value="20">20</option>
				              <option value="21">21</option>
				              <option value="22">22</option>
				              <option value="23">23</option>
				             </select>
							
							</td>
							<td>
							<select name="startMinute">
					          <option value="00">00</option>
				              <option value="01">01</option>
				              <option value="02">02</option>
				              <option value="03">03</option>
				              <option value="04">04</option>
				              <option value="05">05</option>
				              <option value="06">06</option>
				              <option value="07">07</option>
				              <option value="08">08</option>
				              <option value="09">09</option>
				              <option value="10">10</option>
				              <option value="11">11</option>
				              <option value="12">12</option>
				              <option value="13">13</option>
				              <option value="14">14</option>
				              <option value="15">15</option>
				              <option value="16">16</option>
				              <option value="2">17</option>
				              <option value="17">18</option>
				              <option value="19">19</option>
				              <option value="20">20</option>
				              <option value="21">21</option>
				              <option value="22">22</option>
				              <option value="23">23</option>
				              <option value="24">24</option>
				              <option value="25">25</option>
				              <option value="25">26</option>
				              <option value="26">27</option>
				              <option value="27">28</option>
				              <option value="29">29</option>
				              <option value="30">30</option>
				              <option value="31">31</option>
				              <option value="32">32</option>
				              <option value="33">33</option>
				              <option value="34">34</option>
				              <option value="35">35</option>
				              <option value="36">36</option>
				              <option value="37">37</option>
				              <option value="38">38</option>
				              <option value="39">39</option>
				              <option value="40">40</option>
				              <option value="41">41</option>
				              <option value="42">42</option>
				              <option value="43">43</option>
				              <option value="44">44</option>
				              <option value="45">45</option>
				              <option value="46">46</option>
				              <option value="47">47</option>
				              <option value="48">48</option>
				              <option value="49">49</option>
				              <option value="50">50</option>
				              <option value="51">51</option>
				              <option value="52">52</option>
				              <option value="53">53</option>
				              <option value="54">54</option>
				              <option value="55">55</option>
				              <option value="56">56</option>
				              <option value="57">57</option>
				              <option value="58">58</option>
				              <option value="59">59</option>
				             </select>
				             </td>
						</tr>
						<tr>
							<td>On Or Before <input type="text" size="11"
								value="${endDate}" name="endDate" onclick="showCalendar(this)" /></td>
								<td>
							<select name="endHour">
					          <option value="00">00</option>
				              <option value="01">01</option>
				              <option value="02">02</option>
				              <option value="03">03</option>
				              <option value="04">04</option>
				              <option value="05">05</option>
				              <option value="06">06</option>
				              <option value="07">07</option>
				              <option value="08">08</option>
				              <option value="09">09</option>
				              <option value="10">10</option>
				              <option value="11">11</option>
				              <option value="12">12</option>
				              <option value="13">13</option>
				              <option value="14">14</option>
				              <option value="15">15</option>
				              <option value="16">16</option>
				              <option value="17">17</option>
				              <option value="18">18</option>
				              <option value="19">19</option>
				              <option value="20">20</option>
				              <option value="21">21</option>
				              <option value="22">22</option>
				              <option value="23">23</option>
				             </select>
								</td>
								<!-- 
								<td>
								 <c:forEach begin="0" end="10" varStatus="loop">
									 <option value="00">00</option>
								</c:forEach>
								</td>
								 -->
                           <td>
							<select name="endMinute">
					          <option value="00">00</option>
				              <option value="01">01</option>
				              <option value="02">02</option>
				              <option value="03">03</option>
				              <option value="04">04</option>
				              <option value="05">05</option>
				              <option value="06">06</option>
				              <option value="07">07</option>
				              <option value="08">08</option>
				              <option value="09">09</option>
				              <option value="10">10</option>
				              <option value="11">11</option>
				              <option value="12">12</option>
				              <option value="13">13</option>
				              <option value="14">14</option>
				              <option value="15">15</option>
				              <option value="16">16</option>
				              <option value="2">17</option>
				              <option value="17">18</option>
				              <option value="19">19</option>
				              <option value="20">20</option>
				              <option value="21">21</option>
				              <option value="22">22</option>
				              <option value="23">23</option>
				              <option value="24">24</option>
				              <option value="25">25</option>
				              <option value="25">26</option>
				              <option value="26">27</option>
				              <option value="27">28</option>
				              <option value="29">29</option>
				              <option value="30">30</option>
				              <option value="31">31</option>
				              <option value="32">32</option>
				              <option value="33">33</option>
				              <option value="34">34</option>
				              <option value="35">35</option>
				              <option value="36">36</option>
				              <option value="37">37</option>
				              <option value="38">38</option>
				              <option value="39">39</option>
				              <option value="40">40</option>
				              <option value="41">41</option>
				              <option value="42">42</option>
				              <option value="43">43</option>
				              <option value="44">44</option>
				              <option value="45">45</option>
				              <option value="46">46</option>
				              <option value="47">47</option>
				              <option value="48">48</option>
				              <option value="49">49</option>
				              <option value="50">50</option>
				              <option value="51">51</option>
				              <option value="52">52</option>
				              <option value="53">53</option>
				              <option value="54">54</option>
				              <option value="55">55</option>
				              <option value="56">56</option>
				              <option value="57">57</option>
				              <option value="58">58</option>
				              <option value="59">59</option>
				             </select>
						</td>
						</tr>

					</table>
				</td>
				
			</tr>
			
			<tr class="collector">
			<td>Collector :</td>
		    <td><openmrs_tag:userField formFieldName="cashCollector" initialValue="${cashCollector}" roles="Cashier;Chief Cashier" /></td>
			</tr>
			
			<tr class="insurances">
			<td>Insurance : </td>
				<td>
				  <select name="insuranceId" class="insurance">
				    <option selected="selected">--select--</option>
				    <c:forEach items="${insurances }" var="insurance">
				    <option value="${insurance.insuranceId }">${insurance.name }</option>
				    </c:forEach>
				  </select>
				</td>
			</tr>
		</table>
		<input type="submit" value="Search" id="submitId" />
	</form>
</div>
<c:if test="${not empty paidServiceRevenues}">
<br />
<div id="cashierReport" >
    <h2> Cashier Daily Report</h2>
	Collected Amount :<b>${totalReceivedAmount}</b>
<c:import url="mohBillingServiceRevenue.jsp" />
</div>
<br />
</c:if>
<c:if test="${not empty listOfAllServicesRevenue}">
<div id="rssbReport" style="display: none;" >
<h2> RSSB Report</h2>
<c:import url="mohBillingInsuranceBill.jsp" />
</div>
</c:if>

<c:if test="${not empty listOfAllServicesRevenue}">
<br />
<div id="musaReport" style="display:none">
 <h2>MUSA Report</h2>
</div>
</c:if>

<c:if test="${not empty listOfAllPrivServicesRevenue}">
<br/>
<div id="privateReport" style="display: none;">
 <h2>Private Report</h2>
 <c:import url="mohBillingPrivateCompanyReport.jsp" />
</div>
</c:if>

<c:if test="${not empty departmentsRevenues}">
<br/>
<div id="serviceReport" style="display: none;">
 <h2>Service Report</h2>
 <c:import url="mohBillingDepartment.jsp" />
</div>
</c:if>
<%@ include file="/WEB-INF/template/footer.jsp"%>