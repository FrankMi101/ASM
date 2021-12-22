CREATE DEFAULT [dbo].[DF_Security_Extend]
    AS '.MDE';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_Security_Extend]', @objname = N'[dbo].[tcdsb_Security_applications].[application_Extend]';

