
      
CREATE    PROCEDURE [dbo].[Ar_check_for_iao_doc](@leadid INT)      
AS      
  BEGIN      
  DECLARE @is_iao_AOF_Present INT,    
  @is_iao_BSA_Present INT,    
  @is_iao_KFS_Present INT,    
  @is_iao_Indemnity_Present INT,    
  @is_iao_EDD_Present INT,    
  @is_iao_EIDA_Present INT    
    
    
      SELECT @is_iao_AOF_Present=    
    CASE      
               WHEN EXISTS (SELECT 1      
                            FROM   leads l      
                                   INNER JOIN attachmentmaster a      
                                           ON l.ownerid = a.ownerid      
                                              AND l.leadid = a.itemid      
                                   INNER JOIN dmsmaster d      
                                           ON a.ownerid = d.ownerid      
                                              AND a.attachedid = d.itemid      
                            WHERE  l.ownerid = 716      
                                   AND l.leadid = @leadid    
           --AND l.StatusCodeID =  sent for approval    
                                   --AND A.CUSTOMFIELDID != 0      
                                   AND ( Itemname LIKE 'Account Opening Form%' )) THEN 1      
               ELSE 0      
             END ;    
      SELECT @is_iao_BSA_Present = CASE      
               WHEN EXISTS (SELECT 1      
                            FROM   leads l      
                                   INNER JOIN attachmentmaster a      
                                           ON l.ownerid = a.ownerid      
                                              AND l.leadid = a.itemid      
                                   INNER JOIN dmsmaster d      
                                           ON a.ownerid = d.ownerid      
                                              AND a.attachedid = d.itemid      
                            WHERE  l.ownerid = 716      
                                   AND l.leadid = @leadid      
                                   --AND A.CUSTOMFIELDID != 0      
                                   AND ( Itemname LIKE 'BSA Form%' )) THEN 1      
               ELSE 0      
             END ;    
       SELECT @is_iao_KFS_Present = CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   leads l                  
                                   INNER JOIN attachmentmaster a                  
                                           ON l.ownerid = a.ownerid                  
                                              AND l.leadid = a.itemid                  
                                   INNER JOIN dmsmaster d                  
                                           ON a.ownerid = d.ownerid                  
                                              AND a.attachedid = d.itemid                  
                            WHERE  l.ownerid = 716                  
                                   AND l.leadid = @leadid                  
                                   --AND A.CUSTOMFIELDID != 0                  
                                   AND ( Itemname LIKE 'KFS%' )) THEN 1                  
               ELSE 0                  
             END ;    
    SELECT  @is_iao_Indemnity_Present = CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   leads l                  
                                   INNER JOIN attachmentmaster a                  
                                           ON l.ownerid = a.ownerid                  
                                              AND l.leadid = a.itemid                  
                                   INNER JOIN dmsmaster d                  
                                           ON a.ownerid = d.ownerid                  
                                              AND a.attachedid = d.itemid                  
                            WHERE  l.ownerid = 716                  
                                   AND l.leadid = @leadid           
                                   --AND A.CUSTOMFIELDID != 0                  
                                   AND ( Itemname LIKE 'Indemnity%' )) THEN 1                  
               ELSE 0                  
             END ;    
     SELECT @is_iao_EDD_Present = CASE          
               WHEN EXISTS (SELECT 1          
                            FROM   leads l          
                                   INNER JOIN attachmentmaster a          
                                           ON l.ownerid = a.ownerid          
                                              AND l.leadid = a.itemid          
                                   INNER JOIN dmsmaster d          
                                           ON a.ownerid = d.ownerid          
                                              AND a.attachedid = d.itemid          
                            WHERE  l.ownerid = 716          
                                   AND l.leadid = @leadid          
                                   --AND A.CUSTOMFIELDID != 0          
                                   AND ( Itemname LIKE 'Enhanced Due Deligence%' )) THEN 1          
               ELSE 0          
             END ;    
    SELECT @is_iao_EIDA_Present = CASE          
               WHEN EXISTS (SELECT 1          
                            FROM   leads l          
                                   INNER JOIN attachmentmaster a          
                                           ON l.ownerid = a.ownerid          
                                              AND l.leadid = a.itemid          
                                   INNER JOIN dmsmaster d          
                                           ON a.ownerid = d.ownerid          
                                              AND a.attachedid = d.itemid          
                            WHERE  l.ownerid = 716          
                                   AND l.leadid = @leadid          
                                   --AND A.CUSTOMFIELDID != 0          
                                   AND ( Itemname LIKE 'EIDA%' )) THEN 1          
               ELSE 0          
             END ;    
    
  update Lea_ex3 set Lea_ex3_162 = @is_iao_EDD_Present where ownerid=716 and Lea_ex3_id = @leadid  
  update Lea_ex5 set Lea_ex5_14 = @is_iao_AOF_Present,Lea_ex5_15 = @is_iao_BSA_Present where ownerid=716 and Lea_ex5_id = @leadid  
  update Lea_Ex9 set Lea_Ex9_141 = @is_iao_EIDA_Present,  
      Lea_Ex9_143 = @is_iao_KFS_Present  ,  
      Lea_Ex9_66 = @is_iao_Indemnity_Present  
  where ownerid=716 and Lea_Ex9_id = @leadid 
  update Lea_Ex6 set Lea_Ex6_93 = '1' where ownerid=716 and Lea_Ex6_id = @leadid 
    
    Select @is_iao_AOF_Present as is_iao_AOF_Present ,    
    @is_iao_BSA_Present as is_iao_BSA_Present,    
    @is_iao_KFS_Present as is_iao_KFS_Present,     
    @is_iao_Indemnity_Present as is_iao_Indemnity_Present,     
    @is_iao_EDD_Present as is_iao_EDD_Present,     
    @is_iao_EIDA_Present as is_iao_EIDA_Present    
  END      
--exec Ar_check_for_IAO_doc 50023555 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_PB_RESIDENT_NO]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_PB_RESIDENT_NO]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ADIB_PB_RESIDENT_NO] (   --@EID_AVAILABLE INT    
@EID_AVAILABLE NVARCHAR(256) ) 
AS  
BEGIN  
IF @EID_AVAILABLE IN ('EIDA', 'OCR')  
BEGIN 
SELECT   
'' AS 'EID_FULL_NAME',   
'' AS 'EID_ISSUE_DATE',  
'' AS 'EID_EXPIRY_DATE',  
'' AS 'NATIONALITY',    
'' AS 'NATIONALITY_CODE', 
'' AS 'RESIDENCE_PHONE_NUMBER', 
'' AS 'PLACE_OF_BIRTH',   
'' AS 'EIDA_SCAN_STATUS',  
'' AS 'EMIRATES_ID',   
'' AS 'CARD_NUMBER',   
'' AS 'EMIRATES_OCR_RESPONSE_BACKST',  
'' AS 'EMIRATES_OCR_RESPONSE_FRONT',  
'' AS 'EMIRATES_OCR_RESPONSE_BACK_CODE', 
'' AS 'EMIRATES_OCR_RESPONSE_FRONT_CODE', 
'' AS 'EID_STATUS',   
NULL AS 'DOCUMENT_BACK',  
NULL AS 'DOCUMENT_FRONT', 
'' AS 'STREET',   
'' AS 'AREA', 
'' AS 'CITY', 
'' AS 'EMIRATES', 
'' AS 'EIDA_MODE',  
'' AS 'GENDER', 
'' AS 'DOB',   
'' AS 'COMPANYNAME',    
'' AS 'EIDABACKSTATUS',
NULL AS 'DIGITAL DOCUMENT_BACK',  
NULL AS 'DIGITAL DOCUMENT_FRONT'
END 
ELSE
BEGIN 
SELECT    1 AS 'OUTPUT'    
END   
END 

GO




GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EDD_PDF_FORM]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[EDD_PDF_FORM]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EDD_PDF_FORM] (                  
        @OWNERID1 INT,     
        @LEADID1 INT,     
        @ISSUEID1 INT                  
       )                
AS    
DECLARE @EDD_Net_Worth  NVARCHAR(256)     =''           
DECLARE @EDD_Gov_Years_Of_Service_1  NVARCHAR(256)   =''             
DECLARE @EDD_Gov_Size_Of_Company1  NVARCHAR(256)=''                
DECLARE @EDD_Gov_Size_Of_Company2  NVARCHAR(256) =''               
DECLARE @EDD_Gov_Years_Of_Service_2  NVARCHAR(256)  =''              
DECLARE @EDD_Pub_Size_Of_Company1  NVARCHAR(256) =''             
DECLARE @EDD_Pub_Size_Of_Company2  NVARCHAR(256) =''               
DECLARE @EDD_Pub_Years_Of_Service_1  NVARCHAR(256) =''               
DECLARE @EDD_Pvt_Years_Of_Service_2  NVARCHAR(256) =''               
DECLARE @EDD_Pvt_Years_Of_Service_1  NVARCHAR(256)=''                
DECLARE @EDD_Pub_Years_Of_Service_2  NVARCHAR(256)=''                
DECLARE @EDD_Pvt_Size_Of_Company1  NVARCHAR(256) =''               
DECLARE @EDD_Pvt_Size_Of_Company2  NVARCHAR(256) =''               
DECLARE @EDD_Business_Own_Percent1  NVARCHAR(256)=''                
DECLARE @EDD_Business_Own_Percent2  NVARCHAR(256) =''               
DECLARE @EDD_Business_Estimated_Net1  NVARCHAR(256)=''                
DECLARE @EDD_Business_Estimated_Net2  NVARCHAR(256) =''               
DECLARE @EDD_Equity_Number_of_Shares1  NVARCHAR(256) =''               
DECLARE @EDD_Equity_Number_of_Shares2  NVARCHAR(256) =''               
DECLARE @EDD_Business_Estimated_Value1  NVARCHAR(256) =''               
DECLARE @EDD_Business_Estimated_Value2  NVARCHAR(256) =''                 
DECLARE @EDD_Other_Investment_Estimated1  NVARCHAR(256) =''                 
DECLARE @EDD_Other_Investment_Estimated2  NVARCHAR(256) =''                 
DECLARE @EDD_Credit_Outstanding_Finance1  NVARCHAR(256) =''                 
DECLARE @EDD_Credit_Outstanding_Finance2  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Outstanding_Finance1  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Outstanding_Finance2  NVARCHAR(256) =''                 
DECLARE @EDD_Lead_ID  NVARCHAR(256) =''                 
DECLARE @EDD_RIM_ID  NVARCHAR(256)  =''                
DECLARE @EDD_AGE_Num  NVARCHAR(256) =''                 
DECLARE @EDD_Customer_Name  NVARCHAR(256)  =''                
DECLARE @EDD_Telephone  NVARCHAR(256) =''                 
DECLARE @EDD_Married_Status  NVARCHAR(256) =''                 
DECLARE @EDD_Created_Date NVARCHAR(256)  =''                
DECLARE @EDD_Others  NVARCHAR(256)  =''                
DECLARE @EDD_Offshore  NVARCHAR(256)  =''                
DECLARE @EDD_Staff_ID  NVARCHAR(256)  =''                
DECLARE @EDD_Address  NVARCHAR(256) =''                 
DECLARE @EDD_Email  NVARCHAR(256) =''                 
DECLARE @EDD_New_Cust_Prospect  NVARCHAR(256)  =''                
DECLARE @EDD_Relationship_Manager  NVARCHAR(256) =''                 
DECLARE @EDD_Married  NVARCHAR(256)   =''               
DECLARE @EDD_Nationality  NVARCHAR(256) =''                 
DECLARE @EDD_ADIB_Name2  NVARCHAR(256) =''                 
DECLARE @EDD_ADIB_Type1  NVARCHAR(256) =''                 
DECLARE @EDD_ADIB_Name  NVARCHAR(256) =''                 
DECLARE @EDD_Credit_Name_Bank2  NVARCHAR(256) =''                 
DECLARE @EDD_Wealth  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Type_Relationship2  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Type_Relationship1  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Name_Bank1  NVARCHAR(256) =''                 
DECLARE @EDD_Credit_Name_Bank1  NVARCHAR(256)   =''               
DECLARE @EDD_Credit_Type_Relationship2  NVARCHAR(256) =''                 
DECLARE @EDD_Liabilities_Name_Bank2  NVARCHAR(256) =''                 
DECLARE @EDD_Credit_Type_Relationship1  NVARCHAR(256)  =''                
DECLARE @EDD_Other_Investment_Description2  NVARCHAR(256) =''                 
DECLARE @EDD_Other_Investment_Description1  NVARCHAR(256) =''                 
DECLARE @EDD_Other_Investment_Type2  NVARCHAR(256) =''                 
DECLARE @EDD_Other_Investment_Type1  NVARCHAR(256) =''                 
DECLARE @EDD_Pledge2  NVARCHAR(256) =''                 
DECLARE @EDD_Pledge  NVARCHAR(256) =''                 
DECLARE @EDD_Equity_Country_Name2  NVARCHAR(256)  =''                
DECLARE @EDD_Equity_Country_Name1  NVARCHAR(256)  =''                
DECLARE @EDD_Equity_Company_Name2 NVARCHAR(256) =''                 
DECLARE @EDD_Equity_Company_Name1  NVARCHAR(256)  =''                
DECLARE @EDD_Business_Own_Country_Operation2  NVARCHAR(256) =''                 
DECLARE @EDD_Business_Own_Country_Operation1  NVARCHAR(256) =''                 
DECLARE @EDD_Business_Own_Principal_Activity2  NVARCHAR(256) =''                 
DECLARE @EDD_Business_Own_Principal_Activity1  NVARCHAR(256) =''                 
DECLARE @EDD_Business_Own_Company_Name2  NVARCHAR(256) =''                 
DECLARE @EDD_Business_Own_Company_Name1  NVARCHAR(256) =''                 
DECLARE @EDD_History_Comment  NVARCHAR(256) =''                 
DECLARE @EDD_Pvt_Company_Name2  NVARCHAR(256) =''                 
DECLARE @EDD_Pvt_Company_Name1  NVARCHAR(256) =''                 
DECLARE @EDD_Pvt_Title2  NVARCHAR(256)  =''                
DECLARE @EDD_Pvt_Title1  NVARCHAR(256) =''                 
DECLARE @EDD_Pub_Title1  NVARCHAR(256) =''                 
DECLARE @EDD_Pub_Title2  NVARCHAR(256) =''                 
DECLARE @EDD_Pub_Company_Name2  NVARCHAR(256)  =''                
DECLARE @EDD_Pub_Company_Name1  NVARCHAR(256) =''                 
DECLARE @EDD_Gov_Company_Name2  NVARCHAR(256) =''                 
DECLARE @EDD_Gov_Title2  NVARCHAR(256) =''                 
DECLARE @EDD_Gov_Company_Name1  NVARCHAR(256) =''                 
DECLARE @EDD_Gov_Title1  NVARCHAR(256) =''                 
DECLARE @EDD_Education  NVARCHAR(256)  =''                
DECLARE @EDD_Language_Spoken  NVARCHAR(256) =''                 
DECLARE @EDD_Fax  NVARCHAR(256) =''                 
DECLARE @EDD_PNNW_signed  NVARCHAR(256)  =''                
DECLARE @EDD_PNWS_Attached  NVARCHAR(256)  =''                
DECLARE @EDD_Client_Introduced_By  NVARCHAR(256)   =''               
DECLARE @EDD_ADIBType2  NVARCHAR(256)  =''                
declare @sql NVARCHAR(Max)          
declare @sql_1 NVARCHAR(Max)          
declare @sql1 NVARCHAR(Max)           
declare @sql2 NVARCHAR(Max)          
declare @sql3 NVARCHAR(Max)           
declare @sql4 NVARCHAR(MAX)           
declare @sql5 NVARCHAR(MAX)          
declare @sql6 NVARCHAR(MAX)          
declare @sql7 NVARCHAR(MAX)          
declare @sql8 NVARCHAR(MAX)          
declare @sql9 NVARCHAR(MAX)           
declare @sql10 NVARCHAR(MAX)           
declare @sql11 NVARCHAR(MAX)          
declare @sql12 NVARCHAR(MAX)           
declare @sql13 NVARCHAR(MAX)           
declare @sql14 NVARCHAR(MAX)           
declare @sql15 NVARCHAR(MAX)           
declare @sql16 NVARCHAR(MAX)          
declare @sql17 NVARCHAR(MAX)          
declare @sql18 NVARCHAR(MAX)          
declare @sql19 NVARCHAR(MAX)          
declare @sql20 NVARCHAR(MAX)          
declare @sql21 NVARCHAR(MAX)          
declare @sql22 NVARCHAR(MAX)          
declare @sql23 NVARCHAR(MAX)          
declare @sql24 NVARCHAR(MAX)          
declare @sql25 NVARCHAR(MAX)          
declare @sql26 NVARCHAR(MAX)          
declare @sql27 NVARCHAR(MAX)          
declare @sql28 NVARCHAR(MAX)          
declare @sql29 NVARCHAR(MAX)          
declare @sql30 NVARCHAR(MAX)          
declare @sql32 NVARCHAR(MAX)          
declare @sql33 NVARCHAR(MAX)          
declare @sql31 NVARCHAR(MAX)          
declare @sql34 NVARCHAR(MAX)          
declare @sql35 NVARCHAR(MAX)          
declare @sql36 NVARCHAR(MAX)          
declare @sql37 NVARCHAR(MAX)          
declare @sql38 NVARCHAR(MAX)          
declare @sql39 NVARCHAR(MAX)           
declare @sql40 NVARCHAR(MAX)          
declare @sql41 NVARCHAR(MAX)          
declare @sql42 NVARCHAR(MAX)          
declare @sql43 NVARCHAR(MAX)          
declare @sql44 NVARCHAR(MAX)          
declare @sql45 NVARCHAR(MAX)    
declare @sql46 NVARCHAR(MAX)          
declare @sql47 NVARCHAR(MAX)          
declare @sql48 NVARCHAR(MAX)          
declare @sql49 NVARCHAR(MAX)           
declare @sql50 NVARCHAR(MAX)          
declare @sql51 NVARCHAR(MAX)          
declare @sql52 NVARCHAR(MAX)          
declare @sql53 NVARCHAR(MAX)     
declare @sql54 NVARCHAR(MAX)          
declare @sql55 NVARCHAR(MAX)          
declare @sql56 NVARCHAR(MAX)          
declare @sql57 NVARCHAR(MAX)          
declare @sql58 NVARCHAR(MAX)          
declare @sql59 NVARCHAR(MAX)          
declare @sql60 NVARCHAR(MAX)          
declare @sql61 NVARCHAR(MAX)          
declare @sql62 NVARCHAR(MAX)          
declare @sql63 NVARCHAR(MAX)          
declare @sql64 NVARCHAR(MAX)          
declare @sql65 NVARCHAR(MAX)          
declare @sql66 NVARCHAR(MAX)          
declare @sql67 NVARCHAR(MAX)     
declare @sql68 NVARCHAR(MAX)    
declare @sql69 NVARCHAR(MAX)  
declare @sql70 NVARCHAR(MAX)    
declare @sql71 NVARCHAR(MAX)    
declare @sql72 NVARCHAR(MAX)    
declare @sql73 NVARCHAR(MAX)    
declare @sql74 NVARCHAR(MAX)    
declare @sql75 NVARCHAR(MAX)    
declare @sql76 NVARCHAR(MAX)   
DECLARE @leadid int                
                
