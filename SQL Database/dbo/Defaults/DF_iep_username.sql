CREATE DEFAULT [dbo].[DF_iep_username]
    AS user;


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_iep_username]', @objname = N'[dbo].[tcdsb_iep_decision_tree_new].[last_update_user]';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_iep_username]', @objname = N'[dbo].[tcdsb_tc_gal_interface].[last_update_uid]';

