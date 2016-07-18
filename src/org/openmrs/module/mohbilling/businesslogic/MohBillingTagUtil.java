/**
 * 
 */
package org.openmrs.module.mohbilling.businesslogic;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;
import java.util.Set;

import org.openmrs.api.context.Context;
import org.openmrs.module.mohbilling.model.BillPayment;
import org.openmrs.module.mohbilling.model.Consommation;
import org.openmrs.module.mohbilling.model.GlobalBill;
import org.openmrs.module.mohbilling.model.PatientBill;
import org.openmrs.module.mohbilling.model.PatientServiceBill;
import org.openmrs.module.mohbilling.model.ThirdPartyBill;
import org.openmrs.module.mohbilling.service.BillingService;



/**
 * @author @EMR RBC
 * 
 */
public class MohBillingTagUtil {

	public static String getTotalAmountPaidByPatientBill(Integer consommationId) {
		Long amountPaid = 0l;
		if (null == consommationId)
			return "";
		else {
			try {
				Consommation consomm = Context.getService(BillingService.class).getConsommation(consommationId);
				
				PatientBill pb = consomm.getPatientBill();
			     Set<BillPayment> allPayments =pb.getPayments();
			     if (allPayments !=null) {
			    	 for (BillPayment billPayment : allPayments) {
			    		 
			    		 amountPaid = amountPaid + billPayment.getAmountPaid().longValue();			    		 
						
					}
					
				}


			} catch (Exception e) {
				e.printStackTrace();
				return "";
			}
		}

		return "" + amountPaid;
	}
	
	/**
	 * Gets the REST of the whole Patient Bill
	 * 
	 * @param patientBillId
	 *            the patient bill ID
	 * @return the REST that is in String
	 */
	public static String getTotalAmountNotPaidByPatientBill(Integer consommationId) {

		double amountNotPaid = 0d;
//		MathContext mc = new MathContext(BigDecimal.ROUND_HALF_DOWN);

		if (null == consommationId)
			return "";
		else {
			try {
				double amountPaid = 0d;
				Consommation consomm = Context.getService(BillingService.class).getConsommation(consommationId);
				Float insuranceRate = consomm.getBeneficiary().getInsurancePolicy()
						.getInsurance().getCurrentRate().getRate();
				Float patientRate = (100f - insuranceRate) / 100f;			
				
				double amountDueByPatient = 0.0; //get the due Amount from patientBill				
			
				for (PatientServiceBill psb : consomm.getBillItems()) {
					Double cost = psb.getUnitPrice().doubleValue()*psb.getQuantity().doubleValue();
					amountDueByPatient+=cost*patientRate.doubleValue();
				}
	
				for (BillPayment bp : consomm.getPatientBill().getPayments()) {
					amountPaid = amountPaid + bp.getAmountPaid().doubleValue();
				}

				if (consomm.getBeneficiary().getInsurancePolicy().getThirdParty() == null) {
					amountNotPaid = amountDueByPatient - amountPaid;

				} else {
					
					double amountPaidByThirdPart = consomm.getThirdPartyBill().getAmount().doubleValue();	

					amountNotPaid = amountDueByPatient - (amountPaidByThirdPart + amountPaid);

					}

			} catch (Exception e) {
				e.printStackTrace();
				return "";
			}
		}

		/** Rounding the value to 2 decimals */
		double roundedAmountNotPaid = Math.round(amountNotPaid * 100);
		roundedAmountNotPaid = roundedAmountNotPaid / 100;

		return "" + roundedAmountNotPaid;
	}	

	public static String getAmountPaidByThirdPart(Integer consommationId) {

		Double amountPaidByThirdPart = 0d;
		if(consommationId == null)
			return "";
	else {
		try {
			
			Consommation consomm = Context.getService(BillingService.class).getConsommation(consommationId);
			amountPaidByThirdPart =+consomm.getThirdPartyBill().getAmount().doubleValue();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
		return ""+ amountPaidByThirdPart;
	}
	public static String getGlobalPaidAmountFromGlobalBill(Integer globalBillId){
		
		double allPaidAmount = 0d;
		GlobalBill globalBill = Context.getService(BillingService.class).GetGlobalBill(globalBillId);
		
		List<Consommation> consommations = Context.getService(BillingService.class).getAllConsommationByGlobalBill(globalBill);
		
		for (Consommation consommation : consommations) {
			
		allPaidAmount =allPaidAmount+Double.valueOf(getTotalAmountPaidByPatientBill(consommation.getConsommationId()));			
		}
		return ""+allPaidAmount;		
	}

}