BEGIN                   
                
SELECT     
 @EDD_Net_Worth =isnull(Iss_ex7_44,'')          
,@EDD_Gov_Years_Of_Service_1 =isnull(Iss_ex7_43,'')          
,@EDD_Gov_Size_Of_Company1 =isnull(Iss_ex7_42,'')          
,@EDD_Gov_Size_Of_Company2 =isnull(Iss_ex7_41,'')          
,@EDD_Gov_Years_Of_Service_2 =isnull(Iss_ex7_40,'')          
,@EDD_Pub_Size_Of_Company1 =isnull(Iss_ex7_39,'')          
,@EDD_Pub_Size_Of_Company2 =isnull(Iss_ex7_38,'')          
,@EDD_Pub_Years_Of_Service_1 =isnull(Iss_ex7_37,'')          
,@EDD_Pvt_Years_Of_Service_2 =isnull(Iss_ex7_36,'')          
,@EDD_Pvt_Years_Of_Service_1 =isnull(Iss_ex7_35,'')          
,@EDD_Pub_Years_Of_Service_2 =isnull(Iss_ex7_34,'')          
,@EDD_Pvt_Size_Of_Company1 =isnull(Iss_ex7_33,'')          
,@EDD_Pvt_Size_Of_Company2 =isnull(Iss_ex7_32,'')          
,@EDD_Business_Own_Percent1 =isnull(Iss_ex7_31,'')          
,@EDD_Business_Own_Percent2 =isnull(Iss_ex7_30,'')          
,@EDD_Business_Estimated_Net1 =isnull(Iss_ex7_29,'')          
,@EDD_Business_Estimated_Net2 =isnull(Iss_ex7_28,'')          
,@EDD_Equity_Number_of_Shares1 =isnull(Iss_ex7_27,'')          
,@EDD_Equity_Number_of_Shares2 =isnull(Iss_ex7_26,'')          
,@EDD_Business_Estimated_Value1 =isnull(Iss_ex7_25,'')          
,@EDD_Business_Estimated_Value2 =isnull(Iss_ex7_24,'')          
,@EDD_Other_Investment_Estimated1 =isnull(Iss_ex7_23,'')          
,@EDD_Other_Investment_Estimated2 =isnull(Iss_ex7_22,'')          
,@EDD_Credit_Outstanding_Finance1 =isnull(Iss_ex7_21,'')          
,@EDD_Credit_Outstanding_Finance2 =isnull(Iss_ex7_20,'')          
,@EDD_Liabilities_Outstanding_Finance1 =isnull(Iss_ex7_19,'')          
,@EDD_Liabilities_Outstanding_Finance2 =isnull(Iss_ex7_18,'')          
,@EDD_Lead_ID =isnull(Iss_ex7_17,'')          
,@EDD_Customer_Name =isnull(Iss_ex7_15,'')          
,@EDD_Telephone =isnull(Iss_ex7_14,'')          
,@EDD_Married_Status =isnull(Iss_ex7_13,'')          
,@EDD_Created_Date = CONVERT(VARCHAR(10),(DATEADD(MINUTE,240,GETUTCDATE())),105)
,@EDD_Others =isnull(Iss_ex7_11,'')          
,@EDD_Offshore =isnull(Iss_ex7_10,'')          
,@EDD_Staff_ID =isnull(Iss_ex7_9,'')          
,@EDD_Address =isnull(Iss_ex7_7,'')          
,@EDD_Email =isnull(Iss_ex7_6,'')          
,@EDD_New_Cust_Prospect =isnull(Iss_ex7_4,'')          
,@EDD_Relationship_Manager =isnull(Iss_ex7_3,'')          
,@EDD_Married =isnull(Iss_ex7_2,'')          
,@EDD_Nationality =isnull(Iss_ex7_1,'')    
  
FROM                   
  ISS_EX7                   
WHERE                   
  ISS_EX7_ID = @ISSUEID1                
          
select @EDD_Wealth =isnull(HtmlText,'') from ExtendedCustomField where ItemID=@ISSUEID1 and FieldID=13201          
select @EDD_History_Comment =isnull(HtmlText,'') from ExtendedCustomField where ItemID=@ISSUEID1 and FieldID=13139          
           
             
      
select          
@EDD_ADIB_Name2 =isnull(Iss_ex6_56,'')          
,@EDD_ADIB_Type1 =isnull(Iss_ex6_20,'')          
,@EDD_ADIB_Name =isnull(Iss_ex6_28,'')          
,@EDD_Credit_Name_Bank2 =isnull(Iss_ex6_37,'')          
,@EDD_RIM_ID =isnull(Iss_ex6_18,'')          
,@EDD_AGE_Num =isnull(Iss_ex6_14,'')          
,@EDD_Liabilities_Type_Relationship2 =isnull(Iss_ex6_81,'')          
,@EDD_Liabilities_Type_Relationship1 =isnull(Iss_ex6_80,'')          
,@EDD_Liabilities_Name_Bank1 =isnull(Iss_ex6_79,'')          
,@EDD_Credit_Name_Bank1 =isnull(Iss_ex6_76,'')          
,@EDD_Credit_Type_Relationship2 =isnull(Iss_ex6_75,'')          
,@EDD_Liabilities_Name_Bank2 =isnull(Iss_ex6_74,'')          
,@EDD_Credit_Type_Relationship1 =isnull(Iss_ex6_73,'')          
,@EDD_Other_Investment_Description2 =isnull(Iss_ex6_70,'')          
,@EDD_Other_Investment_Description1 =isnull(Iss_ex6_69,'')          
,@EDD_Other_Investment_Type2 =isnull(Iss_ex6_68,'')          
,@EDD_Other_Investment_Type1 =isnull(Iss_ex6_67,'')          
,@EDD_Pledge2 =isnull(Iss_ex6_66,'')          
,@EDD_Pledge =isnull(Iss_ex6_65,'')          
,@EDD_Equity_Country_Name2 =isnull(Iss_ex6_60,'')          
,@EDD_Equity_Country_Name1 =isnull(Iss_ex6_59,'')          
,@EDD_Equity_Company_Name2 =isnull(Iss_ex6_58,'')          
,@EDD_Equity_Company_Name1 =isnull(Iss_ex6_57,'')          
,@EDD_Business_Own_Country_Operation2 =isnull(Iss_ex6_53,'')          
,@EDD_Business_Own_Country_Operation1 =isnull(Iss_ex6_52,'')          
,@EDD_Business_Own_Principal_Activity2 =isnull(Iss_ex6_49,'')          
,@EDD_Business_Own_Principal_Activity1 =isnull(Iss_ex6_48,'')          
,@EDD_Business_Own_Company_Name2 =isnull(Iss_ex6_47,'')          
,@EDD_Business_Own_Company_Name1 =isnull(Iss_ex6_46,'')          
          
,@EDD_Pvt_Company_Name2 =isnull(Iss_ex6_45,'')          
,@EDD_Pvt_Company_Name1 =isnull(Iss_ex6_44,'')          
,@EDD_Pvt_Title2 =isnull(Iss_ex6_39,'')          
,@EDD_Pvt_Title1 =isnull(Iss_ex6_38,'')          
,@EDD_Pub_Title1 =isnull(Iss_ex6_36,'')          
,@EDD_Pub_Title2 =isnull(Iss_ex6_35,'')          
,@EDD_Pub_Company_Name2 =isnull(Iss_ex6_30,'')          
,@EDD_Pub_Company_Name1 =isnull(Iss_ex6_29,'')          
,@EDD_Gov_Company_Name2 =isnull(Iss_ex6_25,'')          
,@EDD_Gov_Title2 =isnull(Iss_ex6_24,'')          
,@EDD_Gov_Company_Name1 =isnull(Iss_ex6_21,'')          
,@EDD_Gov_Title1 =isnull(Iss_ex6_19,'')  ,@EDD_Education =isnull(Iss_ex6_17,'')          
,@EDD_Language_Spoken =isnull(Iss_ex6_16,'')          
,@EDD_Fax =isnull(Iss_ex6_15,'')          
,@EDD_PNNW_signed =isnull(Iss_ex6_13,'')          
,@EDD_PNWS_Attached =isnull(Iss_ex6_12,'')          
,@EDD_Client_Introduced_By =isnull(Iss_ex6_10,'')   
,@EDD_ADIBType2=isnull(Iss_ex6_91,'')  
  
                
FROM                   
  ISS_EX6                   
WHERE                   
  ISS_EX6_ID = @ISSUEID1              
            
 set @sql1 = '  
<table cellspacing="0" style="border-collapse:collapse; margin:auto; width:80%">  
 <tbody>  
  <tr>  
   <td>  
     
   <table cellspacing="0" style="border-collapse:collapse; width:100%">  
    <tbody>  
     <tr>  
      <td colspan="6">  
       
          <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA30AAABOCAYAAACUjH8nAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAP+lSURBVHhe7L0HoG9HVe+/Tr+935ub3ntvJCSEhN6LBJCAIKgoiIqivqfi/9kVQXnYfU+eiKJY6EWkhlADIYUUSkjv5fZ6yu+c
8/9+vmtm//bvd8+9uRcQwWSdM3tm1qxZs2ZNXXv23r+Bwf/54dl4BH5wQa03WIIPN5ienW4qP6A/w+ysQwPSizGld2c8I05vXP4NDw3F8OBQDA4OxvDAYAwODcaQ/OGhgVJEYST+wIAYtsssAWMGZrstQmjWf4IBSdDQEhW13MzMTMya1aApZ8ApBr4zMx3TithXfacVmVZ4ZlpOpc3Ocs2akGdgMGXKUrLkLFuSUF6BrhQJxCvO3KzH2V36Vpd
DgX5GImjXcU8AHTJDDV/KqvwHhXTYcqgNiEhJI2on3BCOthpWu6mtrEvBoHyTWgblTU+8M71oI6+gGp3UFEC4mVnpGTcdHem6I913Op2YlJsR7+5f0tNvEsAUTmLTqwpqm1BL/XaBelagD1Dk3vLcpQ8WsM6bpNK/lU5ZI8Mj9tH78NBwDA0Pu87QDKhvVS6wrvzBWyvgrJPiRDwoGvX6mC39mTrMuF931Mezfye9yDUOCA+qEyCu2bvfw4pr6r
WRAUd/F77iCitD4kzl/0rT1kWFfkyTV0LsMjbmyN8L0qlJUrepq3QD7j+MOBFUPurv6NCFomv19RgcNu3g4EgZ68KJXixMm/yIJUDh7LqYSmlOZ87hj77T2aZ2l4+e1c8H1A6DCg8KN4REoh9SFmYYpJx1ed3au3VKmW0dVCky35TlKFIIMr/ra1yXX4Wcg1xDGFOIccySLkYyEge4zsAiCzGg41bUYDmrYJXPXgLsh6d7CrAuDLAl7mAWwHVab
dKhXSB2uuqqOHN8DNCe4koba1xZGMVntQ7N4qtEaxx6NSDhGeVxfhXmXq8sQ+hEbQU17TgQaj+14+BsJwY0noyb6UhBaltoaN/JKeXTGFNedJL58NEJ/CxpwasY05QChTeQt4TdT/HJ1cqbNd4VCgeBuZuPe6SJSS2uTOCVZzunYVZ603pL6SLhyqUAsuB3cX25BWBqLXZNNUgG85Fz7S1LijZggRUoaRWyHl3ahwbVPoU1tMMV5sL1Qz9NT1zB
uWTZU7l7SqvQQ0MJcwwq9jJAnR/IY607axdXYZeyoC84rRb2+6Gm95RhXJe+kBhquKKIp6MW8Ch82vn7nWj5Y08AdMvMdHikn+A0I3p7c5On+G3Yhd9uaHvkLGnUgDDzFKN/waLFmk5+9T96cz4CP1ig1svp9uEHs0zGdSjQyfXviVjx3I4KhK8dn2V0SIvnkAYAm9YhLa7DWkSJY/SxMRrU4mUeCmc+NkJZRjIsUMrpReVk0ZRtXNfJhnCGOil
5kYOPCsbviGAKA0OL8pQW5BnFbWxMC0+cTMoK/yGXQD64dKGGLYGLYcAXfF2J+gBsmwfAlJTTUi/MzWFX6J+Q5gLTFF3kAlrKFWpAdWcpH9bmh7YZkqGBcVfbyu3Fhsnl0EbkNafip/yOWQFpYDpRPBKVugFJ201Ll0zeU5008DBGphVmwSKNkhKg5ioo8mca5QlUkdrGtT8m5ML33QB4dhe3dv0fGnbXNoNShg0/8cW4GxkZsc+YGJH+0bcNvV
IuAKvc+OwKkDX1LySz6sfTnSnplJsZ3MRAv+lm5bIlIOeKK2GVAb8qe25OwVXG6TVQ0LsA+TLgawVw3TGTUPtjmzaTU9+7m3fb+umF0t8amcVdfJAopZJurV+NbnzFh0bGRJb1HFBbYBSQlnOJmRWZBMlMuSpHRUwovdJ/0S99XIbArIwADG7rY2bCtHWjjw+jITGmjtY1PvwEGBwVYxn0P0s5GZRhYrIGyD/oLYdjvnZ9QbLtgUwtBgd/GBUpl
uvnxsHjYnnQrerTYut8JdyGbv/PWuwtUCTGby2E0ey6YoRJKsLWIPJYLyRme9pQVruF1pxptaONOBnw0/jKPyucb1SIzv1OPMhNGfgA/aFCVl+lqS5Das/BmUkbcwMzMq7Vtmm4T8Xg9KTasyO5pUv5SKpscpjSyTlHHCXBtJRIEvosuqI85gZo3NSQ4kCxcDoDdZVPui6DnsNNUYBwxqE2mBZP/VJMvco5kbwVUjbTtdrOhDMj8nM1dJIvZtD4
vfOdiTKIT0VquMH3AWS6wMblmE7t47HVB0KxL2mPAe9NHhKoo/L20T5UfC5I+RJ66BVsidVAm2Z3/PdE05NGCe73vTCn0Uc+Z+3iKvSXAdQ8NUs/TY2351/j5Gi/jFdNJ7R5MG6r8aZGVJ7k07/yE6MMyyJHuntoyVvxWa/uzZmaDpimpLfztWFXeiBl2ps8FWale+YfZtP5i5douvq1j+1K9Qj84IBarzs5PrzgOz3pA8jHYjYsI9AnfFqYbWT
IH9QCPTLnSZ9yaUFsl1kCxnw3TvqgmsbY0OLdUR6HtUGuG2VOn5CADX/KkZPLf+eTPjZCnPKlEagNMeHhPPmrE/1346QPDmxiq/6tb4WnZKxMaoOFMc5E3+hWQF9JAFOwYt2riu5y46Iz+G3B9/KkDxqMPsaEjUCfrsoIJIxm1bcqF1hX/uDdf8BZJ6mxepJgHU7Ll45nfJNDTkb2NDqWzqu+2id9LsisSpoRNZzgZPq78BV'   
set   
  @sql2 = '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'   
