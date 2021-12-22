



--drop function  dbo.StudentOfficeIndexItem   select * from dbo.StudentOfficeIndexItem('0001557745','20152016','0365')

CREATE FUNCTION [dbo].[StudentOfficeIndexItem]
	(@PersonID  varchar(13), 
	 @SchoolYear varchar(8),
	 @SchoolCode varchar(8)
	 )
RETURNS   table   
--- Frank Mi
--- 2015.11.06 
 
AS 
  return
    
Select distinct  getdate()							as txtPrintedDate ,
[dbo].[Student.Profile](P.person_id ,'NumberF' )	as txtStudentNumber, 
[dbo].[Student.Profile](P.person_id ,'O-E-N' )		as  txtOEN ,
[dbo].[Student.Profile](P.person_id ,'NumberF2' )	as  txtStudentNum2,  
[dbo].[Student.Profile](P.person_id ,'NumberF2' )	as  txtStudentNum3,
 p.preferred_surname +', '+  P.preferred_first_name+ ' ' + isnull( P.preferred_middle_name,'')  as txtStudentPreferredName ,
  P.legal_surname +', '+P.legal_first_name + ' ' + isnull(P.legal_middle_name,'')				as txtStudentLegalName,
rtrim(P.preferred_surname)+', '+P.legal_first_name + ' ' + isnull(P.legal_middle_name,'')		as txtLegalName2,
 rtrim(P.preferred_surname)+', '+P.legal_first_name + ' ' + isnull(P.legal_middle_name,'')		as txtLegalName3,
isnull(P.birth_date,' ')			as txtStudentBirthdate,
-- isnull(P.birth_verification,' ')	as txtStudentBirthVerify,
-- isnull(P.student_status,'')		as txtStudentStatus,
-- isnull(sm.status_in_canada_expiry_date,' ') as txtStudentExpireDate,
@SchoolCode  as txtSchoolCode,
@SchoolYear  as txtSchoolYear,
dbo.[School.Name](@Schoolcode) as txtSchoolName,
gender as txtStudentGender,
[dbo].[Student.Achievement](P.person_id,@SchoolYear,'Grade') as txtStudentGrade,
[dbo].[Student.Achievement](P.person_id,@SchoolYear,'Grade') as txtGrade,
[dbo].[Student.Achievement](P.person_id,@SchoolYear,'Grade') as txtGrade2,

[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'EffectiveDate') as txtEnrolAdmitDate,
[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'EntryType') as txtEnrolEntryType,
[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'PreviousSchool') as txtEnrolPrevSchool,
[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'NextSchool') as txtEnrolNextSchool,
[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'DemitDate') as txtEnrolDemitDate,
[dbo].[Student.Enrolment](P.person_id,@SchoolYear,'Reason') as txtEnrolReason,

[dbo].[Student.BioGrophic](P.person_id,'OriginalCountry') as txtStudentBirthCountry,
[dbo].[Student.BioGrophic](P.person_id,'ArriveCanada') as txtStudentArrive,
[dbo].[Student.BioGrophic](P.person_id,'StatusOfCanada') as txtStudentCanStatus,
[dbo].[Student.BioGrophic](P.person_id,'SiblingName') as Sibling,
[dbo].[Student.BioGrophic](P.person_id,'HomeLanguage') as txtStudentLanguage,
[dbo].[Student.Health](P.person_id,'HealthCard') as txtStudentHealthCard,
[dbo].[Student.Health](P.person_id,'Medical') as txtStudentMedical,
[dbo].[Student.Health](P.person_id,'Remark') as txtStudentRemark,
[dbo].[Student.Address](P.person_id,'Street') as txtStudentAddress1,
[dbo].[Student.Address](P.person_id,'Apt/Unit') as txtStudentAddress2,
[dbo].[Student.Address](P.person_id,'City') + ' ' +
[dbo].[Student.Address](P.person_id,'Province') +  ' ' +
[dbo].[Student.Address](P.person_id,'PostalCode') as txtStudentAddress3,
[dbo].[Student.Address](P.person_id,'HomePhone') as txtStudentHomePhone,

