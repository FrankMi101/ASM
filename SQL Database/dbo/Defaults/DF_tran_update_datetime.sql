CREATE DEFAULT [dbo].[DF_tran_update_datetime]
    AS getdate();


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_hist_tip].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_tip_0521].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_tip].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_tip_jlu].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequisition_Monthly_Request].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_hist_tip_old].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_tip_0515].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_ISA_equipments].[Load_date]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblcities].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_historical].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_carrier_orders].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_hist_tip_2only].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_tip_2only].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_iep_student_ProvincialAssessment].[last_update_date]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblRequest_Individual_hist].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblSummer_Schools].[last_update_date_time]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_tran_update_datetime]', @objname = N'[dbo].[tcdsb_tran_tblCarriers].[last_update_date_time]';