set   
  @sql3 = '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'   
set   
  @sql4 = '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'   
set   
  @sql5 = '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'   
set   
  @sql6 = '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'   
set   
  @sql7 = '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'   
set   
  @sql8 = 'fjn5CdNc+n+lAtwQgcb2QFDb6ijwpI71GcTbnFYTu5VdA9F28iFgQGwRx6q28QmYZbE4yFbAhINfWh/WozRQ69iM1/hBPeQfTaSz1pvQ1QRsvFYQ0lh0aE4FBJm/L3P5+bFcOwy+NP04EZRzV93CUNujHCbOUBDYY6ddSGV/2TVci7SwCaF0f+daDsSVPjfQDOixB589gskaPeP0FAWbJpaaproOMUeLK5fR0gDdyJdauC84flCJ
d5TEfYMhZg/R593PaIDfT1rVZZXvVn5JIn4934OAKj/yNuU7uyKzT1AsGFHHqpwBhy5RjkYs3dBh4/ITEtJyM+aEZbdsVH5A/wFhRO+LYpHHy68c/kQ1JlV+1IuL+UJgaD2TLmrgBYpmqUKGrkJvNEqkgsiwhgRJ7SbJtPR6Qp8zb4PKxxBYQVfKuYxxRulzbYWAuo6/StMcZsDs80M+3gjUnvfHX5BKtjTyc8eg78fxRC5+YFJ4NZ+LWBZG2DO
q3nKQ6oV9mrl2co0Jmj1RM9c/bAKBTmuyvqWPye85xnmnnS35y7sueMVxP93nozUuc1F75+5qFP3QK8OVMntYBh6FJnRgPnBD6K6jUUWk8Tuj5QHMb81CueVrDy3qiiyTiYeY8mWzWO+F3aTt44iQz9XK7mF/KhQzmLz9/bof81Ke0CWPVtGATCEMGDfyyXbLNY3h+8BuPXWpYo4dCZHw3nAa7NCi0+7ocT7dw0ybrlbTOrzj0SMS4akogqQQBb
ojyFAd7DyeKtn4FGT7kF8rAb8AmSUHgFVm8tmoPU4mzNZN2xjdgtSb4phP03BjkVZjJmGGNoGznoz6sHTjmWZyZRGdiXB7rieqltp03f770/4jR930FdO5253q4QzNQvhuwG93uuQwNrH1pELHKKew/EUo9GqmLfMTZW1Rwek3z5MTk7GsiW9DWgSdwAuDkcgFNwM8NEY80FKMPp/AYJ1LaZHmDLIJuPngU3+Esy4tH8yJ3Ttl5JXOmJwewdZuU
SyPy8jgo7wAy0aVhUn7GgImPv6ysFxyXWHi2oZbp9ALwsw5wIJTYzkWYlKoz/LooEi7Ykkk1aJdZwl4ayZ/ECSXNxnbNU8oA0LvZyvNvAha9VwPQJ1TNAgpvDHHFWzwq9OsBqOI4xRfpEd3K+YugWjxYWNLg1qLpk40krW0KdEUvm75kprho1BF2LTp1jdFXIXXb5PS1wi7ZBeDa+CpbQk2tfFrUBZ39UsGCTujSOSebd+s9N0x8FIaTJm+g6Pf
0TeGzP0l2MfNmzWUUxqX+jqmOpTcLnf3BHy2g/6I77eLyN8K460u6cKIx10a3ZZNpfPLpji97sC+0teDGI6nIXGLQFnoijayC6htKpAeXTAQpW030yBXTmoykvrqcDHvWbPKrTtYNI550Of2TL/stNU0Ax2gH6Pnk8P0PC057dI0+M2F82BAciWm5zvCo0JUnfuYlRLyoUtBN9xXjXboedjvIhMTIU5/jJLca8fnbgnw5VDQSyukFh0PrbPYxDN
0CLky1kYzZXQquSU9cM3cIkkypZdy3ISmq3su18PChtYD81KPWk77jeppxzZVQUA3U+a9Cfxyjrz0vtv3++eeh8HOB21rtkBL30jVjQA4eRQoyNGnk20VrSmpoBeYuizpPmXvTspFIKDqGr/7pPfWRUKMdUBtBV7LS5wjiaNsh9RtOhJ2sC3UjTO8if62BsSaizcAm3jROEo7+A0UhdV70OsMJHPRg3Yvso3NoGtmcxqiFD+MGVJZj2gyai4E0/
uUo3++YFmaeCUpefB5pZVwC1hp1KOlkqaQ9ujJkhOvs0Dy1B/NtyecrQKgwKOAYjDxOFXewzKeeZ83Rrv5BZ/3Xm41FkCRVOjz0B4/6bQL3kzqPQmhHJLx2Zn0KAk+F0A/TcGTeqHlIxCeo8mse6GmRIjPO86crSPsxt9Qyqk7FX/HmJxuEW7hosdT/iNH3fQVuyBJ+BOjz38XuOYduH5q/Bt6+NIjY7br8fpehVQ9LXyKE64QMtNPaefYGnLeC
dJTLgng0fBRwWBO5LDwbeVLViBYcPpDBD8bnu2ncOWQ7LL1A59mnTFr8KQ/GjDDmap5MWNB0sZqoKEdbJCFy+k5wusnzbqV/KxCjZKoTE1OTeSqown1HjrIhh78nRaHIaxzJKo+VUhEnk1DyVCAvSVxr38HnvTuHi2v3m7qoAV1u7Vq0QAR77D+FQc2Lj/4w9myES+djo2P2pXmnWWJk6KtLu++7Xl6MtbSwCKmgmi62Bu5uskBhYPMhGHTOgsa
XK70QsuhQr6ZiIK0phUGWFoWvMlS9ZNly6L4Fjd5E37CcA0hrp8OFcnrxe+AAf23I+/We5bPUWoPmW9m49w7ko4X0Sz4Ig4+R4a+w2QjMO+uutfTAl+p8D1k8atVSD0Un9BlQWZJAaZ1czH0C6M2BDAa5Gek9ZCCyzcg7wPicX2kjC0/nL1frL3k2xdohj9jaODIacdIpbMNTgaqXpj0a+fqg5HM9KqnAbZ6B9MwnI1WzVWKwLk8yZ90Kq8Kv2x
KFmaDmhBbwBkxY86RPq7xu6ybOPyY/kIafO7gNQdpLTnNXtltpP9F7bMj5hlKRpZHBbediiFSs5eGkNk8AMfTU+horPAY6pDHED3zzY/MYh/7IBv1fad7sIb0Y1Larp2bp40oNlYVHWHGuWwFCns/Mq0AK6HwZUH6PuSynaqjSOaXLsgfacwfQHwfoi1WObwceKh9zjTe0lrQXLLbQpCQfakd91QaKd2uYQLzmSej2Yd47Z0Ys0a5c8rix41hbV
oxwP7Jcy6F00UGDo9EM3TxuU99IIJZ46N3q+ncd1ZbOrjTqrR5lOkObp+lLrMolOQemNSNZroxX3uWiPEVGAzhhkp3X1toXoDBVoc3emmEbH8nZkNgsM8NVX47I7+qoW3ZvGOjWQ/29yYG8+JnWn4d0unLOvVkPMlRV2dd4q+D+VHh1lNHvFJNLeVL/pGR6csswxaIDvvAKxnL'   
set   
  @sql9 = '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'   
set   
  @sql10 = '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'   
set   
  @sql11 = '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'   
set   
  @sql12 = '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'   
set   
  @sql13 = 'uiQrUMkqubvXbUMQGZqRbaKu82QZ7CMsl9yy3FlDDGRO0wl4fSoSx1h5vhLKMpCdM3ja06fPRx4QunlzqqSWKl0G1lWi8ZuOIlwqlfpJHpQXvsIUofDIx9VoK8A27FmGVw1ddkgt9h3avfTX1ByQ96c7R5PH8SkRrniZ7F/fI450/gEBnqY39cIU6KOjPu9NFQ9MDZJgLv3t4+OobPe2broDeieg/AVRAM7kBpX12aaM6Y4vAp1
dFHi/28tlws/RzGoLxNypjkC+E+uRKE2uly82fAuSXw2NTym2VWibyzKoQ7qhlsZpw2VHItWVNNjltY/hNadPiH4qXw+cU0OBdb5YFJKsSAZ+hXaDKU8HlkbdGWpC0ZamijnjFzQU+wUEQAT71wCVGOsagKIX4BFV+5crVj3tqI5mnrMNaeIoBLt37y6AYIN79QA8vIPl5Sc2CChTOunibJjKcSYT0ppLHPyUHzr8T6DC/yTjhcpxfeb0oCrx4W
x8KlHplevHBJWkDmUfpRS9tqLj2OOifS9Lo62XajtHSld5beiXmKQdUWYfMkQ7jjpt+NsmUWFOgxHfp4CmXjRP08gdthBOXU5twOogh0BETb9HVNqSxfbdEZlbK54I+EU6ypW5TRuVSeoYHprShp31J18ae0x828LwfmD8uzial5qMdCh+xrfxcHvqkfKpgL+PoyvWnbqQDzqB2J+4LmWoiZFm/hrfBxKVtCv8KCvbS7gp7Pe+16OCH3KVXeyPK
XfrUQylTSR4Hysf0QL0qwIlxAJqfBql8AMdqRwUHb/lT5Sax2xXH+PO7opRGezNGNS6RS2n8mLt/0J0+4nwYhWko5o9Mo0vxJt1h4ZgTKJq6uro5v6U0tW55cc/CiMPoE+SGNW90k8bESv/wBpaxXPqSf8RefBnfbWNQA13F5Uki5dLfuBkBD+vP/BHKUouOGmQtLJP5E5CnPsMfc0ADzj83QKtMJVZAeWkL0igxodCUtYpripZy1JgTAJMTKbh
ahqOVqBcKh/QZe+K7Sx8VH0tmfildaoMYuJTGnPLf2IYLETwQpNe7UCqnoWnClOOAABycM2MjVztfgZ551H3MZL60TyG70Cqnna5gmzuqr7x9ZaAJmtemHC55pB/GGXTksW+8/0vvBpP5GpmLfqzDQpu6AlM4lrYsOQzgYdFmk/HC0JA0bajlugXpu45LdtVtwSM/2fCDB3SWdpM/HKEZTHvQRUPTA2SYC797ePjqGz3tm66AnJj2Pd++AItwFa
1n+lO5/giKoG7+WFS6m3wcm6DMn/d7WczlK5G8/I2OjcS8keEY0gZ4SJsac1Qeb/xF4/ychIM3aGJ1eUUoQbPp958RjgPE7cqE7KlfmxIeAZ2amoyJSX66oPVRGAGbapaHzLl3kGVkvXtACYlTyaRLtofs58gCTbselk86KSg8nPENP+kJ/sYnDh07RXjrfJB3L2V8j4467scSoSmM84TDQfMg4jKEqz/BkSWwcVWEeNngZT9QPZ0Rn5M/Gdgys
md4/1LOX31TPjvYGxRWFm84HU4/+wIXQSFu66RCxVVdVABbqZOmlShwrBK43yIT5ZYaQlBk6d4IqFsRILfJAPwLJTHjAONcNjz112w4lE+6V8fXfn44Bv3hENpBOLULmw14TUnn/D6dCig8wCosuagvYpGSusvyeaoD4D0wPhJTXf5khDb6POrHTY9p1YUTHjbqaq/kBU/lQx/wV5waZrlyZdNMv7IcAsYUmetfjSeuC8kJXr0wV5uSMZ/4mRty
POwe2hwrbepJUpfyMJowtnNjV+pnB+R4Rc/oNnngZPTwqodCWf/UTm1X+HsiAIqI07yqoc4ECxt6PtmFdZbmL8Sam/IpfXKAJ5gwCssNGvsy+uQGR/J9Qp8O2lAkfSAmWnUCPH+JxuUZT3p1pZ5uqC5A0rvJ7c3jDLRJcYx7vjXADQV/QwGjkDT6GobhLE9I8f0DSeObQfQ5OfUhng4wD7grPUsVXn0mH/cs/dFKyzahPxvAZ0g8VN9ymphQ6oY
GnLdiuWSFPW8ZcizXsu2SkIILDo82Y6wr6H7QhVpqG2iBLDtdk8N5U9Jkk2UT5sS/Uw0sXzJX5ii4FrhckElcyRMUySRdGzyxxDpWMxTaBvriVa/GKW0Xo0/Rdo62fgjWlgWaD14JXPPaZ8s4yHC2SplmHC7/TdlcXaayOJ/wrWKNT1razVeF1f+4QWEAIxx9HVphal+BkovrTd/yeCi08rOuFef/DBdc7VGMtwWPnPT94IEnnRJ+uEJ3cujVRX
twzw1keCiaXnj46hs97ZuuPJt9D2Du9lDZFK+JradP+C8X1mYjJzpC9ZGd3EgmLkOZwGOfPJrIB0r4OignU86HYzH0LUDxl9M+qAFPsTlru0yX67KTrydg/wlIcjzzVajvA/JBmCl+HmJaxgnTN5uVwhdoNos4NjUCcI57Y26UoS4ioMxDMmOQIbpLbvHdBUq+XaG9hBaaspGpLeE764CFQn+tHAS9eGlLJH1i9Pn0T86/zYjOJVN1sKiLrxByk
l5xdNrggGbTlkVUDSMbcR5NJ4zx53ct/RuB2hB2aAXJD53lgl7cldW+MFwynPgulIjT8XW1zsVTQrMZ9keHBKbMYA9kH0g+bBKHHaIseIEjE1TdzN0cWWQaqI51qZw3XReUDr7IZHNGweSN8UGiNvU+iS2+jMCO2mZa4yJ1LS3g6UK+LLq14RUN0vrjJEUurnXMGaPBwoe9qjIxP4amJmJwit8PlEHD+4C0p5wf8aNN5Kd5Cw4pBmKk9awWId9U
8d+0qApYrCamKJRC2mMkIAcp2a+aOhbZ0xjdFWr6bqGVXmmHXV4/IG8F5LQw5dpXhqPoIg0eALraN9i0V6MWcDsZwLHZhEHWzawKe/qDDWjF0WuKq1FR2scg2RkZOKvdE6CoOd3T2KKs2RGF/TIuxqEMxkEeKR2NKdHw8xN8wZwvkWIs2gDkXVT/1AGlwTRrQhu1tVL7VhqPPgM'   
set   
  @sql14 = '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'   
set   
  @sql15 = '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
+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'   
set   
  @sql16 = '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'   
set   
  @sql17 = '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'   
set   
  @sql18 = '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'   
set   
  @sql19 = 'nnLF/vOys/eNHjl2sMcWjpqPaFIzF/HkL4vBjj4hff+E58c6fuiD+6UcfFb9x4SFx7DweidQc4U0rm1Dvwb3R9KOSPKIkfO056aMbOsZA7Ng+4XfSQGVXSYql++0fr3jKGfHnr7gg3v5jj44/es7xcfEh87z5KXaA3EAcdfxR8fITl8X8GIuTTzsxfu8lj4m/+7Hz4o3PODLO6R88LfDpCG5oUTzm3GPiJy48Ii5cCX5+PPrso+