[dbo].[Student.Religen](P.person_id,'CathlicVerification') as txtStudentCatholicVerify,
case catholic_flag when 'x' then -1 else 0 end as chkStudentCatholicYes,
case catholic_flag when 'x' then 0 else -1 end as chkStudentCatholicNo,
case sacrament_baptism_flag  when 'x' then -1 else 0 end as chkStudentSacBap,
case sacrament_communion_flag when 'x' then -1 else 0 end as chkStudentSacCom,
case sacrament_reconciliation_flag when 'x' then -1 else 0 end as chkStudentSacRec,
case sacrament_confirmation_flag when 'x' then -1 else 0 end as chkStudentSacCon,
[dbo].[Student.Class2](P.person_id,@SchoolYear,'HomeRoomClass') as txtHomeroom2,  -- if homeroom is more than 1    'MULTIPLE HOMEROOMS ASSIGNED'
[dbo].[Student.Class2](P.person_id,@SchoolYear,'HomeRoomClass2') as txtStudentHomeroom2,  -- if no homeroom 'NO HOMEROOM ASSIGNED'
[dbo].[Student.Class2](P.person_id,@SchoolYear,'HomeRoomTeacher') as txtStudentHomeroom,
[dbo].[Student.Class2](P.person_id,@SchoolYear,'HomeRoom') as txtStudentHRRoom,  
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class1') as txtStudentWC1, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher1') as txtStudentWT1, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class2') as txtStudentWC2, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher2') as txtStudentWT2, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class3') as txtStudentWC3, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher3') as txtStudentWT3, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class4') as txtStudentWC4, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher4') as txtStudentWT4, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class5') as txtStudentWC5, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher5') as txtStudentWT5, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class6') as txtStudentWC6, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher6') as txtStudentWT6, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class7') as txtStudentWC7, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher7') as txtStudentWT7, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Class8') as txtStudentWC8, 
[dbo].[Student.ClassWD](P.person_id,@SchoolYear,'Teacher8') as txtStudentWT8, 
 
[dbo].[Student.Parents](P.person_id, 'MotherName') as txtParentMName, 
[dbo].[Student.Parents](P.person_id, 'MotherRelation') as txtParentMRelation, 
[dbo].[Student.Parents](P.person_id, 'MotherEmail') as txtParentMInternet, 
[dbo].[Student.Parents](P.person_id, 'MotherRemark') as txtParentMRemark, 
[dbo].[Student.Parents](P.person_id, 'MotherHomePhone') as txtParentMHome, 
[dbo].[Student.Parents](P.person_id, 'MotherBusinessPhone') as txtParentMBusiness, 
[dbo].[Student.Parents](P.person_id, 'MotherMobialPhone') as txtParentMCell, 
[dbo].[Student.Parents](P.person_id, 'MotherOtherPhone') as txtParentMOtherPhone, 
[dbo].[Student.Parents](P.person_id, 'MotherAddress') as txtParentMAddress, 
[dbo].[Student.Parents](P.person_id, 'FatherName') as txtParentFName, 
[dbo].[Student.Parents](P.person_id, 'FatherRelation') as txtParentFRelation, 
[dbo].[Student.Parents](P.person_id, 'FatherEmail') as txtParentFInternet, 
[dbo].[Student.Parents](P.person_id, 'FatherRemark') as txtParentFRemark, 
[dbo].[Student.Parents](P.person_id, 'FatherHomePhone') as txtParentFHome, 
[dbo].[Student.Parents](P.person_id, 'FatherBusinessPhone') as txtParentFBusiness, 
[dbo].[Student.Parents](P.person_id, 'FatherMobialPhone') as txtParentFCell, 
[dbo].[Student.Parents](P.person_id, 'FatherOtherPhone') as txtParentFOtherPhone, 
[dbo].[Student.Parents](P.person_id, 'FatherAddress') as txtParentFAddress, 
case [dbo].[Student.Parents](P.person_id, 'MotherAccess')  when 'x' then -1 else 0 end as chkParentMAccess, 
case [dbo].[Student.Parents](P.person_id, 'MotherGuardian')  when 'x' then -1 else 0 end as chkParentMGuardian, 
case [dbo].[Student.Parents](P.person_id, 'MotherCustody')  when 'x' then -1 else 0 end as chkParentMCustody, 
case [dbo].[Student.Parents](P.person_id, 'MotherCatholic')  when 'x' then -1 else 0 end as chkParentMCatholic, 
case [dbo].[Student.Parents](P.person_id, 'MotherMail')  when 'x' then -1 else 0 end as chkParentMMail, 
case [dbo].[Student.Parents](P.person_id, 'MotherLanguage')  when 'x' then -1 else 0 end as chkParentMLanguage, 
 [dbo].[Student.Parents](P.person_id, 'MotherDeceased')    as chkParentMDeceased, 