LHpPtXnH9YPH3tTExNbIvJHdvjkMPWxAsPn9FGZ3scedR+8evPPib+QmP6ty9aHWcvzM131iw1MW/pEq0Xh8efvOCY+OsfOjz+xznL42kXHh3vfunRcfFKTgGH5EbUy4djQrqe1Lo1PTQvZkYWxPJTjoinaX6f3nh/vPmKmdiycGnMLlwcM/MWxsyoaPzxEz7TrXVpRjrO55EMrhfGwdDCOOOc4+JFF54Ql1x4fDzpYLWVc1QXsd/hR8UrX/DYe
NMrnxBvfNmj4zWaGw4dow1oSd86iENOPC6ef/JybTDnxTFnnBq/9LLHxRtfeWH86jOPiVM1cLLFVO9la+MZ5+8fLCED85bHBY85IV7w2BPi4tNWNmva/DWHxA8/57Hxu698UvzBy86Ln1T/PH5J/ySR5fMxnXz/qjzyKsdHZNgMj8iAy7vtnRjjzrzc0MxOuR0xNL1dxt+2GJrcGp37H4hN2vxwmoEb0+ZxsQxFtNXRhmh4Shvnzk6NxSVxsgbG
utsejOsneXiOslTuzPb4/G0aY2qbE9cycqS56am4axvvcvHlUYy5eTHJe7lIPjMY29WnxkeXxMTYktg0NRK3aIxtXrw8ti5ZEdvlpheOiZLZbX5MLFgWk/OWxOTIopgYWhDj4jUxNBQTg4NyA+oXcpJ2Un2dd7imZlWmDMiYZWFlThzzu2XjQ6JRN5iUxTgpdWKI8mzETLni0J2dWzX1ycyhStrniuZraubktkD2BHE1dkBr8oDCMnnt281OOT6
k9Oq004xly+6PZeOr4/ZxlUB7jm6MlSOr46NXPz0+eO+hcd1dR8ctIh0clKQa1NOz0sfADm2AT44P33lyfO7+1ZZi+WEfjUtW7hfv/Mzz4kN3HRL3TMrwka42j+eNqNGl98faqSPjn77w5Lj0gUPjq+tWSVeqychmlbcqPn7lU+PDynfD7UfFrbzLSZcbeDCecebnY/Gtz4s3Xndc3LJ1aYyMbYutGw4oT4Z04vCVD0Rs2j9uRQmC/jVwVro4bN
n6mNq8X9ylJNJHVtwXB86sjts2Mfd1YsnYhOo3Gzu2HRBf/vp58elNFL41HnfmZ+LYjY+N3//co+Ir969QO6uFJ+fH1in6t3oXTpOpT66nJxXnhCndsPo9Hxw64OjL4uIFR8Wffexx8bF71sYt9x8dX90gg1J9d3jwvjh+ecRtD0qHjJnOVGy8d2HMjiyMu9aPxHzxmT+zMZ5x1mVxwobz47c/dUpcccf8GOf0anIstuzcGvNm74u1Iyvi3z93X
nzwxiXxtW/sHzd3ZmJ0alOM7twQI9t4zHBr7Lz38PjA9fvHZTdJt1vutRvecl8MbSYsf9M9MbvhrogNd8aAXKzv+rM97q506xRed0fMPHhHTD94u8bxbTF1720xKTdx763yu27inlv26MbvuVnupsZN3N0NT953u9ytMXXfLTF1v3zcA+Kp8ihn/B6Fi59O/O7Fqez7bouO5JuR4Ta78d7obLg7JhVOd5fdhFxHxl1n070xu0V9adu6mN36oIxa
GW0y2Ca3bvYJLu8Fx8R4DHYmbaRNb98mg01z2aTaW+0/qvYcUV8anlVfqs5fYxU9P1Ujf1BjcGggxyVh8PysxzArjGh96irXP9t+n4E2MmccFW953rHxFxefEZddfGj88GGL45wjVsWPXnBM/MePHxvPXlhIK7DZfOZZ8ekfEu3hi+PRR62Jn3zCiXHZyw6PRzcGyECcctFp8eVLjolfO3NNPO3wZfHE49bGzzzx+Pj0q0+OV63uLqAxvCR+7Kl
Hx9uedWy8/cfPiLc/dk089oAl8TjR//IzT4tLn70q2uRsqp/65DPiaz91UvzRY7QIHpqPr/3ERcfFB191crxGg9Bki1bEG378nPjUcw+LHz9uaZy6dmk88/RD4i0vOTuufOH+cTzzRQUN0p/84bPjiy84Ml598so4d/8l8dSzjox3PnlVLC4k3wnMbHog3uVnIxfG444cc6dYJUPojU8/Kn7uyL7NtjYnF5xzVPyRjI2n1E2V6vwUbdCu+fHj4t
fPXBXnrV0Ujz4W/WgSec2J8YoeBX0bMDse/3b95tCQiBOPWB6HaCE8+qTD44+eeWz88TOOjTedvzK0b94tDGux+PWni1b0f/T0Q+IJjVU9HOc/4cy4/MeOi186bXkcvXRhnHfSIfEHMtR/6YCp+Ox1G+KWMtkDa485Oj7182fHXz/+wHiW2vXkQ1fHjz72uHjPzz46/vGshVqCE+YdfGD84bNOij97zsnxyZ88Of7nKcvjjINXxLNl4P+pDIe/O
L5Xp/uL7yd/QZvpZxwWLz1uWZy6//J41tlHxF/86Lnxr+fObwbp3pa/JxhYqg39Udo4rNscX2neJ9kz7I2x14bbrr03vih7cmS/lfG4PVlIZeM9u+m+eM/t9L9FcdGR83ompY13b4lvaaPzhNP3j4P32I2G4lHa4L7hojVxkBiMrD0wfueZJ8QfPH5tHF4ZjiyJ17zsgvj0JcfGT56wNA5Te59z8uHx+y85P77w4oPjuGbMDcShJxwVf/DM4+M1
5x0fH/qp0+J/nLIyHn3EylitjeLuTsKpSwU2SdVQTv0NaKOR6RNTbGIH4rATjo4/eNYJ8ZrzT4gPvvr0+OVTV8W5KmOVjLntqw6I//Hsk+IPnn2yaI6Mi9RnO9qw3hxL44LjD9M8OBXbtm+Prdu2xfpNG2P91Fg8//RlcfaKibjhvqkYWHNgvPVHNb+dtyaeeuSSOPsw9b8zD1Z'   
set   
  @sql20 = 'dT463nD7PGz8JprGxIn5KRgvv0g4uWBo/8oTD4n/K/dJZS9K4RfTZsbjgcSfHB15yVPz0aSviLI3vs447MH76WWfEx9VvX37I0pg/f1GMjS2I4WHxHuZGkfrYtDZ62rjwLkHTg6yjbHc+HnTRKWtilbY7l151bzxYiIb2Pz7+8bXnxW8+4Yh45rGr45yjD4jnna/59KefGH/96MXu58llKE4755T4jRedEb97yUXxr5ccH8/S/H
DaUQfExRedHm9/9ZnxxP71oQJtonnr0U9/dPyfi0+Jnzh8Ou7aqK3u4IJ4+pNOiV9/zmlyp8Yrjhr1RpnTl1POOil+/QUnx/963qPjHc8/Mp568MI4+bBV8Zxzj4q/esmhcaEMcx43nNXCvfSAA+KtrzghXi+D/cyVo3HoQcvjRy7SvHnOgth01/r48mbKlxj0fz82lw4jojMwFqerzRZpE3zHjZviy9L/tIzuWel4YMFiv3s2vHBJjMxbFMNji
2JwZL6M19p5BxsDoTO0LB73pLPi55/7qHjtc8+OFx7D3a5ipMm4PfeZT41/eM158YpzDo5TDlgeJ6vPv+SHnhB/97oL45n7MWig1Jx7zpnxC5ecE798yZPiry45MZ6gPnriUYfE0x5/Trz5NefG+Yvc22Nw1aHxsmceFUfRlxatjYtV5mt+6Oz46cfu75sqowedEm967eMVPyLOOWxlnKT+/+LnXhi/8cQ12tD0QnLsTr6YIdVY9Rc2tREakj/M
Y1c2AKfEQ5th3CyPa8lpIzRPbkxG3djkzpinsTsm4+PRmjuHlO/rN97uE4eh7ZvimFXz/eGlO++5X9bYFm1qt8uNx7zOeGzcnA/L7r90VHw1jcjAzpMy1dMnYwOx5rBlcZQ6yc57tsVV0zIE1Uun1L+2D47FNhlz27SGbxtdHNvnrY5Tj1qivNNxwz2d2LxwuQy/lTG5SG7J6pharNGwcFWMg58vAwg3tjgmRhfJsJRxOTSm/pE3CjCtvMWb5aM
eMr0GuJHQde5bkpEDvAo1aO2qvji/nyTZ/dMdMr4wtv312uLbNaYfYfoFcRymYXXaaGrTibFnp/ghyx7UJndN3G5DW4bH0nvjgNlVcftWtCYDdMG62G9wadxd4gMD6+LYFTvijvUHxYTnTVwnjtvv9pg/cHe88Elvir/5od+Jv3vil6Jz4/PjH+5hNpiOA5ati+GNR8XV4znZ1zVrSEbnATMr4/bNiR9cuCH2G6K8oRhc8rU4f+Xy+OxNh+QTQZ
S9ciLuXH+ASiS+JY5cviPukxHIu6n966DjAxtl9E3GvRvWxLjTZ+KAFQ/GPNWZ07qIhXHpFc+IT01fH7/xQ/83Xn/yXXkDZOjuOG0/bcRXfS7e+II/j7e/7C3xe1qA/v2yi9R/0uzG3OZDHPg4+ox/RkEudT8VJx94X+y86/i4XPV2LokwPa05V4bZ7Nj9cfi8ZfGtB7Tf0BzGlDu8/ME4eHB53LaRAwjlGLorTl8r42D1F+MtL/7r+OdX/EW8+
YTB+OAnHxNXy/hcIP0dPLMs7togQ09z2/z5G+KAocVx90aMUR5vvD9OXLUzbrt3uaa+cY01jZlpjTW7HTFf/vyOfI3BBY6P2y2YwVea0xUmn/LPn1Icp/hCjV3cAtLhPbVDbrvodjRubLI3PqebxIlObmxim/PgRnGK449Jxnm4IvsCZJTxu0BGUuPjNK8sVO+gDswRI+JNfvwR4UZUL9yoaKsbmt0pp92r/MEZOfW2Ya15PrlVTMNPeF3UZp0J
jLVZv16R7/+pnyltRm062ymvNhXH+6D5e3/Q+XaM1lv1DCX76RF+689rDDfPcuQST67/RTC85qB4/8+eE1/7ua77+EVazEp6hYF5S+OHVm+Jn/s/n481b8RdGb9xqyb8FfvF607rbooNg8Oxdnp9/LRoV/+haP/4mviju6ZjyUEHx/86dYw6C2bj+q/eE//vym/FM/7ss7Hoty6LRW/4cvzY1TtjdvHK+A1tgnr3qgOx5ODVccKdN8a5b/pcHPi
mz8ZBf3NrXDY+EEeecki8tCEeiBPOOzH+8fylsXjjA/Hat34hVr3h83HQ7382Dvubr8X/+NDN8bd8b0Ubi599wYnxiwdGfPnz18eJb/hsHCy+q95ybfyBNr9HnHRMvO2CRUUPw/HEJ58Uf3LCvNhx151xieRdo3qt/cMr4ue+PuGp9juG2an4xjo+kjIQBy2frxL3BQbiuHNPiH84f0mE5Hvhn3wu1qqN9v/9y+M5l22K7cvXxJ/IWD+1bcR+G7
Bx3Y64V312cMl8beJn48uXXRPn//1tcc1eKGDyrtviOX91dbzlHibKLowccnj8paySZVsfiFf/6WfihLd8Lo5QG/zDg6LjlEN6YekChlYfEm9/0WFxdmyOt/zj5+OA3/1MHP67l8YJb78lPjc5P56vDfovtU+plP/RJy6ML33gS3HY715md8HHN8Tmwfnx4gv2j8ML6dCaQ+MfxPe8sZ3xrg9cEUf8zqfjsD+4VO375XjFv38jXi/LDKn3ufzdw
JqjV8XZ6lg7N+xo7l72wOAiGUaPiete95i4trhrfuKoeNQ+tB/vIdyIZaRN/RF7cxqtDdg3H5xw/ztwpQyHggamN2yP27V4zj9k9e438Iap+MAHvhAX/vMdcZP6xNTt34qn/9nn4sK/v6X0kaE4/0mnaWGdFw9842tx0Rs+FWe85bI4+g+/GL91y3QcetIJ8RePyVPkLgzEY85aG5suuzyO+u2Px4G/9+n4sS9ne/RCMWIcmhuGVhwYL5axPagF
4bq7ebE6T1pcxtkHqIwvxDG/9dE49PcujR+/YocW8hvjBX9+efx56bNs3GZie7z7K/fHem0on3Tm2liqDdqU+mhHbvnx+8Vj58/Gt676Vnxo/aZ48Oab4+1X3hO/809fibP/8Atx6h99OZ7z4QfiNs0qF15wUDx+gbYRnCRozL74/94an5OOpzffH7/w11+NJ/7lV+Np73kw7pY'   
set   
  @sql21 = '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'   
set   
  @sql22 = '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'   
set   
  @sql23 = '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'   
set   
  @sql24 = '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'   
set   
  @sql25 = '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'   
set   
  @sql26 = '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'   
set   
  @sql27 = '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'   
set   
  @sql28 = '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'   
set   
  @sql29 = '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'   
set   
  @sql30 = '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'   
set   
  @sql31 = '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'   
set   
  @sql32 = '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'   
set   
  @sql33 = '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'   
set   
  @sql34 = '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'   
set   
  @sql35 = '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'   
set   
  @sql36 = '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'   
set   
  @sql37 = 'Of0a+dn7N0LedP42qpBkyStcNATcUaZhyrIRdRHPk224w0JlBpP6z+kvg8zKES3nWrmD0GXiO+tY4E98hjU7h6HaBOQtZnfRZhTAUDxgClVOWx5TveV6W1Iwwx5HJR4Yg8zTOIqcdQ9uV1phjOIxFjcGxUT2LSDo2Jv17h8av8UTgj55ztHBIM3ApGG4lRH0UwMdDgHL88rzxYDUUcRSOggeCMpxYGQYmLh6lFzNjZUoNLgPlF/
miP15XGc+rolaOvsj6WObfaDRG+G/pUaWaN+p3jQfhai20sOEEXAcLM9OwImPP8iKEuJzL+BJqhGv8WD0C44jtUq0W9UoMGNBwKk+0eDDgrIxA459jqxKsbIQ0ka5jWVG+12OBsnAcFPU2ct1mnbUNjfh/NMRm0pzq6BEAAAAASUVORK5CYII=" alt="header" style="width:100% ;height:100%;margin-bottom:10px">  
  </td>  
     </tr>  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Date </span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Existing</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Rim #</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">IBAN:</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:157px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">New Customer/Prospect : </span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Client Introduced by : </span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:27px; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Created_Date+'</span></span></span></td>  
      '  
       set @sql38 = '<td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:128px">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:121px">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:157px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_New_Cust_Prospect+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:157px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Client_Introduced_By+' '+@EDD_RIM_ID+' '+@EDD_Staff_ID+' '+@EDD_Offshore+' '+@EDD_Others+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      '  
      set @sql39 ='<td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">1. Personal Information</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
  
     set @sql40 ='<tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Customer full Name</span></strong></span></span></td>  
      <td colspan="5" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Customer_Name+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Nationality</span></strong></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Nationality+'</span></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Age</span></strong></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px">'+@EDD_AGE_Num+'</span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; text-align:center; vertical-align:middle; white-space:normal; width:157px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Married</span></strong></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Married_Status+'</span></span></span></td>  
     </tr>  
     <tr>'  
     set @sql41='  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:37px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Net Worth (AED)</span></strong></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black">'+@EDD_Net_Worth+'</span></span></td>  
      <td colspan="3" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:421px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">PNWS signed by client ? Or ADIB Internal estimate Internal ? PNWS Attached &nbsp; &nbsp; &nbsp;</span></strong><span style="font-family:Calibri,sans-serif"></span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">Signed : '+@EDD_PNNW_signed+'<br />  
      Attached : '+@EDD_PNWS_Attached+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td rowspan="2" style="background-color:#d9d9d9; border-bottom:.7px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:54px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Primary contact<br />  
      Telephone # (s)</span></strong></span></span></td>  
      <td rowspan="2" style="border-bottom:0.7px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Telephone+'</span></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Fax # (s)</span></strong></span></span></td>  
      <td colspan="3" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Fax+'</span></span></span></td>  
     </tr>'  
       
     set @sql42='<tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">E-mail</span></strong></span></span></td>  
      <td colspan="3" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Email+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Address</span></strong></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Address+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>'  
     set @sql43='  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Education</span></strong></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Education+'</span></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Language Spoken</span></strong></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Language_Spoken+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:27px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Relationship Manager</span></strong></span></span></td>  
      <td colspan="5" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Relationship_Manager+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql44='  
     <tr>  
      <td colspan="3" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">2. Government Public Service Positions, Current Previous</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql45='  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:32px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Title</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Company/Department name</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif"># Years of Service</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Size of the company (Sales, net income or balance sheet for the most recent years</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Title1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Company_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Years_Of_Service_1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Size_Of_Company1+'</span></span></span></td>  
     </tr>  
     '  
     set @sql46='<tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Title2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Company_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Years_Of_Service_2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Gov_Size_Of_Company2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql47='  
     <tr>  
      <td colspan="3" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">3. Board memberships in publicly listed companies</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql48='  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:32px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Title</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Company/Department name</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif"># Years of Service</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Size of the company (Sales, net income or balance sheet for the most recent years</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Title1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Company_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Years_Of_Service_1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Size_Of_Company1+'</span></span></span></td>  
     </tr>'  
     set @sql49='  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Title2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Company_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Years_Of_Service_2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pub_Size_Of_Company2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql50='  
     <tr>  
      <td colspan="3" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">4. Board memberships in privately listed companies</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql51='  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:32px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Title</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Company/Department name</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif"># Years of Service</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Size of the company (Sales, net income or balance sheet for the most recent years</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Title1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Company_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Years_Of_Service_1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Years_Of_Service_1+'</span></span></span></td>  
     </tr>'  
     set @sql52='  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; text-align:left; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Title2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:249px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Company_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Years_Of_Service_2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Pvt_Years_Of_Service_2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql53='  
     <tr>  
      <td colspan="5" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">5. Source of Wealth: Explain customer''s history how he built his business wealth, inheritance, start-ups, etc.</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql54='  
     <tr>  
      <td valign=top colspan="6" rowspan="3" style="border-color:black; border-style:solid; border-width:1px; height:57px; vertical-align:top; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif"><span style="font-size:15px">'+@EDD_Wealth+'</span></span></span></span></td>  
     </tr>  
     <tr>  
     </tr>  
     <tr>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql55='  
  
     <tr>  
      <td colspan="6" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">6. History of relationship with ADIB (when relationship started, any misunderstanding with the bank, and how the relationship evolved).</span></span></strong></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql56='  
     <tr>  
      <td valign=top colspan="6" rowspan="3" style="border-color:black; border-style:solid; border-width:1px; height:57px; vertical-align:Top; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_History_Comment+'</span></span></span></td>  
     </tr>  
     <tr>  
     </tr>  
     <tr>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql57='  
     <tr>  
      <td colspan="5" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">7. Businesses Owned by the Customer: (Please provide a listing of companies, their principal activity location).</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql58='  
     <tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:33px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Company Name</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Principal Activity</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">% ownership</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Country of Operation</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Estimated Net Value to Owner (AED)</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:21px; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Company_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Principal_Activity1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Percent1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Country_Operation1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Estimated_Net1+'</span></span></span></td>  
     </tr>'  
     set @sql59='  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:21px; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Company_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Principal_Activity2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Percent2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Own_Country_Operation2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:0.7px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="font-family:Calibri,sans-serif"><span style="color:black">'+@EDD_Business_Estimated_Net2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql60='<tr>  
      <td colspan="2" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">8. Equity Ownership (shares) in listed companies.</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql61='<tr>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; height:31px; text-align:center; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Company</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Country</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Number of Shares</span></strong></span></span></td>  
      <td style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Pledged ?</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Estimated value (AED)</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Company_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Country_Name1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Number_of_Shares1+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Pledge+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Business_Estimated_Value1+'</span></span></span></td>  
     </tr>'  
     set @sql62='<tr>  
      <td style="border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black; border-top:none; height:19px; vertical-align:middle; white-space:normal; width:159px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Company_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:128px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Country_Name2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:121px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Equity_Number_of_Shares2+'</span></span></span></td>  
      <td style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:none; vertical-align:middle; white-space:normal; width:143px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Pledge2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Business_Estimated_Value2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql63='<tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">9. Other Investment</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql64='  
     <tr>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:.9px solid black; border-top:1px solid black; height:28px; text-align:center; vertical-align:middle; white-space:normal; width:298px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Type</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Description/Location</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Estimated value (AED)</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Type1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Description1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Estimated1+'</span></span></span></td>  
     </tr>'  
     set @sql65='  
     <tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Type2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Description2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Other_Investment_Estimated2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql66='  
     <tr>  
      <td colspan="4" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">10. Credit Banking Relationships in UAE vs Offshore (on best efforts basis):</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql67='<tr>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:.7px solid black; border-top:1px solid black; height:28px; text-align:center; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Name of Bank</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Type of Relationship</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Outstanding Financing (AED)</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Name_Bank1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Type_Relationship1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Outstanding_Finance1+'</span></span></span></td>  
     </tr>'  
     set @sql68='<tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Name_Bank2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Type_Relationship2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Credit_Outstanding_Finance2+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql69='<tr>  
      <td colspan="4" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">11. Liabilities Banking Relationships in UAE vs Offshore (on best efforts basis)</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql70='<tr>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:.7px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Name of Bank</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Type of Relationship</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Balances (AED)</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Name_Bank1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Type_Relationship1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Outstanding_Finance1+'</span></span></span></td>  
     </tr>'  
     set @sql71='<tr>  
      <td colspan="2" style="border-color:black; border-style:solid; border-width:1px; height:19px; vertical-align:middle; white-space:normal; width:287px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Name_Bank1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:middle; white-space:normal; width:264px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Type_Relationship1+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_Liabilities_Outstanding_Finance1+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:middle; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql72='<tr>  
      <td colspan="5" style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:13px"><strong><span style="color:black"><span style="font-family:Calibri,sans-serif">12. ADIB Accs (All family related party accounts where client is a signatory or has a power of attorney):</span></span></strong></span></td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:4px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql73='<tr>  
      <td colspan="4" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:1px solid black; border-right:.7px solid black; border-top:1px solid black; height:28px; text-align:center; vertical-align:middle; white-space:normal; width:551px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Name</span></strong></span></span></td>  
      <td colspan="2" style="background-color:#d9d9d9; border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; text-align:center; vertical-align:middle; white-space:normal; width:300px"><span style="font-size:15px"><span style="color:black"><strong><span style="font-family:Calibri,sans-serif">Type</span></strong></span></span></td>  
     </tr>  
     <tr>  
      <td colspan="4" style="border-color:black; border-style:solid; border-width:1px 0.7px 1px 1px; height:19px; vertical-align:middle; white-space:normal; width:551px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_ADIB_Name+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_ADIB_Type1+'</span></span></span></td>  
     </tr>  
     <tr>  
      <td colspan="4" style="border-color:black; border-style:solid; border-width:1px 0.7px 1px 1px; height:19px; vertical-align:middle; white-space:normal; width:551px"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_ADIB_Name2+'</span></span></span></td>  
      <td colspan="2" style="border-bottom:1px solid black; border-left:none; border-right:1px solid black; border-top:1px solid black; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><span style="color:black"><span style="font-family:Calibri,sans-serif">'+@EDD_ADIBType2+'</span></span></span></td>  
     </tr>'  
     set @sql74='<tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
     <tr>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="border-bottom:none; border-left:none; border-right:none; border-top:none; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>'  
     set @sql75='<tr>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><strong><u><span style="color:black"><span style="font-family:Calibri,sans-serif">Prepared By</span></span></u></strong></span></td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:15px"><strong><u><span style="color:black"><span style="font-family:Calibri,sans-serif">Reviewed By</span></span></u></strong></span></td>  
     </tr>  
     <tr>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap"><span style="font-size:10.0pt"><span style="font-family:&quot;Trebuchet MS&quot;,sans-serif"><strong><span style="font-size:15px">Private Banking O &amp; C RM&nbsp;</span></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap"><strong><span style="font-size:15px"><span style="font-family:&quot;Trebuchet MS&quot;,sans-serif">Private Banking O &amp; C Team Head</span></span></strong></td>  
     </tr>'  
     set @sql76='<tr>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
      <td style="height:19px; vertical-align:bottom; white-space:nowrap">&nbsp;</td>  
     </tr>  
    </tbody>  
   </table>  
   </td>  
  </tr>  
 </tbody>  
</table>'          
SET @SQL = @sql1 + @sql2+ @sql3 + @sql4 + @sql5 + @sql6 + @sql7 + @sql8 + @sql9 + @sql10   
+ @sql11 +@sql12 + @sql13 +@sql14 + @sql15 + @sql16+ @sql17 + @sql18 + @sql19   
+ @sql20 + @sql21 + @sql22 + @sql23 + @sql24 + @sql25 +@sql26 + @sql27 + @sql28   
+ @sql29 +@sql30 + @sql31 + @sql32 + @sql33 + @sql34 + @sql35 + @sql36 + @sql37   
+ @sql38+ @sql39 + @sql40 + @sql41 + @sql42 + @sql43 + @sql44+ @sql45+ @sql46           
+ @sql47 + @sql48 + @sql49 + @sql50 + @sql51 + @sql52 + @sql53 + @sql54 + @sql55 +           
+ @sql56 + @sql57 + @sql58 + @sql59 --+ @sql60 + @sql61 + @sql62 + @sql63 + @sql64           
--+ @sql65 + @sql66 + @sql67           
          
SET @sql_1 = @sql60 + @sql61 + @sql62 + @sql63 + @sql64 + @sql65 + @sql66 + @sql67+@sql68+@sql69+@sql70+@sql71+@sql72+@sql73+@sql74+@sql75+@sql76           
          
         
--select len(@sql_1)          
--select len(@SQL + @sql_1)          
          
--SELECT @SQL1 AS OUTPUT     
--select len(@sql1)   
--SELECT @sql_1 AS OUTPUT1           
          
UPDATE EXTENDEDCUSTOMFIELD                   
SET HTMLTEXT = (@SQL+@sql_1)          
WHERE OWNERID = @OWNERID1                   
  AND FIELDID = 13238                   
  AND ITEMID = @LEADID1;              
          
      
UPDATE Lea_Ex5        
SET Lea_ex5_76 = @ISSUEID1        
WHERE OWNERID = @OWNERID1 AND Lea_Ex5_ID = @LEADID1        
      
END  

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RTN_check_for_App_form]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[RTN_check_for_App_form]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[RTN_check_for_App_form](@CaseId INT)                  
AS                  
BEGIN         

   SELECT CASE                  
            WHEN EXISTS (SELECT 1                  
                            FROM  attachmentmaster a                                           
                                   INNER JOIN dmsmaster d                  
                                           ON a.ownerid = d.ownerid                  
                                              AND a.attachedid = d.itemid                  
                            WHERE  a.ownerid = 716                  
                                   AND a.ITEMID = ''+@CaseId   +''               
                                   --AND A.CUSTOMFIELDID != 0                  
                                   AND ( d.Itemname LIKE '%'+CONVERT(varchar(50), @CaseId) +' - Request Application Form%' )) THEN 1  
             WHEN EXISTS (SELECT 1                  
                            FROM  attachmentmaster a                                           
                                   INNER JOIN dmsmaster d                  
                                           ON a.ownerid = d.ownerid                  
                                              AND a.attachedid = d.itemid                  
                            WHERE  a.ownerid = 716                  
                                   AND a.ITEMID = ''+@CaseId   +''               
                                   --AND A.CUSTOMFIELDID != 0                  
                                   AND ( d.Itemname LIKE '%'+CONVERT(varchar(50), @CaseId) +' - Adhoc Request Application Form%' )) and EXISTS (SELECT 1 FROM Cas_Ex8 WHERE ownerid=716 and Cas_Ex8_147 = 101 and Cas_ex8_Id = ''+@CaseId   +'')THEN 1  
               ELSE 0                 
             END AS AppFormFlag;             

 

              
END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_rr_to_fetch_case_against_rim]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_rr_to_fetch_case_against_rim]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_rr_to_fetch_case_against_rim]  
(  
 @RIMID INT,  
 @certificatetype INT,  
 @AddressToType NVARCHAR(256),  
 @BankId NVARCHAR(100)  
)    
AS      
  BEGIN      
            
    select C.CaseID  
        ,C8.Cas_Ex8_104 AS Retention_Specialist_User  
     --,C.PreAssignTo AS Retention_Specialist_User  
        ,CL.DisplayName AS Certificate_Type  
        ,C9.Cas_Ex9_128 AS Lc_Reference_number  
        ,C8.Cas_Ex8_181 AS Addressed_to,  
         1 AS ReIssue_Case_Flag  
         FROM cases C  
         INNER JOIN Cas_Ex8 C8 ON C.OwnerID = C8.OwnerId   
             AND C.caseid = C8.Cas_Ex8_id   
         INNER JOIN Cas_Ex9 C9 ON C.OwnerID = C9.OwnerId   
             AND C.caseid = C9.Cas_ex9_Id  
         LEFT JOIN CustomFieldLookup CL ON C8.OwnerID = CL.OwnerId  
             AND C8.Cas_Ex8_147 = CL.ValueId  
             AND CL.FieldId = 12721  
         WHERE C.OwnerID = 716  
       AND C8.Cas_Ex8_124 = @RIMID  
          AND C8.Cas_Ex8_147 = @certificatetype --IN (1,3 ) --Liability Letter addressed to bank, NLC    
          AND C8.Cas_Ex8_181 = @AddressToType --'Bank' -- AND C9.Cas_Ex9_112 = 1 --Bank    
       AND (@certificatetype = 1 OR (@certificatetype = 3 AND C9.Cas_Ex9_112 = @BankId))  
          AND C.StatusCodeID = 1000229 --Certificate Issued    
          AND C9.Cas_ex9_76 >= DATEADD(day, - 100, GETDATE())    
     ORDER BY C.CreatedOn DESC  
      
   
               
  END     
GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_check_for_pnws_doc]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_check_for_pnws_doc]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_check_for_pnws_doc](@leadid INT)  
AS  
  BEGIN  
      SELECT CASE  
               WHEN EXISTS (SELECT 1  
                            FROM   leads l  
                                   INNER JOIN attachmentmaster a  
                                           ON l.ownerid = a.ownerid  
                                              AND l.leadid = a.itemid  
                                   INNER JOIN dmsmaster d  
                                           ON a.ownerid = d.ownerid  
                                              AND a.attachedid = d.itemid  
                            WHERE  l.ownerid = 716  
                                   AND l.leadid = @leadid  
                                   --AND A.CUSTOMFIELDID != 0  
                                   AND ( Itemname LIKE 'Personal Net Worth Statement_%' )) THEN 1  
               ELSE 0  
             END AS is_EIDA_Present;  
  END  
 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_calculate8nw_days]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_calculate8nw_days]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[Ar_calculate8nw_days] (@Case_id INT)               

AS                    

 BEGIN     

Declare @Start_Date DATE     

Declare @DayNumberofweek INT     

Declare @DayNumberofweek2 INT     

Declare @AddDaysfromsameweek INT     

Declare @getdays INT     

Declare @Datefromsameweek DATE     

Declare @remainingdaystoadd INT     

Declare @excludingweekend DATE     

Declare @remainigday1 DATE     

Declare @remainigday2 DATE     

DECLARE @countweek1 INT = 0;     

DECLARE @countweek2 INT = 0;     

          

SELECT @Start_Date = Createdon     

 FROM   Cases     

 WHERE  OwnerId = 716     

 AND CaseID = @Case_id;     

      

--set @Start_Date='2023-10-12'     

      

Declare @Addition_of_Days INT = 7     

          

--1) First Get the entered Day from week     

          

set @DayNumberofweek=DATEPART(WEEKDAY, @Start_Date)     

           

/* Result */--2         

           

--2) addition of days from the same week         

set @AddDaysfromsameweek=          

Case          

 When @DayNumberofweek=2 then 4         

 When @DayNumberofweek=3 then 3         

 When @DayNumberofweek=4 then 2         

 When @DayNumberofweek=5 then 1         

 When @DayNumberofweek in (6,7) then 0     

 END         

          

      

--3) Add days from same week start date and get the date in same week         

          

--set @getdays=(@Start_Date + @AddDaysfromsameweek)         

          

set @Datefromsameweek=DateAdd(day,@AddDaysfromsameweek,@Start_Date)         

      

      

--3.1) Check any holiday in between current week from start date     

      

set @countweek1=(Select count(1) FROM HolidaySettings WHERE ownerid=716 and CONVERT(VARCHAR(10), HolidayDate,120) between @Start_Date and @Datefromsameweek)     

           

--to calculate date      