case [dbo].[Student.Parents](P.person_id, 'FatherAccess')  when 'x' then -1 else 0 end as chkParentFAccess, 
case [dbo].[Student.Parents](P.person_id, 'FatherGuardian')  when 'x' then -1 else 0 end as chkParentFGuardian, 
case [dbo].[Student.Parents](P.person_id, 'FatherCustody')  when 'x' then -1 else 0 end as chkParentFCustody, 
case [dbo].[Student.Parents](P.person_id, 'FatherCatholic')  when 'x' then -1 else 0 end as chkParentFCatholic, 
case [dbo].[Student.Parents](P.person_id, 'FatherMail')  when 'x' then -1 else 0 end as chkParentFMail, 
case [dbo].[Student.Parents](P.person_id, 'FatherLanguage')  when 'x' then -1 else 0 end as chkParentFLanguage, 
 [dbo].[Student.Parents](P.person_id, 'FatherDeceased')    as chkParentFDeceased, 

 

 person_id
from  persons   as P

where person_id = @PersonID 
 
 /*
'txtParentFContact' = isnull(fp.primary_contact_priority,' '),
'txtParentFSchoolClose' = isnull(fp.school_closure_priority,' '),

--'txtAName' = isnull(rtrim(pm. preferred_surname),' ')+', '+isnull(pm.preferred_first_name,' '),
'txtAName' = case
		when len(rtrim(pm. preferred_surname)) > 0 then
			isnull(rtrim(pm. preferred_surname),' ')+','
		else '' 
	     end +
		space(1)+isnull(pm.preferred_first_name,' '),


'txtARelation' = isnull(pm.relationship_type_name,' '),
'txtARemark' = isnull(substring(pm.remark,1,50),' '),
--'txtAAddress' = isnull(pa.street,'')+' '+isnull(pa.apt,'')+', '+isnull(pa.City,' ')+', '+isnull(pa.province,'')+' '+isnull(pa.postal_code,' '),
'txtAAddress' = isnull(rtrim(pa.street),'')+ space(1) +			
			case -- To prevent ',' is displayed at the form when data does not exit
	  		  when len(rtrim(pa.apt)) > 0 then 
		 		isnull(rtrim(pa.apt),'')+ ',' + space(1)
			  else ''
			end +
			case
	  		  when len(rtrim(pa.City)) > 0 then 
		 		isnull(rtrim(pa.City),'')+ ',' + space(1)
			  else ''
			end +
			isnull(rtrim(pa.province),'') + space(1) +
			isnull((substring(pa.postal_code,1,3)+space(1)+substring(pa.postal_code,4,3)),' '),


--'txtAHome' = isnull(pt.area_code,' ')+'-'+isnull(pt.phone_no,' '),
'txtAHome' = case 
                when len(rtrim(pt.area_code)) > 0 then
                   '(' +isnull(pt.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(pt.phone_no)) = 7 then 
	           substring(pt.phone_no,1,3)+'-'+ substring(pt.phone_no,4,4)
                else isnull(pt.phone_no,' ')
             end + 
             case  -- display extension number only when it is necessary
                when len(rtrim(pt.extension)) > 0 then
                   '[ext. '+(pt.extension)+']'
                else ''
             end +
             case 
                when pt.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtABusiness' = isnull(ptb.area_code,' ')+'-'+isnull(ptb.phone_no,' ')+'('+isnull(ptb.extension,' ')+')',
--'txtABusiness' = isnull(ptb.area_code,' ')+'-'+isnull(ptb.phone_no,' ')+'(Ext. '+isnull(ptb.extension,' ')+')',
'txtABusiness' = case 
                    when len(rtrim(ptb.area_code)) > 0 then
                       '(' +isnull(ptb.area_code,' ')+') ' 
                    else ''
                 end +
	         case 
                    when len(rtrim(ptb.phone_no)) = 7 then 
		       substring(ptb.phone_no,1,3)+'-'+ substring(ptb.phone_no,4,4)
                    else isnull(ptb.phone_no,' ')
                 end + 
                 case  -- display extension number only when it is necessary
                    when len(rtrim(ptb.extension)) > 0 then
                       '[ext. '+(ptb.extension)+']'
                    else ''
                 end +
                 case 
                    when ptb.publicly_listed <> 'x' then ' (U)'
                    else ''
                 end ,
--'txtACell' = isnull(ptc.area_code,' ')+'-'+isnull(ptc.phone_no,' '),
'txtACell' = case 
                when len(rtrim(ptc.area_code)) > 0 then
                   '(' +isnull(ptc.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(ptc.phone_no)) = 7 then 
		   substring(ptc.phone_no,1,3)+'-'+ substring(ptc.phone_no,4,4)
                else isnull(ptc.phone_no,' ')
             end +
             case 
                when ptc.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtAOtherPhone' = isnull(ptp.area_code,' ')+'-'+isnull(ptp.phone_no,' '),
'txtAOtherPhone' = case 
                      when len(rtrim(ptp.area_code)) > 0 then
                         '(' +isnull(ptp.area_code,' ')+') ' 
                      else ''
                   end +
	           case 
                      when len(rtrim(ptp.phone_no)) = 7 then 
			 substring(ptp.phone_no,1,3)+'-'+ substring(ptp.phone_no,4,4)
                      else isnull(ptp.phone_no,' ')
                   end + 
                   case  -- display extension number only when it is necessary
                      when len(rtrim(ptp.extension)) > 0 then
                         '[ext. '+(ptp.extension)+']'
                      else ''
                   end +
                   case 
                      when ptp.publicly_listed <> 'x' then ' (U)'
                      else ''
                   end ,
--'chkAAccess' =  isnull(pm.access_to_records_flag,' '),
'chkAAccess' = case 
		  when pm.access_to_records_flag = 'x' then -1
		  else 0
	          end,
--'chkAGuardian' = isnull(pm.guardian_flag,' '),
'chkAGuardian' = case 
		    when pm.guardian_flag = 'x' then -1
		    else 0
	            end,
--'chkACustody' = isnull(pm.legal_custody_flag,''),

'chkACustody' = case 
		    when pm.legal_custody_flag = 'x' then -1
		    else 0
	            end,
--'chkACatholic' =  isnull(pm.catholic_flag,' '),
'chkACatholic' = case 
		    when pm.catholic_flag = 'x' then -1
		    else 0
	            end,
--'chkAMail' = isnull(pm.receives_mail_flag,''),
'chkAMail' = case 

		when pm.receives_mail_flag = 'x' then -1
		else 0
	        end,
--'chkALanguage' = isnull(pm.speaks_lang_of_school_flag,''),
'chkALanguage' = case
		   when pm.speaks_lang_of_school_flag = 'x' then -1
		   else 0
	           end,
'chkADeceased' = ' ',

'txtAContact' = isnull(pm.primary_contact_priority,' '),
'txtASchoolClose' = isnull(pm.school_closure_priority,' '),

--'txtBName' = isnull(rtrim(em. preferred_surname),' ')+', '+isnull(em.preferred_first_name,' '),
'txtBName' = case
		when len(rtrim(em. preferred_surname)) > 0 then
			isnull(rtrim(em. preferred_surname),' ')+','
		else '' 
	     end +
		space(1)+isnull(em.preferred_first_name,' '),


'txtBRelation' = isnull(em.relationship_type_name,' '),
'txtBRemark' = isnull(substring(em.remark,1,50),' '),
--'txtBAddress' = isnull(ea.street,'')+' '+isnull(ea.apt,'')+', '+isnull(ea.City,' ')+', '+isnull(ea.province,'')+' '+isnull(ea.postal_code,' '),
'txtBAddress' = isnull(rtrim(ea.street),'')+ space(1) +			
			case -- To prevent ',' is displayed at the form when data does not exit
	  		  when len(rtrim(ea.apt)) > 0 then 
		 		isnull(rtrim(ea.apt),'')+ ',' + space(1)
			  else ''
			end +
			case
	  		  when len(rtrim(ea.City)) > 0 then 
		 		isnull(rtrim(ea.City),'')+ ',' + space(1)
			  else ''
			end +
			isnull(rtrim(ea.province),'') + space(1) +
			isnull((substring(ea.postal_code,1,3)+space(1)+substring(ea.postal_code,4,3)),' '),


--'txtBHome' = isnull(et.area_code,' ')+'-'+isnull(et.phone_no,' '),
'txtBHome' = case 
                when len(rtrim(et.area_code)) > 0 then
                   '(' +isnull(et.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(et.phone_no)) = 7 then 
                   substring(et.phone_no,1,3)+'-'+ substring(et.phone_no,4,4)
                else isnull(et.phone_no,' ')
             end + 
             case  -- display extension number only when it is necessary
                when len(rtrim(et.extension)) > 0 then
                   '[ext. '+(et.extension)+']'
                else ''
             end +
             case 
                when et.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtBBusiness' = isnull(etb.area_code,' ')+'-'+isnull(etb.phone_no,' ')+'('+isnull(etb.extension,' ')+')',
--'txtBBusiness' = isnull(etb.area_code,' ')+'-'+isnull(etb.phone_no,' ')+'(Ext. '+isnull(etb.extension,' ')+')',
'txtBBusiness' = case 
                    when len(rtrim(etb.area_code)) > 0 then
                       '(' +isnull(etb.area_code,' ')+') ' 
                    else ''
                 end +
	         case 
                    when len(rtrim(etb.phone_no)) = 7 then 
		       substring(etb.phone_no,1,3)+'-'+ substring(etb.phone_no,4,4)
                    else isnull(etb.phone_no,' ')
                 end + 
                 case  -- display extension number only when it is necessary
                    when len(rtrim(etb.extension)) > 0 then
                       '[ext. '+(etb.extension)+']'
                    else ''
                 end +
                 case 
                    when etb.publicly_listed <> 'x' then ' (U)'
                    else ''
                 end ,
--'txtBCell' = isnull(etc.area_code,' ')+'-'+isnull(etc.phone_no,' '),
'txtBCell' = case 
                when len(rtrim(etc.area_code)) > 0 then
                   '(' +isnull(etc.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(etc.phone_no)) = 7 then 
	           substring(etc.phone_no,1,3)+'-'+ substring(etc.phone_no,4,4)
                else isnull(etc.phone_no,' ')
             end +
             case 
                when etc.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtBOtherPhone' = isnull(etp.area_code,' ')+'-'+isnull(etp.phone_no,' '),
'txtBOtherPhone' = case 
                      when len(rtrim(etp.area_code)) > 0 then
                         '(' +isnull(etp.area_code,' ')+') ' 
                      else ''
                   end +
	           case 
                      when len(rtrim(etp.phone_no)) = 7 then 

			 substring(etp.phone_no,1,3)+'-'+ substring(etp.phone_no,4,4)
                      else isnull(etp.phone_no,' ')
                   end + 

                   case  -- display extension number only when it is necessary
                      when len(rtrim(etp.extension)) > 0 then
                         '[ext. '+(etp.extension)+']'
                      else ''
                   end +
                   case 
                      when etp.publicly_listed <> 'x' then ' (U)'
                      else ''
                   end ,
--'chkBAccess' =  isnull(em.access_to_records_flag,' '),
'chkBAccess' = case
		  when em.access_to_records_flag = 'x' then -1
		  else 0
		  end,
--'chkBGuardian' = isnull(em.guardian_flag,' '),
'chkBGuardian' = case
		    when em.guardian_flag = 'x' then -1
		    else 0
		    end,
--'chkBCustody' = isnull(em.legal_custody_flag,''),
'chkBCustody' = case
		   when em.legal_custody_flag = 'x' then -1
		   else 0
		   end,
--'chkBCatholic' =  isnull(em.catholic_flag,' '),
'chkBCatholic' = case
		    when em.catholic_flag = 'x' then -1
		    else 0
		    end,
--'chkBMail' = isnull(em.receives_mail_flag,''),
'chkBMail' = case
		when em.receives_mail_flag = 'x' then -1
		else 0
		end,
--'chkBLanguage' = isnull(em.speaks_lang_of_school_flag,''),
'chkBLanguage' = case
		    when em.speaks_lang_of_school_flag = 'x' then -1
		    else 0
		    end,
'chkBDeceased' = ' ',
'txtBContact' = isnull(em.primary_contact_priority,' '),
'txtBSchoolClose' = isnull(em.school_closure_priority,' '),

--'txtCName' = isnull(rtrim(ems. preferred_surname),' ')+', '+isnull(ems.preferred_first_name,' '),
'txtCName' = case
		when len(rtrim(ems. preferred_surname)) > 0 then
			isnull(rtrim(ems. preferred_surname),' ')+','
		else '' 
	     end +
		space(1)+isnull(ems.preferred_first_name,' '),

'txtCRelation' = isnull(ems.relationship_type_name,' '),
'txtCRemark' = isnull(substring(ems.remark,1,50),' '),
--'txtCAddress' = isnull(eas.street,'')+' '+isnull(eas.apt,'')+', '+isnull(eas.City,' ')+', '+isnull(eas.province,'')+' '+isnull(eas.postal_code,' '),
'txtCAddress' = isnull(rtrim(eas.street),'')+ space(1) +			
			case -- To prevent ',' is displayed at the form when data does not exit
	  		  when len(rtrim(eas.apt)) > 0 then 
		 		isnull(rtrim(eas.apt),'')+ ',' + space(1)
			  else ''
			end +
			case
	  		  when len(rtrim(eas.City)) > 0 then 
		 		isnull(rtrim(eas.City),'')+ ',' + space(1)
			  else ''
			end +
			isnull(rtrim(eas.province),'') + space(1) +
			isnull((substring(eas.postal_code,1,3)+space(1)+substring(eas.postal_code,4,3)),' '),


--'txtCHome' = isnull(ets.area_code,' ')+'-'+isnull(ets.phone_no,' '),
'txtCHome' = case 
                when len(rtrim(ets.area_code)) > 0 then
                   '(' +isnull(ets.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(ets.phone_no)) = 7 then 
		   substring(ets.phone_no,1,3)+'-'+ substring(ets.phone_no,4,4)
                else isnull(ets.phone_no,' ')
             end + 
             case  -- display extension number only when it is necessary
                when len(rtrim(ets.extension)) > 0 then
                   '[ext. '+(ets.extension)+']'
                else ''
             end +
             case 
                when ets.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtCBusiness' = isnull(etbs.area_code,' ')+'-'+isnull(etbs.phone_no,' ')+'('+isnull(etbs.extension,' ')+')',
--'txtCBusiness' = isnull(etbs.area_code,' ')+'-'+isnull(etbs.phone_no,' ')+'(Ext. '+isnull(etbs.extension,' ')+')',
'txtCBusiness' = case 
                    when len(rtrim(etbs.area_code)) > 0 then
                       '(' +isnull(etbs.area_code,' ')+') ' 
                    else ''
                 end +
	         case 
                    when len(rtrim(etbs.phone_no)) = 7 then 
		       substring(etbs.phone_no,1,3)+'-'+ substring(etbs.phone_no,4,4)
                    else isnull(etbs.phone_no,' ')
                 end + 
                 case  -- display extension number only when it is necessary
                    when len(rtrim(etbs.extension)) > 0 then
                       '[ext. '+(etbs.extension)+']'
                    else ''
                 end +
                 case 
                    when etbs.publicly_listed <> 'x' then ' (U)'
                    else ''
                 end ,
--'txtCCell' = isnull(etcs.area_code,' ')+'-'+isnull(etcs.phone_no,' '),
'txtCCell' = case 
                when len(rtrim(etcs.area_code)) > 0 then
                   '(' +isnull(etcs.area_code,' ')+') ' 
                else ''
             end +
	     case 
                when len(rtrim(etcs.phone_no)) = 7 then 
		   substring(etcs.phone_no,1,3)+'-'+ substring(etcs.phone_no,4,4)
                else isnull(etcs.phone_no,' ')
             end +
             case 
                when etcs.publicly_listed <> 'x' then ' (U)'
                else ''
             end ,
--'txtCOtherPhone' = isnull(etps.area_code,' ')+'-'+isnull(etps.phone_no,' '),
'txtCOtherPhone' = case 
                      when len(rtrim(etps.area_code)) > 0 then
                         '(' +isnull(etps.area_code,' ')+') ' 
                      else ''
                   end +
	           case 
                      when len(rtrim(etps.phone_no)) = 7 then 
			 substring(etps.phone_no,1,3)+'-'+ substring(etps.phone_no,4,4)
                      else isnull(etps.phone_no,' ')
                   end + 
                   case  -- display extension number only when it is necessary
                      when len(rtrim(etps.extension)) > 0 then
                         '[ext. '+(etps.extension)+']'
                      else ''
                   end +
                   case 
                      when etps.publicly_listed <> 'x' then ' (U)'
                      else ''
                   end ,
--'chkCAccess' =  isnull(ems.access_to_records_flag,' '),
'chkCAccess' = case
		  when ems.access_to_records_flag = 'x' then -1
		  else 0
		  end,
--'chkCGuardian' = isnull(ems.guardian_flag,' '),
'chkCGuardian' = case
		    when ems.guardian_flag = 'x' then -1
		    else 0
		    end,
--'chkCCustody' = isnull(ems.legal_custody_flag,''),
'chkCCustody' = case
		   when ems.legal_custody_flag = 'x' then -1
		   else 0
		   end,
--'chkCCatholic' =  isnull(ems.catholic_flag,' '),
'chkCCatholic' = case
		    when ems.catholic_flag = 'x' then -1
		    else 0
		    end,
--'chkCMail' = isnull(ems.receives_mail_flag,''),
'chkCMail' = case
	        when ems.receives_mail_flag = 'x' then -1
		else 0
		end,
--'chkCLanguage' = isnull(ems.speaks_lang_of_school_flag,''),
'chkCLanguage' = case
		    when ems.speaks_lang_of_school_flag = 'x' then -1
		    else 0
		    end,
'chkCDeceased' = ' ',
'txtCContact' = isnull(ems.primary_contact_priority,' '),
'txtCSchoolClose' = isnull(ems.school_closure_priority,' ')




--Dummy fields for future use
'txtCat1' = isnull(sn.full_name_1,'') , 
'txtNote1' = case
		when sn.public_access_flag_1 = 'x' then 
 		   isnull(sn.notepad_subject_1,'') + ' -- ' + isnull(sn.notepad_text_1,'')
                else ''
             end ,
'chkAlert1' = case 
                  when sn.alert_flag_1 = 'x' then -1
                  else 0
              end ,  	
'FrameNotepad1' = case 
		      when sn.public_access_flag_1 = 'x' then 1
		      when sn.public_access_flag_1 <> 'x' and 
			   len(rtrim(sn.full_name_1)) > 0 then 2
		      else 0 
		  end,

'txtCat2' = isnull(sn.full_name_2,'') , 
'txtNote2' = case
		when sn.public_access_flag_2 = 'x' then 
 		   isnull(sn.notepad_subject_2,'') + ' ' + isnull(sn.notepad_text_2,'')
                else ''
             end ,
'chkAlert2' = case 
                  when sn.alert_flag_2 = 'x' then -1
                  else 0
              end ,  	
'FrameNotepad2' = case 
		      when sn.public_access_flag_2 = 'x' then 1
		      when sn.public_access_flag_2 <> 'x' and 
			   len(rtrim(sn.full_name_2)) > 0 then 2
		      else 0 
		  end,

'txtCat3' = isnull(sn.full_name_3,'') , 
'txtNote3' = case
		when sn.public_access_flag_3 = 'x' then 
 		   isnull(sn.notepad_subject_3,'') + ' ' + isnull(sn.notepad_text_3,'')
                else ''
             end ,
'chkAlert3' = case 
                  when sn.alert_flag_3 = 'x' then -1
                  else 0
              end ,  	
'FrameNotepad3' = case 
		      when sn.public_access_flag_3 = 'x' then 1
		      when sn.public_access_flag_3 <> 'x' and 
			   len(rtrim(sn.full_name_3)) > 0 then 2
		      else 0
		  end,

'txtCat4' = isnull(sn.full_name_4,'') , 
'txtNote4' = case
		when sn.public_access_flag_4 = 'x' then 
 		   isnull(sn.notepad_subject_4,'') + ' ' + isnull(sn.notepad_text_4, '')
                else ''
             end ,

'chkAlert4' = case 
                  when sn.alert_flag_3 = 'x' then -1
                  else 0
              end ,  	
'FrameNotepad4' = case 
		      when sn.public_access_flag_4 = 'x' then 1
		      when sn.public_access_flag_4 <> 'x' and 
                           len(rtrim(sn.full_name_4)) > 0 then 2
		      else 0
		  end,


-- end of dummy fields

GO


*/