--4)  Substract the number of days from the require days(7) and considering the holiday to be added extra        

          

set @remainingdaystoadd=(@Addition_of_Days-(@AddDaysfromsameweek-@countweek1))          

           

      

--5) Exclude weekend and get the date         

          

set @excludingweekend=      

Case      

When @DayNumberofweek <=6 then Dateadd(day,3,@Datefromsameweek)      

--When @DayNumberofweek =7 then Dateadd(day,2,@Datefromsameweek)     

else  Dateadd(day,2,@Datefromsameweek) end        

   -- set @excludingweekend=Dateadd(day,3,@Datefromsameweek)     

      

--6) Add the remaining days if less then equal to 5  or greate the 5 then add 2 days as sat and sunday extraa         

             

set @remainigday1=          

CASE          

when @remainingdaystoadd <=5 then Dateadd(day,@remainingdaystoadd-1,@excludingweekend)         

when @remainingdaystoadd =6 then Dateadd(day,5+2,@excludingweekend)     

when @remainingdaystoadd =7 then Dateadd(day,5+3,@excludingweekend)     

 END     

      

--6.1) Check any holiday in between current week from start date     

      

set @countweek2=(Select count(1) FROM HolidaySettings WHERE ownerid=716 and CONVERT(VARCHAR(10), HolidayDate,120) between @excludingweekend and @remainigday1)     

         

          

--7) Add Holiday from Calander for next week and check if day is 6th day from second week     

      

set @DayNumberofweek2=DATEPART(WEEKDAY, @remainigday1)     

set @remainigday2= case when (@DayNumberofweek2=6 and @countweek2 > 0) then Dateadd(day,3,@remainigday1) else Dateadd(day,@countweek2,@remainigday1) end     

      

      

--select          

--@Start_Date as Start_Date,         

--@Addition_of_Days as Addition_of_Days,         

--@DayNumberofweek as DayNumberofweek,         

--@AddDaysfromsameweek as AddDaysfromsameweek,     

--@Datefromsameweek as Datefromsameweek,     

--@countweek1 as countweek1,        

--@remainingdaystoadd as remainingdaystoadd,         

--@excludingweekend as excludingweekend,         

--@remainigday1 as remainigday1,     

--@countweek2 as countweek2,     

--@DayNumberofweek2 as DayNumberofweek2,     

--@remainigday2 as remainigday2             

                

                

 select @remainigday2 as calculated_date                 

                    

  END
GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[adib_login_retention]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[adib_login_retention]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Adib_login_retention] (@userid INT)  
AS  
BEGIN  
DECLARE @count INT  
SELECT @count = Count (1)  
FROM   QueueMembers  
WHERE  ownerid = 716 AND QueueID IN ( 20057, 20061, 20065, 20050, 20067, 20051, 20030) AND QueueID = @userid    
  
IF (@count > 0)  
BEGIN  
SELECT '-' AS loginid  
END  
ELSE  
BEGIN  
SELECT  
--CASE  
--WHEN ( @count > 0 ) THEN '' ELSE EmployeeCode   
-- END AS   
 EmployeeCode as loginid  
FROM   UserContact WHERE  CompanyID = 716 AND Userid = @userid   
END  
END 


GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_concat_str_html_text]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_concat_str_html_text]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_concat_str_html_text] (@CaseID INT)
AS
    DECLARE @PHYLETTERHEADNO NVARCHAR (MAX)

  BEGIN
      SELECT @PHYLETTERHEADNO = Json_value(HtmlText, '$[0].Comment') + ' '
                                + Isnull(Json_value(HtmlText, '$[1].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[2].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[3].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[4].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[5].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[6].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[7].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[8].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[9].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[10].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[11].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[12].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[13].Comment'), '')
                                + ' '
                                + Isnull(Json_value(HtmlText, '$[14].Comment'), '')
      --AS RR_Phy_Ltr_Number 
      FROM   extendedcustomfield
      WHERE  Ownerid = 716
             AND fieldid = 13051
             AND itemid = @CaseID

      UPDATE EXTENDEDCUSTOMFIELD
      SET    HTMLTEXT = ( @PHYLETTERHEADNO )
      WHERE  FIELDID = 13314
             AND ITEMID = @caseid

      UPDATE Cas_Ex9
      SET    Cas_Ex9_182 = ''
      WHERE  CAS_EX9_ID = @CASEID
  END 


GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_rr_check_for_eida_doc]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_rr_check_for_eida_doc]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_rr_check_for_eida_doc](@caseid INT)      
AS      
  BEGIN      
      SELECT CASE      
               WHEN EXISTS (SELECT 1      
                            FROM   Cases c     
                                   INNER JOIN attachmentmaster a      
                                           ON c.ownerid = a.ownerid      
                                              AND c.caseid = a.itemid      
                                   INNER JOIN dmsmaster d      
                                           ON a.ownerid = d.ownerid      
                                              AND a.attachedid = d.itemid      
                            WHERE  c.ownerid = 716      
                                   AND c.caseid = @caseid                                       
                                   AND ( Itemname LIKE 'EIDA%' )) THEN 'Yes'    
               ELSE 'No'      
             END AS is_EIDA_Present;      
  END 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Adib_sp_certificatetype]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Adib_sp_certificatetype]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Adib_sp_certificatetype] (@DocumentTypeid INT)         

AS         

  BEGIN         

      DECLARE @DocumentType NVARCHAR(256);   

      SELECT @DocumentType = CASE         

          WHEN C2.ValueId IN ( 3, 100 ) THEN 'Liability Certificate'

          WHEN C2.ValueId IN (5) THEN 'Salary certificate'

          WHEN C2.ValueId IN (8) THEN 'Account Closing form'

                WHEN C2.ValueId IN (102) THEN 'Reschedule Form'

                               ELSE C2.DisplayName         

                             END         

      FROM   CustomFieldLookup C2         

      WHERE  C2.OwnerId = 716         

             AND C2.FieldId = 12721 -- Certificate Type         

             AND C2.ValueId = @DocumentTypeid         

          

      SELECT C1.DisplayName AS ITemName,         

             C1.Value       AS Code         

      FROM   CustomFieldLookup C1         

      WHERE  C1.OwnerId = 716         

             AND C1.FieldId = 12138 -- Document Type         

             AND Upper(C1.DisplayName) = Upper(@DocumentType)         

  END
GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AR_getRaceIDForAlternatenationality]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[AR_getRaceIDForAlternatenationality]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


 
 CREATE proc [dbo].[AR_getRaceIDForAlternatenationality](@leadid INT)        
 as        
 begin          

declare @value nvarchar(20)
select @value= [value] 
from CustomFieldLookup 
where fieldid=12986 and DisplayName in (select Lea_Ex7_154 from Lea_Ex7 where Lea_Ex7_id=@leadid and ownerid=716)

select [value] as ValueID 
from CustomFieldLookup 
where fieldid= 12774 and DisplayName=@value 
    
end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Adib_Stamp_RimiD_Cases]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Adib_Stamp_RimiD_Cases]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<AMithilesh Tank>
-- Create date: <23/03/2023>
-- Description:	<to update Rim iD>
-- =============================================
CREATE PROCEDURE [dbo].[Adib_Stamp_RimiD_Cases](@v_ownerid int,
@v_caseid int,
@v_accountid int)
AS
BEGIN
	update c8
set c8.Cas_Ex8_144 = A.Acc_ex6_47

--select *
from cas_Ex8 c8
inner join cases c
on c.ownerid = c8.ownerid 
and c.caseid = c8.cas_ex8_id
inner join Acc_ex6 A
on A.OwnerId=c.OwnerID
and A.Acc_ex6_id = c.AccountID
where c8.ownerid= @v_ownerid
and c8.cas_ex8_id = @v_caseid
and A.Acc_ex6_id = @v_accountid


select Cas_Ex8_144 as RimID from cas_Ex8 where OwnerId = @v_ownerid and  cas_ex8_id = @v_caseid 


END


GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_GetEmpCat_For_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_GetEmpCat_For_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Ar_GetEmpCat_For_LeadToCustomer](@leadid int)      
as      
begin      
      
 declare @emptype nvarchar(256),@empStatus nvarchar(256),@nonempstatus nvarchar(256), @selfemp nvarchar(256)      
      
 select @emptype=Lea_Ex8_38       
 from Lea_Ex8       
 where OwnerId=716 AND Lea_Ex8_id= @leadid
      
 select @empStatus=Lea_Ex7_179,@nonempstatus=Lea_Ex7_81,@selfemp=Lea_Ex7_91       
 from Lea_Ex7       
 where OwnerId=716 AND Lea_Ex7_id=@leadid     
      
 if @emptype='Employed'      
 begin       
      
  if @empStatus='Salaried from government / semi-government sector'      
  select 2 as 'value1'      
  else if @empStatus='Salaried from Private Sector (including multi-national companies)'      
  select 3 as 'value1'      
  else if @empStatus='Salaried from free-zone corporations'      
  select 11 as 'value1' 
 end      
      
 else if @emptype='Self-Employed'      
 begin      
      
  if @selfemp='Self Employed/Freelancer'      
  select 4 as 'value1'      
       
 end      
      
 else if @emptype='Non-Employed'      
 begin      
      
  if @nonempstatus='House Wife/Dependent'      
  select 8 as 'value1'      
  else if @nonempstatus='Retired'      
  select 9 as 'value1'      
  else if @nonempstatus='Student'      
  select 7 as 'value1'      
  else if @nonempstatus='Unemployed'      
  select 10 as 'value1'      
      
 end      
end 


GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AR_GetCountry_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[AR_GetCountry_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    
CREATE proc [dbo].[AR_GetCountry_LeadToCustomer] (@leadid int) 
as    
begin    
 select displayname as 'DisplayName'    
 from customfieldlookup     
 where OwnerId=716 AND FieldId=11653 and value= (select Lea_Ex8_168 from Lea_Ex8 where Lea_Ex8_id =@leadid)  
end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_GetOccupation_For_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_GetOccupation_For_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  proc [dbo].[Ar_GetOccupation_For_LeadToCustomer](@leadid int)      
as      
begin      
      
 declare @emptype nvarchar(256),@empStatus nvarchar(256),@nonempstatus nvarchar(256), @selfemp nvarchar(256)      
      
 select @emptype=Lea_Ex8_38       
 from Lea_Ex8       
 where OwnerId=716 AND Lea_Ex8_id= @leadid    
      
 select @empStatus=Lea_Ex7_179,@nonempstatus=Lea_Ex7_81,@selfemp=Lea_Ex7_91       
 from Lea_Ex7       
 where OwnerId=716 AND Lea_Ex7_id=@leadid     
      
 if @emptype='Employed'      
 begin       
      
  if @empStatus='Salaried from government / semi-government sector'      
  select 'Govt. Employee' as 'value1'      
  else if @empStatus='Salaried from Private Sector (including multi-national companies)'      
  select 'Private Employee' as 'value1'      
      
 end      
      
 else if @emptype='Self-Employed'      
 begin      
      
  if @selfemp='Self Employed/Freelancer'      
  select 'Self-employed professional/Freelancer' as 'value1'      
       
 end      
      
 else if @emptype='Non-Employed'      
 begin      
      
  if @nonempstatus='House Wife/Dependent'      
  select 'Housewife' as 'value1'      
  else if @nonempstatus='Retired'      
  select 'Retired' as 'value1'      
  else if @nonempstatus='Student'      
  select 'Student' as 'value1'      
  else if @nonempstatus='Unemployed'      
  select 'Unemployed' as 'value1'      
      
 end      
end 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_Gender_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_Gender_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


   
CREATE proc [dbo].[Ar_Gender_LeadToCustomer] (@leadid int)  
as  
begin  
  declare @GenderID varchar(100)  
  
  select @GenderID= Lea_Ex7_190   
  from Lea_Ex7   
  where OwnerId=716 AND Lea_Ex7_id=@leadid  
  
  if @GenderID ='M'  
  select 1 as 'Valueid'  
  
  else if @GenderID='F'  
  select 2 as 'Valueid'  
  
  else if @GenderID='U'  
  select 3 as 'Valueid'  
  
 end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_MaritalStatus_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_MaritalStatus_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


     
CREATE proc [dbo].[Ar_MaritalStatus_LeadToCustomer] (@leadid int)    
as    
begin    
  declare @MaritalStatusID varchar(100)    
    
  select @MaritalStatusID= Lea_ex5_44     
  from Lea_ex5    
  where OwnerId=716 AND Lea_ex5_Id=@leadid    
    
  if @MaritalStatusID ='M'    
  select 1 as 'Valueid'    
    
  else if @MaritalStatusID='U'    
  select 2 as 'Valueid'    
    
  else if @MaritalStatusID='W'    
  select 3 as 'Valueid'    
    
 end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_Greeting_LeadToCustomer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_Greeting_LeadToCustomer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


       
CREATE proc [dbo].[Ar_Greeting_LeadToCustomer] (@leadid int)      
as      
begin      
  declare @GreetingID varchar(100)      
      
  select @GreetingID= Lea_Ex7_88  
  from Lea_Ex7  
  where OwnerId=716 AND Lea_Ex7_Id=@leadid     
      
  if @GreetingID ='Mr'      
  select 3 as 'Valueid'      
      
  else if @GreetingID='Ms'      
  select 11 as 'Valueid'      
      
  else if @GreetingID='Mrs'      
  select 4 as 'Valueid'      
  
  else if @GreetingID='H.H. SHEIKH'      
  select 10 as 'Valueid'   
    
  else if @GreetingID='H.H SHEIKHA'      
  select 24 as 'Valueid'   
   
 end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_get_num_in_words_BF]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_get_num_in_words_BF]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_get_num_in_words_BF] (@Number NVARCHAR(max) = 0)        
AS        
  BEGIN        
      DECLARE @num INT        
      DECLARE @decimal INT        
      DECLARE @NuminWord VARCHAR(8000)        
      DECLARE @Numindecimal VARCHAR(8000)        
      DECLARE @finaloutput VARCHAR(8000)        
        
      SELECT @num = Cast(Floor(@Number) AS INT)        
        
      --  SELECT @decimal = CONVERT(VARCHAR, CONVERT(INT, 100 * ( @Number - @num )))          
          SELECT @decimal = Cast(Parsename(@Number, 1)AS INT)        
        
      IF( @num = @decimal )        
        BEGIN        
            SELECT @decimal = 0
			
        END        
      ELSE        
        BEGIN        
            SELECT @decimal = @decimal        
        END        
        
      SELECT @NuminWord = dbo.Adib_convert_number_to_word(@num) --   + ' Dirhams '          
      SELECT @Numindecimal = dbo.Adib_convert_number_to_word(@decimal) --+ ' Fils '          
        
      IF ( @decimal ) = 0    
        BEGIN        
            SELECT @finaloutput = @NuminWord        
        END        
      ELSE        
        BEGIN        
            SELECT @finaloutput = @NuminWord + ' Point ' + @Numindecimal      
        END        
        
      SELECT CASE        
               WHEN Isnull(@Number, '') = '' THEN ''        
               ELSE @finaloutput        
               END AS outputString;        
  END        
--Exec Ar_get_num_in_words_BF 43545.454        
--Exec Ar_get_num_in_words ''

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_POA_RIM_CHECK]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_POA_RIM_CHECK]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ADIB_POA_RIM_CHECK]            
(            
   @RIM1 NVARCHAR(256)=NULL            
  ,@RIM2 NVARCHAR(256)=NULL            
  ,@RIM3 NVARCHAR(256)=NULL            
  ,@POAREQ NVARCHAR(10)=NULL            
  ,@POACNT NVARCHAR(10)=NULL            
)            
AS            
BEGIN            
 IF @POAREQ='Yes' AND @POACNT = 2      
 BEGIN      
 --IF (@RIM1=@RIM2 AND (@RIM3=NULL or @RIM3=''))      
 IF (@RIM1=@RIM2)    
 BEGIN          
 SELECT '1' as OP, 'RIMs selected in the journey i.e., RIM for POA1 and RIM for POA2 should be different' as Msg      
 END      
 ELSE      
 BEGIN      
 SELECT '0' as OP, 'RIMs selected in the journey i.e.,IM for POA1 and RIM for POA2 Rim is unique.' as Msg      
 END      
END       
ELSE IF @POAREQ='Yes' AND @POACNT = 3            
 BEGIN       
IF (@RIM1!=@RIM2 AND @RIM1!=@RIM3 AND @RIM2!=@RIM3)    -- ALL UNIQUE      
BEGIN          
SELECT '0' as OP, 'RIMs selected in the journey i.e., RIM for POA1, RIM for POA2, RIM for POA3 is unique' as Msg            
END          
ELSE IF (@RIM1=@RIM2 AND @RIM1=@RIM3 AND @RIM2=@RIM3)  -- ANY ONE MATCHING      
BEGIN      
SELECT '1' as OP, 'RIMs selected in the journey i.e., RIM for POA1, RIM for POA2, RIM for POA3 should be different.' as Msg            
END             
ELSE IF (@RIM1=@RIM2 AND @RIM1!=@RIM3 AND @RIM2!=@RIM3)   -- 1 and 2 same rest different          
BEGIN       
SELECT '1' as OP, 'RIMs selected in the journey i.e., RIM for POA1 and RIM for POA2 should be different' as Msg            
END      
ELSE IF (@RIM2=@RIM3 AND @RIM1!=@RIM2 AND @RIM1!=@RIM3)   -- 2 and 3 same rest different      
BEGIN      
SELECT '1' as OP, 'RIMs selected in the journey i.e., RIM for POA2 and RIM for POA3 should be different' as Msg      
END      
ELSE IF (@RIM1=@RIM3 AND @RIM1!=@RIM2 AND @RIM2!=@RIM3)   -- 1 and 3 same rest different      
BEGIN      
SELECT '1' as OP, 'RIMs selected in the journey i.e., RIM for POA1 and RIM for POA3 should be different.' as Msg      
END      
END      
 ELSE      
 BEGIN        
 SELECT '0000' as OP, 'Please check the input Parameters' as Msg      
 END      
END 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_LeadTOCust_ProductDetails]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_LeadTOCust_ProductDetails]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_LeadTOCust_ProductDetails] (@leadid int)   
AS    
begin  
Declare @accountname nvarchar(200)

select @accountname=level2 from 
Lea_ex5 l 
inner join 
MultiLevelField m 
on l.ownerid=m.ownerid
AND l.Lea_ex5_34=m.Level2id
where  Lea_ex5_id=@leadid and m.fieldid=12875
     
select distinct productid  
,name as Account_Type  
,TopCategoryID as ProductCategoryId  
,productcode  
,TopCategoryName as ProductCategoryName  
from   
products p inner join 
MultiLevelField m   
on p.ownerid=m.ownerid
where p.ownerid=716 and p.name=@accountname and topcategorycode='DE'


end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_LeadTOCustomer_product_holding_flag_update]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_LeadTOCustomer_product_holding_flag_update]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [DBO].[AR_LEADTOCUSTOMER_PRODUCT_HOLDING_FLAG_UPDATE] (@ACCOUNTID INT, @OWNERID1 INT=716)          
AS          
          
BEGIN          
SET NOCOUNT ON;          
------------------------TO UPDATE PRODUCT HOLDINGS FLAGS FOR CUSTOMERS	         
      
UPDATE ACC_EX6 SET ACC_EX6_134=1 WHERE OWNERID=716 AND	ACC_EX6_ID=@ACCOUNTID
UPDATE HOLDING SET ACCOUNTID=@ACCOUNTID WHERE OWNERID=716 AND RELATEDTOID=@ACCOUNTID

--UPDATE A6          
--SET    A6.ACC_EX6_134 = CASE          
--                        WHEN ( (SELECT TOP 1 1          
--                                FROM   HOLDING          
--                                WHERE  OWNERID = @OWNERID1          
--                                        AND RELATEDTOID = A.ACCOUNTID          
--                                        AND PRODUCTCATEGORYID = 1500002          
--                                --AND HOLDING.STATUSCODEID <> 1000013          
--                                ) = 1 ) THEN 1 --DEPOSIT AVAILED            
--                        ELSE 2          
--                        END
						--,        
        -- A6.ACC_EX6_135 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500007          
                                -- --AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --HOME FINANCE AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_136 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500003          
                                -- --AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --WEALTH AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_137 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500004          
                                -- -- AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --COVERED CARD AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_138 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500005          
                                -- -- AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --PERSONAL FINANCE AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_140 = CASE          
            -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500006          
                                -- -- AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --TAKAFUL AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_141 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
              -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- AND PRODUCTCATEGORYID = 1500001          
                                -- --AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --AUTO FINANCE AVAILED            
                        -- ELSE 2          
                        -- END,          
        -- A6.ACC_EX6_162 = CASE          
                        -- WHEN ( (SELECT TOP 1 1          
                                -- FROM   HOLDING          
                                -- WHERE  OWNERID = @OWNERID1          
                                        -- AND ACCOUNTID = A.ACCOUNTID          
                                        -- --AND PRODUCTCATEGORYID = 1500002          
                                        -- AND PRODUCTID = 1511285          
                                -- --AND HOLDING.STATUSCODEID <> 1000013          
                                -- ) = 1 ) THEN 1 --SAFE DEPOSIT LOCKER AVAILED          
                        -- ELSE 2          
                        -- END          
--FROM   ACCOUNTS A          
--  INNER JOIN ACC_EX6 A6          
--    ON A.OWNERID = A6.OWNERID          
--    AND A.ACCOUNTID = A6.ACC_EX6_ID          
--WHERE  A.OWNERID = @OWNERID1          
--        AND A.LAYOUTID = 10000007 -- CUSTOMER LAYOUT ID        
          
--DECLARE @STATUS  INT      
--SELECT @STATUS=ACC_EX6_134 FROM ACC_EX6 WHERE ACC_EX6_ID=@ACCOUNTID AND OWNERID=@OWNERID1  
--IF @STATUS=1      
--BEGIN      
--UPDATE HOLDING SET ACCOUNTID=@ACCOUNTID WHERE RELATEDTOID=@ACCOUNTID AND OWNERID=@OWNERID1      
--END      
          
         
END 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_get_StaffName_RR]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_get_StaffName_RR]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Ar_get_StaffName_RR] (@userid INT)                  
AS                  
  BEGIN                  
      select UC.username as Username from az_user AU
      INNER JOIN UserContact UC
      on AU.AppOwnerID = UC.CompanyID
      and AU.UserID = UC.UserID
      where AU.AppOwnerID = 716
   and AU.UserID = @userid        
  END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_update_lead_flag]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_update_lead_flag]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC dbo.Ar_update_lead_flag (@lead_ID INT,
                                @Flag    INT)
AS
  BEGIN
      UPDATE L6
      SET    L6.Lea_Ex6_52 = @Flag
      FROM   Lea_Ex6 L6
      WHERE  Ownerid = 716
             AND L6.Lea_Ex6_Id = @lead_ID

      SELECT 'Value ' + cast(L6.Lea_Ex6_52 as nvarchar) + ' Updated as Flag' AS Result
      FROM   Lea_Ex6 L6
      WHERE  Ownerid = 716
             AND L6.Lea_Ex6_Id = @lead_ID
  END 


  exec Ar_update_lead_flag 50014220, 111111111


  Select * from MashupDataSource order by datasourceid desc 

  --110379	100001	Update Lead Flag
  SELECT L6.Lea_Ex6_52 
      FROM   Lea_Ex6 L6
      WHERE  Ownerid = 716
             AND L6.Lea_Ex6_Id = 50014312



Select RatingID, ProductID, lastmodifiedon, email,layoutid, processid, * from leads where ownerid = 716 and leadid = 50014312   --2023-05-19 07:03:42.410


Select * from objectschema where fieldname = 'Lea_Ex6_52'

Select * from customfieldlookup where fieldid = 10732 

Select top 200 * from EmailBlaster where ownerid = 716 order by blasterid desc 
Select top 200 * from EmailBlastermember where ownerid = 716 order by blasterid desc 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Get_signature_stamped_OR_Not]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Get_signature_stamped_OR_Not]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure dbo.Get_signature_stamped_OR_Not(@caseid INT)
AS
Begin

 

Declare @Flag nvarchar(max)
Declare @OutputFlag nvarchar(max)

 

select @Flag=HTMLTEXT 
from ExtendedCustomField 
where ownerid=716 
and fieldid=12526 --capture signature case
and ItemID=@caseid

 

select @OutputFlag= case 
when @Flag IS NOT NULL THEN 'Yes' ELSE 'NO'
END

 

select @OutputFlag as OutputFlag

 

END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_Ar_ETB_IsEmailPresent]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_Ar_ETB_IsEmailPresent]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


  
CREATE PROCEDURE [dbo].[PB_Ar_ETB_IsEmailPresent](@Email nvarchar(100),@marriagestat nvarchar(20))      
AS      
  /* Author: Anshul Pundir      
      
  Description:  concatenate Strings */      
  BEGIN      
      SET NOCOUNT ON;     
	  select @marriagestat as marriage
     
    SELECT   @Email as Email_Output,  
    CASE When isnull(@Email, '0') = '0' Then 2      
    Else 1 END as EmailFlag    
	
  END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_ETB_Ar_rims_lead_details]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_ETB_Ar_rims_lead_details]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


  
  
CREATE PROC [dbo].[PB_ETB_Ar_rims_lead_details] (@RIM_No INT)          
AS          
  /* Author: Anshul Pundir                
  Description: To get the leads Details created for a RIM*/          
  BEGIN          
     SELECT L.leadid        AS Lead_ID,          
             SC.statuscode   AS Status_Code,      
    level2 AS Account_Type,  
             lea_ex8_98      AS Branch_Name,          
             L.leadownername AS Owner,          
             dateadd(mi, 240, L.createdon) as createdon,          
             L7.lea_ex7_198  AS IAO_Branch_Code,          
             L9.lea_ex9_169  AS Employee_Code_IAO_lea          
      FROM   leads L          
             INNER JOIN lea_ex6 L6          
                     ON L.ownerid = L6.ownerid          
                        AND L.leadid = L6.lea_ex6_id          
             INNER JOIN lea_ex7 L7          
                     ON L.ownerid = L7.ownerid          
                        AND L.leadid = L7.lea_ex7_id          
             INNER JOIN lea_ex8 L8          
                     ON L.ownerid = L8.ownerid          
                        AND L.leadid = L8.lea_ex8_id          
             INNER JOIN lea_ex9 L9          
                     ON L.ownerid = L9.ownerid          
                        AND L.leadid = L9.lea_ex9_id      
             INNER JOIN lea_ex4 L4         
                     ON L.ownerid = L4.ownerid          
                        AND L.leadid = L4.lea_ex4_id   
       INNER JOIN lea_ex5 L5        
                     ON L.ownerid = L5.ownerid          
                        AND L.leadid = L5.lea_ex5_id    
       INNER JOIN MultiLevelField ml  
     on ml.Level2Id=l5.Lea_ex5_34  
        AND ml.fieldid=12875  
             INNER JOIN statuscodemaster SC          
                     ON SC.ownerid = 716          
                        AND SC.itemtypeid = 6          
                        AND SC.statuscodeid NOT IN ( 1000096, 1000097, 1000149,1000244 )          
                        AND L.ownerid = SC.ownerid          
                        AND L.statuscodeid = SC.statuscodeid          
      WHERE  L.ownerid = 716          
             AND L.layoutid = 10010125          
             -- ETB Instant Account Opening --10010045 --Instant Account Opening Layout                
             AND L6.lea_ex6_5 = @RIM_No          
      ORDER  BY L.leadid desc            
    
    
    
  END   
  
  

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_ETB_AccountName]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_ETB_AccountName]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [DBO].[PB_ETB_AccountName] (@leadid as int)  
as  
  
begin  
  
Declare @accountvalue varchar(30)  
  
select @accountvalue=Lea_ex5_34   
from Lea_ex5   
where Lea_ex5_id= @leadid and OwnerId=716  
  
select Level2  as accountname  
from MultiLevelField   
where fieldid=12875 and Level2Id=@accountvalue and OwnerId=716  
  
  
end  

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_ETB_Ar_ETB_Concatenate_String]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_ETB_Ar_ETB_Concatenate_String]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PB_ETB_Ar_ETB_Concatenate_String](@FirstName nvarchar(512) , @LastName nvarchar(512), @AccountNumber nvarchar(50))      
AS      
  /* Author: Anshul Pundir      
      
  Description:  concatenate Strings */      
  BEGIN      
      SET NOCOUNT ON;      
        
      
      SELECT @FirstName + ' ' + @LastName as FullName, @FirstName + ' ' + @LastName as EIDFullName  
  END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_LeadToCustomer_AssignRM]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_LeadToCustomer_AssignRM]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[PB_LeadToCustomer_AssignRM] (@leadid int)
as

begin

  SELECT  L.Lea_Ex7_26 AS RSMID, 
		  U.USERNAME AS RMNAME 
  FROM    Lea_Ex7 L inner join USERCONTACT U 
		  on L.Lea_Ex7_26 = U.EmployeeCode 
  WHERE   COMPANYID = 716 AND 
		  Lea_Ex7_id=@leadid

end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AR_PB_ExistingAccId]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[AR_PB_ExistingAccId]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[AR_PB_ExistingAccId] (@RIMID INT)  
AS  
BEGIN  
SELECT acc_ex6_47,acc_ex6_id as'accountid'  from acc_ex6 where ownerid=716 and Acc_ex6_Id=@RIMID
END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_AR_FetchBranchList]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_AR_FetchBranchList]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[PB_AR_FetchBranchList] (@ownerid1 int)      
AS      
BEGIN       
select      
Name as BranchName,    
code as BranchCode     
from regions        
where ContinentName in ('UAE' ,'Private Banking')    
and IsParent=0  
--and Code not in (358,31,43,27,9,34,84,12)    
and OwnerID=716 --and isnull(code,'')<>''      
order by name    
END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_PB_POA_NO]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_PB_POA_NO]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ADIB_PB_POA_NO] (@NO_Of_POA_Required NVARCHAR(56) )
AS
BEGIN
IF @NO_Of_POA_Required IN (1, 2, 3)
BEGIN 
SELECT    
'' AS 'RIM of POA 1',    
'' AS 'Name from ETHIX POA1',    
'' AS 'RIM from ETHIX POA1',    
'' AS 'POA1 Valid Till',   
 '' AS 'Annotation POA1',    
 '' AS 'Signature Capture POA1 ',   
 '' AS 'RIM Type POA1',    
 '' AS 'POA1 Ethics Status',   
 NULL AS 'Document For POA1',    
 '' AS 'RIM of POA 2',    
 '' AS 'Name from ETHIX POA2',   
 '' AS 'RIM from ETHIX POA2',    
 NULL AS 'Document For POA2',   
 '' AS 'Annotation POA2',    
 '' AS 'Signature Capture POA2',   
 '' AS 'POA2 Valid Till',   
 '' AS 'RIM Type POA2',  
 '' AS 'RIM Status POA2',    
 '' AS 'RIM of POA 3',    
 '' AS 'Name from ETHIX POA3',    
 '' AS 'RIM from ETHIX POA3',    
 '' AS 'POA3 Valid Till',   
 '' AS 'Annotation POA3',   
 NULL AS 'Document For POA3',  
 '' AS 'POA Issuance Emirate',    
 '' AS 'Signature Capture POA3',  
 '' AS 'POA2 Ethics Status',    
 '' AS 'POA3 Ethics Status',    
 '' AS 'RIM Type POA3',    
 '' AS 'RIM Status POA3'   
 END   
 ELSE 
 BEGIN  
 SELECT    1 AS 'OUTPUT' 
 END 
 END 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_LIAB_PASSPORTDEDUPE]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_LIAB_PASSPORTDEDUPE]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
	Modified by: Hemant Rajam
	Modified on: 16 Jul 2024
	Comment: Added RIM blank filter for internal passport dedupe.
*/
-----------------------------------------
CREATE    PROCEDURE [dbo].[ADIB_LIAB_PASSPORTDEDUPE](@PASSPORTNUMBER NVARCHAR(50))
AS
  BEGIN
      DECLARE @OP NVARCHAR(20);
	  DECLARE @OP1 NVARCHAR(20);
 
      SELECT TOP 1 @OP = L.leadid
      FROM   leads L
             INNER JOIN lea_ex7 L7
           ON L.ownerid = L7.ownerid
                        AND L7.lea_ex7_id = L.leadid
             INNER JOIN lea_ex6 L6
                     ON L.ownerid = L6.ownerid
                        AND L6.lea_ex6_id = L.leadid
             INNER JOIN lea_ex8 L8
                     ON L.ownerid = L8.ownerid
                        AND L8.lea_ex8_id = L.leadid
      WHERE  L.ownerid = 716 
		AND L.Layoutid = 10010128
		AND L.StatusCodeID not in (1000131,1000097) --Approved and Closed staus 
		--AND isnull(Lea_Ex6_5,'') = '' --where RIM is blank, to include Approved leads as well
		AND L8.LEA_EX8_101 = 'In Progress' -- Continue with lead journey 
        AND L7.lea_ex7_2 = @PASSPORTNUMBER
 
      SELECT CASE
               -- WHEN @@ROWCOUNT = 0 THEN 0    
               WHEN ( ISNULL(@OP,'0') = '0') THEN 0

               ELSE @OP
             END AS EXISTINGLEADID;
  END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_LIAB_CUST_360]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_LIAB_CUST_360]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ADIB_LIAB_CUST_360]  (@RIM INT)                      
AS                      
BEGIN                      
            
SELECT A6.Acc_ex6_47 as RIMID,A6.Acc_ex6_1 as FIRSTNAME,A6.Acc_ex6_8 as LASTNAME,A6.Acc_ex6_1 +' '+A6.Acc_ex6_8 as FULLNAME,  
A6.Acc_ex6_48 as EID,      
L.NAME as GENDER,A6.Acc_ex6_41 as POB,      
A.Email,A6.Acc_ex6_73 as NATIONALITY,A.DateOfBirth as DOB,C.DisplayName AS NATIONALITYNAME,isnull(A.Phone,'') as RESIDENCEPHONE,      
A.Bill_Address as ADDRESS1,        
 a.Ship_Address as ADDRESS2,A6.Acc_ex6_67 as CITY,A6.Acc_ex6_68 as STATE,A6.Acc_ex6_69 as POBOX,A6.Acc_ex6_71 as COMPANY,      
 c1.DisplayName as OCCUPATION,isnull(A6.Acc_ex6_66,'') as ADDRESS3   ,
 A6.Acc_ex6_1 as FIRSTNAMELEA,A6.Acc_ex6_8 as LASTNAMELEA,A6.Acc_ex6_45 as CLASSCODE,Acc_ex6_60 as RMID,Acc_ex6_64 as	RIMStatus
 from Accounts A   
 inner join Acc_ex6 A6 on A6.OwnerID=A.OwnerID and A.AccountID=a6.acc_ex6_id          
left join CustomFieldLookup C on C.OwnerID=A6.OwnerID AND C.FIELDID=10160 AND C.ValueId=A6.Acc_ex6_73        
left join CustomFieldLookup C1 on C.OwnerID=A6.OwnerID AND C1.fieldid=10159 AND C1.ValueId=A6.Acc_ex6_72      
LEFT JOIN LookUpMaster L ON L.OWNERID=A.OwnerID AND L.GroupKey=417 AND L.LookUpId=A.GenderID          
where a6.Acc_ex6_47=@RIM               
                
END 



GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_check_for_edd_doc]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_check_for_edd_doc]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Ar_check_for_edd_doc](@leadid INT)    
AS    
  BEGIN    
      SELECT CASE    
               WHEN EXISTS (SELECT 1    
                            FROM   leads l    
                                   INNER JOIN attachmentmaster a    
                                           ON l.ownerid = a.ownerid    
                                              AND l.leadid = a.itemid    
                                   INNER JOIN dmsmaster d    
                                           ON a.ownerid = d.ownerid    
                                              AND a.attachedid = d.itemid    
                            WHERE  l.ownerid = 716    
                                   AND l.leadid = @leadid    
                                   --AND A.CUSTOMFIELDID != 0    
                                   AND ( Itemname LIKE 'EDD Form%' )) THEN 1    
               ELSE 0    
             END AS is_EIDA_Present;    
  END    

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ar_rr_check_for_retail_customer]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Ar_rr_check_for_retail_customer]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Ar_rr_check_for_retail_customer](@rimid NVARCHAR(20),@caseid INT)
AS          
  BEGIN
  Declare @getvalue nvarchar(20)
 
	select @getvalue =Cas_ex10_27 
	from Cas_ex10 
	where ownerid=716 and Cas_ex10_id=@caseid
 
	IF(@getvalue = 'RT01' or @getvalue = 'RT02')
	BEGIN 
	SELECT  'No' AS is_Customer_Present;
 
	END
	ELSE
	BEGIN
	SELECT CASE          
               WHEN EXISTS (SELECT 1          
                            FROM   Acc_Ex6 a         
                            WHERE  a.ownerid = 716          
                                   AND a.Acc_Ex6_47= @rimid) THEN 'Yes'
               ELSE 'No'          
             END AS is_Customer_Present;
	END
  END

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADIB_PB_POA_CLEAR]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[ADIB_PB_POA_CLEAR]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--sp_helptext ADIB_PB_POA_NO

CREATE PROCEDURE [dbo].[ADIB_PB_POA_CLEAR] (@relationship_with_otherbank NVARCHAR(56) )  
AS  
BEGIN  
IF @relationship_with_otherbank in ('1','2','3','Not Provided')  
BEGIN   
SELECT      
 '' AS 'Name of Bank',      
 '' AS 'Name of Bank 1',      
 '' AS 'Name of Bank 2',      
 '' AS 'Length of Relationship',     
 '' AS 'Length of Relationship 1',      
 '' AS 'Length of Relationship 2',     
 '' AS 'Type of Account new IAO',      
 '' AS 'Type Of Account 1 new IAO',     
 '' AS 'Type Of Account 2 new IAO',      
 '' AS 'Account Status',      
 '' AS 'Account Status 1',     
 '' AS 'Account Status 2'    
 END     
 ELSE   
 BEGIN    
 SELECT 1 AS 'OUTPUT'   
 END   
 END 

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PB_ETB_RIM_Comparison_With_CustomeRIM]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[PB_ETB_RIM_Comparison_With_CustomeRIM]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PB_ETB_RIM_Comparison_With_CustomeRIM]            
(            
   @RIM1 NVARCHAR(256)=NULL            
  ,@RIM2 NVARCHAR(256)=NULL            
  ,@RIM3 NVARCHAR(256)=NULL            
  ,@POAREQ NVARCHAR(10)=NULL            
  ,@custRIM INT = NULL
)            
AS            
BEGIN   

 IF @POAREQ='Yes'  
 BEGIN  
 
	IF (@RIM1=@custRIM)    
	BEGIN          
	SELECT '1' as OP, 'POA1 RIM should not be equal Customer RIM' as Msg      
	END      
	ELSE if (@RIM2=@custRIM)     
	BEGIN      
	SELECT '1' as OP, 'POA2 RIM should not be equal Customer RIM' as Msg      
	END      
    ELSE IF (@RIM3=@custRIM)  
	Begin
	SELECT '1' as OP, 'POA3 RIM should not be equal Customer RIM' as Msg      
	end
	else 
	begin 
	SELECT '0' as OP, 'POA RIM are unique' as Msg 
	end

end
 
end

GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Assets_CC_Forms_Button_Mandatory]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Assets_CC_Forms_Button_Mandatory]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Assets_CC_Forms_Button_Mandatory](@Lead_ID INT)        
AS        
  BEGIN        
      
	  DECLARE @RM_Members Table
	  (
	  MemberID INT
	  );

	  INSERT INTO DMS_ex5    
                  (ownerid,    
                   DMS_Ex5_id)    
      SELECT d.ownerid,    
             d.itemid    
      FROM   DMSMaster d    
             INNER JOIN AttachmentMaster a    
                     ON d.ownerid = a.ownerid    
                        AND d.itemid = a.AttachedID    
      WHERE  d.ownerid = 716    
             AND d.itemid NOT IN (SELECT DMS_ex5_id    
                                  FROM   dms_ex5    
                                  WHERE  ownerid = 716)

	  INSERT INTO @RM_Members
	  SELECT RM.MemberID    
                            FROM   az_role R        
                                   INNER JOIN Az_RoleAssignment RM        
                                           ON R.APpOwnerID = RM.APpOwnerID        
                                              AND R.RoleId = RM.RoleId        
                                              AND R.RoleID IN(10001,10037,10012, 10003,1,10045) -- RM Role ID 
											  
											 -- select * from   @RM_Members;                                              
      
  SELECT CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d
																		INNER JOIN  DMS_ex5 DMS_5
																		on d.OWNERID = DMS_5.OWNERID
																		and d.ItemID=DMS_5.DMS_ex5_Id        
                                                                         INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6        
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		-- and isnull(DMS_5.DMS_ex5_5,0)=0
																		and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Affordability Assessment Form CC%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS Affordability,
			 CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d 
																		INNER JOIN  DMS_ex5 DMS_5
																		on d.OWNERID = DMS_5.OWNERID
																		and d.ItemID=DMS_5.DMS_ex5_Id      
                                                                         INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6       
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		 --and isnull(DMS_5.DMS_ex5_5,0)=0  
																		and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Consent Letter EFTS CC%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS ConsentEFTS,      
            CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d        
																		INNER JOIN  DMS_ex5 DMS_5
																		on d.OWNERID = DMS_5.OWNERID
																		and d.ItemID=DMS_5.DMS_ex5_Id 
																		 INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6        
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		-- and isnull(DMS_5.DMS_ex5_5,0)=0    
																		and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Key Fact Statement CC%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS KFS,
			 CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d
																			INNER JOIN  DMS_ex5 DMS_5
																			on d.OWNERID = DMS_5.OWNERID
																			and d.ItemID=DMS_5.DMS_ex5_Id         
                                                                         INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6        
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		 --and isnull(DMS_5.DMS_ex5_5,0)=0    
																		and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Covered Card Application%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS CC_Application,
			 CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d
																		INNER JOIN  DMS_ex5 DMS_5
																		on d.OWNERID = DMS_5.OWNERID
																		and d.ItemID=DMS_5.DMS_ex5_Id         
                                                                         INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6        
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		 --and isnull(DMS_5.DMS_ex5_5,0)=0 
																		 and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Takaful Key Fact Statement CC%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS Takaful_KFS,
			 CASE        
               WHEN EXISTS (SELECT 1        
                            FROM   @RM_Members RM 
							where RM.MemberID IN (SELECT a.AttachedBy        
                                                                  FROM   DMSMASTER d
																		INNER JOIN  DMS_ex5 DMS_5
																		on d.OWNERID = DMS_5.OWNERID
																		and d.ItemID=DMS_5.DMS_ex5_Id         
                                                                         INNER JOIN ATTACHMENTMASTER a        
                                                                                 ON d.OWNERID = a.OWNERID        
                                                                                    AND d.ITEMID = a.ATTACHEDID        
                                                                                    AND a.ITEMTYPE = 6        
                                                                         INNER JOIN Leads L        
                                                                                 ON L.OWNERID = a.OWNERID        
                                                                                    AND L.LeadId = a.ITEMID      
                       
                                                                  WHERE  L.OWNERID = 716        
                                                                         AND L.LeadID = @Lead_ID
																		 --and isnull(DMS_5.DMS_ex5_5,0)=0 
																		 and (DMS_5.DMS_ex5_5 is null or DMS_5.DMS_ex5_5='Success')
                                                                         AND d.ItemName LIKE '%Consent Letter From Customer CC%')) THEN 'Y'        
        
        
               ELSE 'N'        
             END AS Consent_Letter
			 
			    
  END      
       
  
GO



GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Assets_PF_Forms_Button_Mandatory]') AND type IN (N'P', N'PC'))
DROP PROCEDURE [dbo].[Assets_PF_Forms_Button_Mandatory]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Assets_PF_Forms_Button_Mandatory](@Lead_ID INT)                  
AS                  
  BEGIN                  
                
   DECLARE @RM_Members Table          
   (          
   MemberID INT          
   );          
         
   INSERT INTO DMS_ex5 (ownerid,  DMS_Ex5_id) SELECT d.ownerid, d.itemid  FROM   DMSMaster d  INNER JOIN AttachmentMaster a       
    ON d.ownerid = a.ownerid  AND d.itemid = a.AttachedID  WHERE  d.ownerid = 716       
 AND d.itemid NOT IN (SELECT DMS_ex5_id FROM   dms_ex5   WHERE  ownerid = 716)        
      
   INSERT INTO @RM_Members          
   SELECT RM.MemberID              
                            FROM   az_role R                  
                                   INNER JOIN Az_RoleAssignment RM                  
                                           ON R.APpOwnerID = RM.APpOwnerID                  
                                              AND R.RoleId = RM.RoleId                  
                                              AND R.RoleID = 10003 -- RM Role ID           
                       
            -- select * from   @RM_Members;                                                        
                
  SELECT CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'           
                                                                         AND d.ItemName LIKE '%KFS Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Key_Fact_Statement',     
			 
			 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'           
                                                                         AND d.ItemName LIKE '%KFS Form Arabic%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Key_Fact_Statement_Arabic',     
    CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d       
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                 
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
        AND a.ITEMTYPE = 6                 
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID      
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'               
                                                                         AND d.ItemName LIKE '%Affordability Assessment Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Affordability_Assessment_Form',                
            CASE                  
               WHEN EXISTS (SELECT 1                  
        FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                  FROM   DMSMASTER d           
      INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID           
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'         
                                                                         AND d.ItemName LIKE '%Alkhair Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Alkhair_Application_Form',          
    CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d          
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id              
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
            ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                     WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                   AND d.ItemName LIKE '%Sukuk Finance Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Sukuk_Finance_Application_Form',          
    CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d       
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                 
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                   AND L.LeadID = @Lead_ID              
               and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'       
                                                                         AND d.ItemName LIKE '%Sukuk Liabilities Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Sukuk_Liabilities_Application_Form',          
    CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d       
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                 
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                   WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Sukuk Islamic Liabilities Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Sukuk_Islamic_Liabilities_Application_Form',        
 CASE                  
               WHEN EXISTS (SELECT 1                  
  FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d          
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id              
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Tadawul Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Tadawul_Application_Form',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
         FROM   DMSMASTER d            
   INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id            
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%Noor Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Noor_Application_Form',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d           
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID       
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'              
                                                                         AND d.ItemName LIKE '%Tamweel Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Tamweel_Application_Form',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d         
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id               
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
               
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Terhal Application Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Terhal_Application_Form',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id           
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                       INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID       
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'              
                                                                         AND d.ItemName LIKE '%Authorization Letter to Debit Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Authorization_Letter_to_Debit',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Grace Period Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Grace_Period_Form',        
        
        
 CASE      
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d           
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a           
                                                                                 ON d.OWNERID = a.OWNERID                  
                   AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                        WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Consent Letter for EFTS Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Consent_Letter_for_EFTS',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d         
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id               
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%OTS and Acceptance Notice Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'OTS_and_Acceptance_Notice',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d         
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id               
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                              ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                 AND L.LeadID = @Lead_ID              
             and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'       
                                                                         AND d.ItemName LIKE '%Customer Undertaking Bureau Form%')) THEN 'Yes'                  
                  
             
               ELSE 'No'                  
             END AS 'Customer_Undertaking_Bureau',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%Facility Offer Letter Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Facility_Offer_Letter',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d        
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id                
                                                                      INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                     WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%First Undertaking Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'First_Undertaking',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d         
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id            
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                            AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%Second Undertaking Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Second_undertaking',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d           
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%International Commodities Murabaha Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'International_Commodities_Murabaha_Form',        
        
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d             
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id           
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                 AND d.ItemName LIKE '%Letter of Gurantee Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Letter_of_Guarantee',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d           
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                             AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID       
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'              
                                                                         AND d.ItemName LIKE '%Murabaha Shares Sales Contract%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Murabaha_Shares_Sales_Contract',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                         FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d          
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id              
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                               ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID        
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'             
                                                                         AND d.ItemName LIKE '%Promise To Purchase Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Promise_to_Purchase',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d           
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
                  and d.ItemID=DMS_5.DMS_ex5_Id             
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                               AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                                                                         AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Indicative Offer Letter Form%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Indicative_Offer_Letter',        
            
 CASE                  
               WHEN EXISTS (SELECT 1                  
                            FROM   @RM_Members RM           
       where RM.MemberID IN (SELECT a.AttachedBy                  
                                                                  FROM   DMSMASTER d          
                  INNER JOIN  DMS_ex5 DMS_5        
                  on d.OWNERID = DMS_5.OWNERID        
               and d.ItemID=DMS_5.DMS_ex5_Id              
                                                                         INNER JOIN ATTACHMENTMASTER a                  
                                                                                 ON d.OWNERID = a.OWNERID                  
                                                                                    AND d.ITEMID = a.ATTACHEDID                  
                                                                                    AND a.ITEMTYPE = 6                  
                                                                         INNER JOIN Leads L                  
                                                                                 ON L.OWNERID = a.OWNERID                  
                                                                                    AND L.LeadId = a.ITEMID                
                                 
                                                                  WHERE  L.OWNERID = 716                  
                           AND L.LeadID = @Lead_ID         
                   and isnull(DMS_5.DMS_ex5_5,'')!= 'Inactive'            
                                                                         AND d.ItemName LIKE '%Sukkuk Murabaha Agreement%')) THEN 'Yes'                  
                  
                  
               ELSE 'No'                  
             END AS 'Sukkuk_Murabaha_Agreement'        
            
        
                 
  END 